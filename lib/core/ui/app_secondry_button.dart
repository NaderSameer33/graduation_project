import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSecondryButton extends StatelessWidget {
  const AppSecondryButton({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size.fromHeight(56.h),
        side: const BorderSide(
          color: AppColors.primiryColor,
        ),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: AppStyle.bold16,
      ),
    );
  }
}
