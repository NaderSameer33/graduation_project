import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/on_borading/model/on_borading_model.dart';
import 'package:etmaen/welocme_login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoradingItem extends StatelessWidget {
  const OnBoradingItem({
    super.key,
    required this.model,
    required this.index,
    required this.pageController,
  });
  final OnBoradingModel model;
  final int index;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.welcomeLogin),
                child: Text(
                  'تخطي',
                  style: AppStyle.bold16,
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
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
              image: model.image,
            ),
            SizedBox(
              height: index == 2 ? 80.h : 8.h,
            ),
            Text(
              textAlign: TextAlign.center,
              model.title,
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
              model.subtitle,
            ),
            SizedBox(
              height: 40.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 32.r,
                backgroundColor: AppColor.primiryColor,
                child: IconButton(
                  onPressed: () => index == 4
                      ? Navigator.pushNamed(context, AppRoutes.welcomeLogin)
                      : pageController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        ),

                  icon: const AppImage(image: 'arrow.svg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
