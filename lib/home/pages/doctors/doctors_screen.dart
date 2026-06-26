import '../../../core/logic/api/api_service.dart';
import '../../../core/ui/app_input.dart';
import 'models/doctor_model.dart';
import 'widgets/doctor_banner.dart';
import 'widgets/doctor_grid_view.dart';
import 'widgets/doctor_header.dart';
import '../home/widgets/podcast_list_view.dart';
import 'package:flutter/material.dart';
import '../../../core/ui/app_color.dart';
import '../../../core/ui/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPagestate();
}

class _DoctorsPagestate extends State<DoctorsPage> {
  final _searchCtrl = TextEditingController();
  List<DoctorModel> _doctors = [];
  List<DoctorModel> _filtered = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    setState(() => _isLoading = true);

    final res = await ApiService.authenticatedGet('doctors');
    if (!mounted) return;

    if (res.success && res.asList.isNotEmpty) {
      final list = res.asList;
      setState(() {
        _doctors = list
            .map((e) => DoctorModel.fromJson(e))
            .toList();
        _filtered = List.from(_doctors);
        _isLoading = false;
      });
    } else {
      // Fallback to sample data if API has no doctors yet
      setState(() {
        _doctors = List.from(sampleDoctors);
        _filtered = List.from(sampleDoctors);
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _filtered = query.isEmpty
          ? List.from(_doctors)
          : _doctors
                .where(
                  (d) => d.name.contains(query) || d.specialty.contains(query),
                )
                .toList();
    });
  }

  void _toggleFavorite(String id) async {
    final idx = _doctors.indexWhere((d) => d.id == id);
    if (idx == -1) return;

    final doctor = _doctors[idx];
    final wasFav = doctor.isFavorite;

    // Optimistic UI update
    setState(() {
      _doctors[idx].isFavorite = !wasFav;
      _filtered = List.from(_doctors);
    });

    // Call API to toggle favorite
    if (!wasFav) {
      await ApiService.authenticatedPost('favorite_toggle', {}, id: id);
    } else {
      await ApiService.delete('favorite_toggle', id: id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorHeader(
                doctors: _doctors,
              ),
              SizedBox(height: 16.h),

              AppInput(
                suffixIcon: 'menu.svg',
                prefixIcon: 'search.svg',
                hintText: 'ابحث عن دكتور .....',
                controller: _searchCtrl,
                onChanged: _onSearch,
              ),

              SizedBox(height: 16.h),

              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom + 75,
                        ),

                        children: [
                          DoctorBanner(),

                          SizedBox(height: 20.h),
                          
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'بودكاست مقترح',
                                  style: AppStyle.bold16,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          PodcastListView(),
                          
                          SizedBox(height: 20.h),

                          if (_filtered.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32),
                                child: Text(
                                  'لا يوجد أطباء مطابقون للبحث',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          else
                            DoctorGridView(
                              filtered: _filtered,
                              toogleFaourite: _toggleFavorite,
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
