import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTrackPointItem extends StatelessWidget {
  const ProfileTrackPointItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      height: 96.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.inputColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'اجمع نقاط الصحة النفسية واحصل على شخصية اقوى',
            style: AppStyle.bold12.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                'مستوى 1',
                style: AppStyle.bold12.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: LinearProgressIndicator(
                  minHeight: 8.h,
                  borderRadius: BorderRadius.circular(12.r),
                  backgroundColor: AppColors.blackColor,
                  color: AppColors.primiryColor,

                  value: .3,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                '220 / 120',
              ),
            ],
          ),
        ],
      ),
    );
  }
}