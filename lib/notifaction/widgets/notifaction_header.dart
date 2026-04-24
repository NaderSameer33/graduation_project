
import '../../core/ui/app_color.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';

class NotifactionHeader extends StatelessWidget {
  const NotifactionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.avatarColor,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: AppImage(
              image: 'arrow_back.svg',
            ),
          ),
        ),
        Spacer(),
        Text(
          'الإشعارات',
          style: AppStyle.bold24,
        ),
        Spacer(),
      ],
    );
  }
}
