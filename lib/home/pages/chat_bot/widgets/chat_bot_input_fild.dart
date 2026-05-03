import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotInputFild extends StatelessWidget {
  const ChatBotInputFild({super.key, this.isSearch = false});

  final bool isSearch;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.r),

      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: isSearch ? AppStyle.bold12 : AppStyle.bold16,
        decoration: InputDecoration(
          hintText: isSearch ? 'البحث عن محادثة سابقة .....' : null,
          prefixIcon: IconButton(
            onPressed: () {},
            icon: AppImage(image: isSearch ? 'search.svg' : 'emoge.svg'),
          ),
          suffixIcon: isSearch
              ? null
              : IconButton(
                  onPressed: () {},
                  icon: AppImage(image: 'sticker.svg'),
                ),
          fillColor: AppColors.inputColor,
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
