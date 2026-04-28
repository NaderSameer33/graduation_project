import 'package:etmaen/home/pages/doctors/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/ui/app_color.dart';

import 'package:etmaen/home/pages/doctors/doctor_detail_screen.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key, this.favoriteDoctors = const []});

  final List<DoctorModel> favoriteDoctors;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<DoctorModel> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = widget.favoriteDoctors.isNotEmpty
        ? List.from(widget.favoriteDoctors)
        : _sampleFavorites();
  }

  List<DoctorModel> _sampleFavorites() {
    return [
      DoctorModel(
        id: 'f1',
        name: 'د محمد الامام',
        specialty: 'دكتوراة في الطب النفسي',
        rating: 4.9,
        price: 400,
        isTopRated: true,
        isFavorite: true,
      ),
      DoctorModel(
        id: 'f2',
        name: 'د محمد الامام',
        specialty: 'دكتوراة في الطب النفسي',
        rating: 4.9,
        price: 400,
        isTopRated: true,
        isFavorite: true,
      ),
      DoctorModel(
        id: 'f3',
        name: 'د محمد الامام',
        specialty: 'دكتوراة في الطب النفسي',
        rating: 4.8,
        price: 400,
        isTopRated: false,
        isFavorite: true,
      ),
      DoctorModel(
        id: 'f4',
        name: 'د محمد الامام',
        specialty: 'دكتوراة في الطب النفسي',
        rating: 4.8,
        price: 400,
        isTopRated: false,
        isFavorite: true,
      ),
    ];
  }

  void _removeFavorite(String id) {
    setState(() {
      _favorites.removeWhere((d) => d.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // ── Header ──────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Row(
                  children: [
                    // Back button — only shown when there's a route to pop to
                    if (Navigator.canPop(context))
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // arrow_back_ios_new works correctly for RTL back navigation
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      )
                    else
                      const SizedBox(width: 36),
                    const Spacer(),
                    const Text(
                      'الدكاترة المفضلة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Balance the header — same width as back button on right side
                    const Spacer(),
                    const SizedBox(width: 36),
                  ],
                ),
              ),

              // ── Content ──────────────────────────
              Expanded(
                child: _favorites.isEmpty
                    ? _EmptyFavorites()
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                        itemCount: _favorites.length,
                        itemBuilder: (_, i) {
                          final doc = _favorites[i];
                          return _FavDoctorCard(
                            doctor: doc,
                            onRemoveFavorite: () =>
                                _removeFavorite(doc.id),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DoctorDetailScreen(
                                  doctorName: doc.name,
                                  specialty: doc.specialty,
                                  rating: doc.rating,
                                  sessionPrice: doc.price,
                                  experience: doc.experience,
                                  reviewCount: doc.reviewCount,
                                  sessionDuration: doc.sessionDuration,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────
class _EmptyFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_border_rounded,
              color: AppColors.textDisabled, size: 60),
          SizedBox(height: 16),
          Text(
            'لم تضف أي دكتور للمفضلة بعد',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontFamily: 'Cairo',
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Favorite Doctor Card ──────────────────────
class _FavDoctorCard extends StatelessWidget {
  const _FavDoctorCard({
    required this.doctor,
    required this.onRemoveFavorite,
    required this.onTap,
  });

  final DoctorModel doctor;
  final VoidCallback onRemoveFavorite;
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
            // ── Photo area ──────────────────────
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16)),
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
                  // Heart icon — trailing corner (top-left visually in RTL)
                  PositionedDirectional(
                    top: 8,
                    end: 8,
                    child: GestureDetector(
                      onTap: onRemoveFavorite,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  // Badge — leading corner (top-right visually in RTL)
                  if (doctor.isTopRated)
                    PositionedDirectional(
                      top: 8,
                      start: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
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
            // ── Info area ───────────────────────
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                    Row(
                      children: [
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
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFFFAA00), size: 14),
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
