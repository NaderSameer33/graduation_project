import 'dart:developer';

import '../../core/logic/app_routes.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_resent_code.dart';
import '../../core/ui/app_verfiy_code.dart';

import '../../core/ui/app_back.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpView extends StatelessWidget {
  const OtpView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final bool isFromForgetPassword = args == true;
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
                'ارسلنا لك كود ',
                style: AppStyle.regular28.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  const Text(
                    'علي الايميل example@gmail.com',
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('تغيير الايميل '),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              const AppVerfiyCode(),
              SizedBox(
                height: 50.h,
              ),
              AppButton(
                onTap: () => Navigator.pushNamed(
                  context,
                  isFromForgetPassword
                      ? AppRoutes.newPassword
                      : AppRoutes.login,
                ),
                title: 'تأكيد الرمز',
              ),
              SizedBox(
                height: 10.h,
              ),
              const AppResentCode(),
            ],
          ),
        ),
      ),
    );
  }
}
