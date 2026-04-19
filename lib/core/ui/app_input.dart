import 'app_color.dart';
import 'app_image.dart';
import 'app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.topSpacing = 0,
    this.bottomSpacing = 0,
  });
  final String hintText;
  final String? prefixIcon;
  final double topSpacing, bottomSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topSpacing, bottom: bottomSpacing),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? AppImage(image: prefixIcon!) : null,
          hintText: hintText,
          hintStyle: AppStyle.bold16.copyWith(color: AppColors.inputHintColor),
          filled: true,
          fillColor: AppColors.inputColor,
          border: buildBorder(),
          focusedBorder: buildBorder(),
          enabledBorder: buildBorder(),
        ),
      ),
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
  );
}
