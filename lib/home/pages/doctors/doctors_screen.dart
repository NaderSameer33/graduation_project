import 'package:etmaen/core/ui/app_input.dart';
import 'package:etmaen/home/pages/doctors/models/doctor_model.dart';
import 'package:etmaen/home/pages/doctors/widgets/doctor_banner.dart';
import 'package:etmaen/home/pages/doctors/widgets/doctor_header.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'doctor_detail_screen.dart';

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
                prefixIcon: 'menu.svg',
                suffixIcon: 'search.svg',
                hintText: 'ابحث عن دكتور .....',
                controller: _searchCtrl,
                onChanged: _onSearch,
              ),

              const SizedBox(height: 16),

              Expanded(
                child: ListView(
                  children: [
                    DoctorBanner(),
                    const SizedBox(height: 20),

                    // ── Grid of doctors ─────────────
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
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.72,
                            ),
                        itemCount: _filtered.length,
                        itemBuilder: (_, i) => _DoctorCard(
                          doctor: _filtered[i],
                          onFavoriteToggle: () =>
                              _toggleFavorite(_filtered[i].id),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DoctorDetailScreen(
                                doctorName: _filtered[i].name,
                                specialty: _filtered[i].specialty,
                                rating: _filtered[i].rating,
                                sessionPrice: _filtered[i].price,
                                experience: _filtered[i].experience,
                                reviewCount: _filtered[i].reviewCount,
                                sessionDuration: _filtered[i].sessionDuration,
                              ),
                            ),
                          ),
                        ),
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

// ─────────────────────────────────────────────
//  Doctor Card (Grid item)
// ─────────────────────────────────────────────
class _DoctorCard extends StatelessWidget {
  const _DoctorCard({
    required this.doctor,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  final DoctorModel doctor;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Photo area ────────────────────
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  // Avatar background
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person_rounded,
                        color: Color(0xFF555555),
                        size: 64,
                      ),
                    ),
                  ),
                  // Favorite button — trailing corner in RTL (top-left visually)
                  PositionedDirectional(
                    top: 8,
                    end: 8,
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          doctor.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: doctor.isFavorite ? Colors.red : Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  // Badge — leading corner in RTL (top-right visually)
                  if (doctor.isTopRated)
                    PositionedDirectional(
                      top: 8,
                      start: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF8C00),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'الأعلى تقييماً',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ── Info area ─────────────────────
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Name
                    Text(
                      doctor.name,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Specialty
                    Text(
                      doctor.specialty,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const Spacer(),
                    // Rating + Price row
                    Row(
                      children: [
                        // Price
                        Text(
                          '${doctor.price} جنية',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        // Rating
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFAA00),
                          size: 14,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          doctor.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
