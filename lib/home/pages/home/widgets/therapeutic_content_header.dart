import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TherapeuticContentHeader extends StatelessWidget {
  const TherapeuticContentHeader({
    super.key,
    required this.title,
    required this.onTap,
    this.isProfile = false,
  });
  final String title;
  final VoidCallback onTap;
  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyle.regular16.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: onTap,
          child: Text(
            isProfile ? 'رؤية السجل' : 'مشاهدة المزيد',
            style: AppStyle.bold12.copyWith(
              color: AppColors.inputHintColor,
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
