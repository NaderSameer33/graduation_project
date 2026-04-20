import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AiAnialysisItem extends StatelessWidget {
  const AiAnialysisItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 50.h),
        AppImage(
          image: 'logo.png',
          height: 45.h,
        ),
        Text(
          textAlign: TextAlign.center,
          'اطمئن',
          style: AppStyle.regular16.copyWith(
            color: AppColors.primiryColor,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          textAlign: TextAlign.center,
          'جاري تحليل اجاباتك واعداد خطتك الان',
          style: AppStyle.regular28.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        SizedBox(
          height: 46.h,
        ),
        AppImage(
          image: 'ai.png',
          height: 134.h,
          width: 170.w,
        ),
        SizedBox(
          height: 20.h,
        ),
        LoadingAnimationWidget.threeRotatingDots(
          color: AppColors.primiryColor,
          size: 80.h,
        ),
      ],
    );
  }
}
