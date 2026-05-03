import '../core/logic/app_routes.dart';
import '../core/ui/app_button.dart';
import '../core/ui/app_image.dart';
import '../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'اطمئن',
                    style: AppStyle.bold19,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'يقدم',
                    style: AppStyle.bold19.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              AppImage(
                topSpacing: 32.h,
                image: 'on_borading_1.png',
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                textAlign: TextAlign.center,
                'اطباء متخصصين',
                style: AppStyle.bold19.copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                textAlign: TextAlign.center,
                style: AppStyle.regular16,
                'يمكنك الaوصول الى نخبة من الأطباء \n والمتخصصين في العلاج المعرفي  السلوكي \n(CBT) ',
              ),
              SizedBox(
                height: 40.h,
              ),
              AppButton(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.onBorading);
                },
                title: 'ابدأ الان',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
