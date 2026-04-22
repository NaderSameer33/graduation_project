import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeFeelItem extends StatelessWidget {
  const HomeFeelItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(),
        );
      },
      child: Container(
        height: 68.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.avatarColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primiryColor,
                child: AppImage(image: 'feel.svg'),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'اشعر انني هادئ',
                style: AppStyle.regular16.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              Spacer(),

              AppImage(
                image: 'arrow.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
