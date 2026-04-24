import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotInput extends StatelessWidget {
  const ChatBotInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32.r),

            child: TextField(
              style: AppStyle.bold16,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: AppImage(image: 'emoge.svg'),
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: AppImage(image: 'sticker.svg'),
                ),
                fillColor: AppColors.inputColor,
                filled: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ),

        SizedBox(
          width: 15.w,
        ),
        CircleAvatar(
          radius: 25.r,
          backgroundColor: AppColors.inputColor,
          child: IconButton(
            onPressed: () {},
            icon: AppImage(image: 'send.svg'),
          ),
        ),
      ],
    );
  }
}
