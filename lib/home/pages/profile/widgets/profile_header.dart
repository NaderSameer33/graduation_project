import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(
          height: 49.h,
          width: 49.w,
          image: 'person.png',
          isCircle: true,
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          children: [
            Text(
              'نادر سمير',
              style: AppStyle.bold16,
            ),
            Text(
              'المستوي الاول',
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: AppColors.avatarColor,
          child: IconButton(
            onPressed: () {},
            icon: AppImage(image: 'setting.svg'),
          ),
        ),
      ],
    );
  }
}
