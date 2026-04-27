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
    this.controller,
    this.onChanged,
    this.suffixIcon,
    this.maxLines,
  });
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final double topSpacing, bottomSpacing;
  final TextEditingController? controller;
  final int? maxLines;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topSpacing, bottom: bottomSpacing),
      child: TextFormField(
        maxLines: maxLines,
        onChanged: onChanged,
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null ? AppImage(image: suffixIcon!) : null,
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
