import 'package:etmaen/core/ui/app_color.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppStyle {
  static TextStyle bold16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.whiteColor,
  );
  static TextStyle regular37 = TextStyle(
    fontSize: 37.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.primiryColor,
  );
  static TextStyle regular16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.greyColor,
  );
  static TextStyle bold19 = TextStyle(
    fontSize: 19.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.primiryColor,
  );
}
