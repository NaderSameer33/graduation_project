import '../../core/logic/app_routes.dart';
import '../../core/ui/app_back.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
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
                'ادخل كلمة مرور جديدة',
                style: AppStyle.regular28.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30.h,
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
              Text(
                'تأكيد كلمة المرور ',
                style: AppStyle.regular16,
              ),
              AppInput(
                topSpacing: 4.h,
                bottomSpacing: 8.h,
                hintText: 'مثل : Etmaen@77',
                prefixIcon: 'lock.svg',
              ),
              const SizedBox(
                height: 100,
              ),
              AppButton(
                onTap: () => Navigator.pushNamed(context, AppRoutes.login),
                title: 'كلمه مرور جديده',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
