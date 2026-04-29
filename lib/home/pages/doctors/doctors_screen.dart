import '../../../core/ui/app_input.dart';
import 'models/doctor_model.dart';
import 'widgets/doctor_banner.dart';
import 'widgets/doctor_grid_view.dart';
import 'widgets/doctor_header.dart';
import 'package:flutter/material.dart';
import '../../../core/ui/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPagestate();
}

class _DoctorsPagestate extends State<DoctorsPage> {
  final _searchCtrl = TextEditingController();
  final List<DoctorModel> _doctors = List.from(sampleDoctors);
  List<DoctorModel> _filtered = List.from(sampleDoctors);

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

  void _toggleFavorite(String id) {
    setState(() {
      final idx = _doctors.indexWhere((d) => d.id == id);
      if (idx != -1) _doctors[idx].isFavorite = !_doctors[idx].isFavorite;
      _filtered = List.from(_doctors);
    });
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
                child: ListView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 75,
                  ),

                  children: [
                    DoctorBanner(),

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
