import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPlanItem extends StatelessWidget {
  const AppPlanItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.isSelceted,
    required this.onTap,
  });
  final String title;
  final String subTitle;
  final bool isSelceted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 78.h,
        decoration: BoxDecoration(
          color: isSelceted ? AppColors.primiryColor : Colors.transparent,
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
      ),
    );
  }
}
