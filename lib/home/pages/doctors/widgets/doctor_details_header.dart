import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsHeader extends StatefulWidget {
  const DoctorDetailsHeader({super.key});

  @override
  State<DoctorDetailsHeader> createState() => _DoctorDetailsHeaderState();
}

class _DoctorDetailsHeaderState extends State<DoctorDetailsHeader> {
  bool _isFavorite = false;

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
            image: 'doctor_nader.png',
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
            onTap: () => setState(() => _isFavorite = !_isFavorite),
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: _isFavorite ? Colors.red : Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
