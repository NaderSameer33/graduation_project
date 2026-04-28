import 'package:etmaen/core/ui/app_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';
import 'app_style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200.h,
              width: 200.w,

              child: FittedBox(
                fit: BoxFit.contain,
                child: AppImage(image: 'space_rocket.json'),
              ),
            ),
            Text(
              "تهانينا 🎉",
              style: AppStyle.regular28.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "سيتم تحميل خطتك بعد قليل...",
              textAlign: TextAlign.center,
              style: AppStyle.bold16.copyWith(
                color: AppColors.primiryColor,
              ),
            ),

            const SizedBox(height: 20),

            LoadingAnimationWidget.threeRotatingDots(
              color: AppColors.primiryColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
