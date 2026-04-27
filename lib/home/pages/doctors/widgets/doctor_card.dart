import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/doctors/models/doctor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key , 
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
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: AppImage(
                    image: 'doctor_nader.png',
                    height: 145.h,
                    width: 152.w,
                    fit: BoxFit.cover,
                  ),
                ),

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
            SizedBox(
              height: 5.h,
            ),

            Text(
              doctor.name,
              style: AppStyle.bold16,
            ),

            Text(
              doctor.specialty,
              style: AppStyle.regular12,
            ),

            Flexible(
              child: Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFAA00),
                    size: 14,
                  ),
                  SizedBox(width: 5.w),

                  Text(
                    doctor.rating.toString(),
                    style: AppStyle.regular16.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    '${doctor.price} جنية',
                    style: AppStyle.regular16.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
