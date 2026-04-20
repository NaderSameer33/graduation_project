import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_button.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiQuizView extends StatelessWidget {
  const AiQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
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
                'سنجرى لك اختبار قصير\n لنتمكن من عمل خطة دعم\n تناسب حالتك ',
                style: AppStyle.regular28.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              const Spacer(),
              AppButton(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.aiQuizOnBorading),
                title: 'ابدأ الان',
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
