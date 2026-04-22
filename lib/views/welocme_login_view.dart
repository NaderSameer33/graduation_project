import '../core/logic/app_routes.dart';
import '../core/ui/app_button.dart';
import '../core/ui/app_image.dart';
import '../core/ui/app_secondry_button.dart';
import '../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeLoginView extends StatelessWidget {
  const WelcomeLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.h,
              ),
              AppImage(
                image: 'logo.png',
                height: 100.h,
                bottomSpacing: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'مرحبا بك في ',
                    style: AppStyle.regular28.copyWith(color: Colors.white),
                  ),
                  Text(
                    'اطمئن',
                    style: AppStyle.regular28,
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                textAlign: TextAlign.center,
                style: AppStyle.regular16.copyWith(color: Colors.white),
                'نحن نطبق مبادئ العلاج السلوكي المعرفي CBT \nنساعدك في اعادة تنظيم افكارك وفهم المشاعر\n اللي وراها، وده بيخليك تستعيد توازنك تدريجيًا \nبخطوات بسيطة وواضحة. ومع كل جلسة، هتحس \nإنك أقرب لنفسك الحقيقية وأقدر على إدارة  يومك براحه وثقه',
              ),
              const Spacer(),
              AppSecondryButton(
                title: 'عضو جديد',
                onTap: () => Navigator.pushNamed(context, AppRoutes.register),
              ),
              SizedBox(
                height: 16.h,
              ),
              AppButton(
                onTap: () => Navigator.pushNamed(context, AppRoutes.login),
                title: 'تسجيل الدخول',
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
