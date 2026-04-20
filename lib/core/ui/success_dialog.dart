import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
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
