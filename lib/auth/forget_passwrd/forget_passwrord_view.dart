import 'package:etmaen/auth/otp/otp_view.dart';
import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_button.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_input.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswrordView extends StatelessWidget {
  const ForgetPasswrordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.h,
              ),
              const AppBack(),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'نسيت كلمة المرور',
                style: AppStyle.regular28.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    'سنرسل لك ',
                    style: AppStyle.regular16.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    'كود تسجيل الدخول',
                    style: AppStyle.regular16.copyWith(
                      color: AppColors.primiryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'ادخل البريد الالكتروني',
                style: AppStyle.regular16,
              ),
              AppInput(
                topSpacing: 4.h,
                bottomSpacing: 16.h,
                hintText: 'مثل : Etmaen@gmail.com',
                prefixIcon: 'email.svg',
              ),
              SizedBox(
                height: 40.h,
              ),
              AppButton(
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.otp,
                  arguments: true,
                ),
                title: 'ارسال الرمز',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
