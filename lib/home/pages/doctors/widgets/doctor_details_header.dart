import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsHeader extends StatelessWidget {
  const DoctorDetailsHeader(
      {super.key,
      this.imageUrl,
      this.isFavorite = false,
      this.onFavoriteToggle});
  final String? imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r),
          ),
          child: AppImage(
            width: double.infinity,
            image: imageUrl ?? 'doctor_nader.png',
            height: 271.h,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 20.h,
          right: 20.w,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.expand_more_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
        Positioned(
          top: 20.h,
          left: 20.w,
          child: GestureDetector(
            onTap: onFavoriteToggle,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: isFavorite ? Colors.red : Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
