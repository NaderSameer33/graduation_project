import 'app_color.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppStyle {
  static TextStyle bold16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );
  static TextStyle regular20 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
  );
  static TextStyle regular37 = TextStyle(
    fontSize: 37.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.primiryColor,
  );
  static TextStyle regular28 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.primiryColor,
  );
  static TextStyle regular16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyColor,
  );
  static TextStyle regular12 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyColor,
  );
  static TextStyle bold19 = TextStyle(
    fontSize: 19.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primiryColor,
  );
  static TextStyle bold24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );
  static TextStyle bold12 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primiryColor,
  );
}

class AppTextStyles {
  AppTextStyles._();
  static const TextStyle heading28White = TextStyle(color: AppColors.textWhite, fontSize: 28, fontFamily: 'Cairo', fontWeight: FontWeight.w700);
  static const TextStyle heading24White = TextStyle(color: AppColors.textWhite, fontSize: 24, fontFamily: 'Cairo', fontWeight: FontWeight.w700);
  static const TextStyle heading20White = TextStyle(color: AppColors.textWhite, fontSize: 20, fontFamily: 'Cairo', fontWeight: FontWeight.w700);
  static const TextStyle heading19White = TextStyle(color: AppColors.textWhite, fontSize: 19, fontFamily: 'Cairo', fontWeight: FontWeight.w700);
  static const TextStyle heading28Normal = TextStyle(color: AppColors.textWhite, fontSize: 28, fontFamily: 'Cairo', fontWeight: FontWeight.w400);
  static const TextStyle body16White = TextStyle(color: AppColors.textWhite, fontSize: 16, fontFamily: 'Cairo', fontWeight: FontWeight.w400);
  static const TextStyle body16Bold = TextStyle(color: AppColors.textWhite, fontSize: 16, fontFamily: 'Cairo', fontWeight: FontWeight.w700);
  static const TextStyle body16Secondary = TextStyle(color: AppColors.textSecondary, fontSize: 16, fontFamily: 'Cairo', fontWeight: FontWeight.w400);
  static const TextStyle body16Primary = TextStyle(color: AppColors.textPrimary, fontSize: 16, fontFamily: 'Cairo', fontWeight: FontWeight.w700);
  static const TextStyle body16Disabled = TextStyle(color: AppColors.textDisabled, fontSize: 16, fontFamily: 'Cairo', fontWeight: FontWeight.w700);
  static const TextStyle body12Secondary = TextStyle(color: AppColors.textSecondary, fontSize: 12, fontFamily: 'Cairo', fontWeight: FontWeight.w400);
  static const TextStyle brandAccent19 = TextStyle(color: AppColors.textAccent, fontSize: 19, fontFamily: 'Cairo', fontWeight: FontWeight.w700);
  static const TextStyle brandAccent18 = TextStyle(color: AppColors.textAccent, fontSize: 18, fontFamily: 'Alexandria', fontWeight: FontWeight.w400);
  static const TextStyle brandAccent28 = TextStyle(color: AppColors.textAccent, fontSize: 28, fontFamily: 'Cairo', fontWeight: FontWeight.w400);
  static const TextStyle caption8Primary = TextStyle(color: AppColors.textPrimary, fontSize: 8, fontFamily: 'Cairo', fontWeight: FontWeight.w700);
  static const TextStyle forgotPassword = TextStyle(color: AppColors.textPrimary, fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w600);
}

class AppDecorations {
  AppDecorations._();
  static ShapeDecoration inputField = ShapeDecoration(color: AppColors.card, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));
  static ShapeDecoration inputFieldBordered = ShapeDecoration(color: AppColors.card, shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: AppColors.stroke), borderRadius: BorderRadius.circular(12)));
  static ShapeDecoration primaryButton = const ShapeDecoration(gradient: AppGradients.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))));
  static ShapeDecoration outlinedButton = ShapeDecoration(shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: AppColors.primaryTop), borderRadius: BorderRadius.circular(32)));
  static const ShapeDecoration backButton = ShapeDecoration(gradient: AppGradients.backButton, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))));
  static ShapeDecoration otpBox = ShapeDecoration(color: AppColors.card, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
}
