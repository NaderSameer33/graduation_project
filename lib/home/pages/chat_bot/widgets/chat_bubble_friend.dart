import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubbleBot extends StatelessWidget {
  const ChatBubbleBot({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.r),
        width: 314.w,
        decoration: BoxDecoration(
          color: AppColors.inputColor,
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
