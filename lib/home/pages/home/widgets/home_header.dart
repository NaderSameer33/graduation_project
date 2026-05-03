import '../../../../core/logic/app_routes.dart';
import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Column(
          children: [
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
          ],
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: AppColors.avatarColor,
          radius: 20.r,
          child: IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.notifaction),
            icon: AppImage(image: 'pin.svg'),
          ),
        ),
      ],
    );
  }
}
