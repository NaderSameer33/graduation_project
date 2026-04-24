import '../../core/ui/app_color.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationListViewItem extends StatelessWidget {
  const NotificationListViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.r),
      padding: EdgeInsets.all(12.r),
      height: 76.h,
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppImage(
            image: 'logo.png',
            height: 41.h,
            width: 44.w,
          ),
          SizedBox(
            width: 16.r,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تمرين تنفس جديد',
                  style: AppStyle.bold16,
                ),
                SizedBox(
                  height: 10.h,
                ),

                Row(
                  children: [
                    Text(
                      'ابدأ معنا الأن ',
                      style: AppStyle.regular12.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'منذ دقيقة',
                      style: AppStyle.regular12.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(
                      width: 17.w,
                    ),
                    Container(
                      height: 5.h,
                      width: 5.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primiryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
