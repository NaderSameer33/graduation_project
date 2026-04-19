import '../../core/logic/app_routes.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_color.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                height: 80.h,
              ),
              Text(
                'تسجيل الدخول',
                style: AppStyle.regular28.copyWith(
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'عضو جديد',
                      style: AppStyle.bold16,
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.register,
                            ),
                            child: Text(
                              'انشاء حساب',
                              style: AppStyle.bold16.copyWith(
                                color: AppColors.primiryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
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
              Text(
                'ادخل كلمة المرور ',
                style: AppStyle.regular16,
              ),
              AppInput(
                topSpacing: 4.h,
                bottomSpacing: 8.h,
                hintText: 'مثل : Etmaen@77',
                prefixIcon: 'lock.svg',
              ),
              TextButton(
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.forgetPassword),
                child: Text(
                  'نسيت كلمة المرور ؟',
                  style: AppStyle.bold16.copyWith(
                    color: AppColors.primiryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              AppButton(
                onTap: () => Navigator.pushNamed(context, AppRoutes.aiQuiz),
                title: 'تسجيل الدخول',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
