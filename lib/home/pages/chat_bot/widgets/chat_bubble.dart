import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.r),
        width: 314.w,
        decoration: BoxDecoration(
          color: AppColors.primiryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          title,
          style: AppStyle.regular16.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}