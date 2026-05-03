import 'app_color.dart';
import 'app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBack extends StatelessWidget {
  const AppBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CircleAvatar(
        backgroundColor: AppColors.avatarColor,
        radius: 20.r,
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const AppImage(image: 'arrow_back.svg'),
        ),
      ),
    );
  }
}
