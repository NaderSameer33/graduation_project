import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TherapeuticContentHeader extends StatelessWidget {
  const TherapeuticContentHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'محتوى علاجي مخصص لك',
            style: AppStyle.regular16.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'مشاهدة المزيد',
              style: AppStyle.bold12.copyWith(
                color: AppColors.inputHintColor,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
