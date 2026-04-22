import 'app_color.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppStyle {
  static TextStyle bold16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
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
}
