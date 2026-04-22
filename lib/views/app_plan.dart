import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_button.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/views/widgets/app_plan_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPlanView extends StatelessWidget {
  const AppPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.r),
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
                'اكتئاب خفيف',
                style: AppStyle.bold24,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                textAlign: TextAlign.center,
                'يبدو إنك بتمر بمرحلة فيها بعض المشاعر الثقيلة أو فقدان الحماس، وده طبيعي جدًا وممكن يحصل لأي حد. الجميل إن حالتك قابلة للتحسن بسهولة كبيرة بمجرد إنك تبدأ تهتم بنفسك أكتر وتاخد دعم بسيط من مختص.',

                style: AppStyle.bold16.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                textAlign: TextAlign.center,
                'العلاج السلوكي المعرفي (CBT) بيقدر يساعدك \nبشكل فعّال في إعادة تنظيم أفكارك ...قراءة المزيد ',
                style: AppStyle.bold16.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 36.h,
              ),
              AppPlanItem(
                isSelceted: true,
                onTap: () {},
                title: 'عدد المستويات',
                subTitle: '8',
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppPlanItem(
                      isSelceted: true,
                      onTap: () {},
                      title: 'عدد المستويات',
                      subTitle: '8',
                    ),
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  Expanded(
                    child: AppPlanItem(
                      isSelceted: true,
                      onTap: () {},
                      title: 'عدد المستويات',
                      subTitle: '8',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),

              AppButton(
                onTap: () => Navigator.pushNamed(context, AppRoutes.home),
                title: 'ابدأ رحلتك الآن',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
