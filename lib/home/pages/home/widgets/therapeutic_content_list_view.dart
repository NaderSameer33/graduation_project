import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TherapeuticContentListView extends StatelessWidget {
  const TherapeuticContentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) => TherapeuticContentItem(),
    );
  }
}

class TherapeuticContentItem extends StatelessWidget {
  const TherapeuticContentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.r),
      height: 115.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.avatarColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            AppImage(
              image: 'worry.png',
              height: 88.h,
              width: 88.w,
            ),
            SizedBox(
              width: 12.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'المستوى الاول\t\t\t\t',
                        style: AppStyle.regular12,
                        children: [
                          TextSpan(
                            text: 'فيديو 1 \t\t\t\t',
                            style: AppStyle.regular12,
                          ),
                          TextSpan(
                            text: '20 دقيقة',
                            style: AppStyle.regular12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  textAlign: TextAlign.start,
                  'ما هو الاكتئاب الخفيف ؟',
                  style: AppStyle.regular16.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  textAlign: TextAlign.start,

                  'د نادر سمير ',
                  style: AppStyle.regular16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
