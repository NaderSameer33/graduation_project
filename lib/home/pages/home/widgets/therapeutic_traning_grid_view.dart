import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TherapeuticTraningGridView extends StatelessWidget {
  const TherapeuticTraningGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        itemCount: 10,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,

        itemBuilder: (context, index) => TherapeuticTraningItem(),
      ),
    );
  }
}

class TherapeuticTraningItem extends StatelessWidget {
  const TherapeuticTraningItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.r),
      child: Column(
        children: [
          TheraputicTraningItemBody(),
          SizedBox(
            height: 20.h,
          ),
          TheraputicTraningItemBody(),
        ],
      ),
    );
  }
}

class TheraputicTraningItemBody extends StatelessWidget {
  const TheraputicTraningItemBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86.h,
      width: 308.w,
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.black.withValues(alpha: .2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: AppImage(image: 'music.svg'),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'تمرين صوتي  \t\t\t\t',
                        style: AppStyle.regular12,
                      ),
                      TextSpan(
                        text: '20 دقيقة',
                        style: AppStyle.regular12,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'دقيقة الانقاذ الصباحية',
                  style: AppStyle.regular16.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
