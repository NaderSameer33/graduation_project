import '../../core/logic/app_routes.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_color.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isActive = false;
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
                'انشاء حساب',
                style: AppStyle.regular28.copyWith(
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'عضو مسجل بالفعل',
                      style: AppStyle.bold16,
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.login,
                            ),
                            child: Text(
                              'تسجيل الدخول',
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
                'ادخل اسمك | اسم مستعار',
                style: AppStyle.regular16,
              ),
              AppInput(
                topSpacing: 4.h,
                bottomSpacing: 16.h,
                hintText: 'مثل : نادر',
                prefixIcon: 'person.svg',
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
              Row(
                children: [
                  Transform.scale(
                    scale: 1.5.h,

                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: AppColors.primiryColor,

                      value: isActive,
                      onChanged: (value) {
                        isActive = value!;
                        setState(() {});
                      },
                    ),
                  ),
                  Text(
                    'تذكرني المرة القادمة',
                    style: AppStyle.regular16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              AppButton(
                onTap: () => Navigator.pushNamed(context, AppRoutes.otp),
                title: 'انشاء حساب',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
