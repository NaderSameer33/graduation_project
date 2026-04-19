import 'package:etmaen/core/ui/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppVerfiyCode extends StatelessWidget {
  const AppVerfiyCode({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autoFocus: true,
      keyboardType: TextInputType.number,

      cursorColor: AppColors.inputHintColor,
      cursorWidth: 5.5.w,
      cursorHeight: 30.h,
      animationType: AnimationType.scale,
      animationDuration: const Duration(milliseconds: 500),
      appContext: context,
      length: 4,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        fieldHeight: 74.h,
        fieldWidth: 74.w,
        borderRadius: BorderRadius.circular(8.r),
        activeColor: AppColors.primiryColor,
        inactiveColor: AppColors.inputColor,
        selectedColor: AppColors.primiryColor,
        activeFillColor: AppColors.primiryColor,
        inactiveFillColor: AppColors.inputColor,
        selectedFillColor: AppColors.primiryColor,
      ),
    );
  }
}
