import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPlanItem extends StatelessWidget {
  const AppPlanItem({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: BoxBorder.all(
          color: AppColors.greyColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppStyle.regular16.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            subTitle,
            style: AppStyle.regular16.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
