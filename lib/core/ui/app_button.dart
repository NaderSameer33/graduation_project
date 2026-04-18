import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.onTap, required this.title});
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.primiryColor,
              AppColor.secondryColor,
            ],
          ),
        ),
        child: Text(
          title,
          style: AppStyle.bold16,
        ),
      ),
    );
  }
}
