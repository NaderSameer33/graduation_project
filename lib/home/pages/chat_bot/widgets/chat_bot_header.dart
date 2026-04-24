import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';

class ChatBotHeader extends StatelessWidget {
  const ChatBotHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.avatarColor,
          child: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.home);
                },
                icon: AppImage(image: 'arrow_back.svg'),
              );
            },
          ),
        ),
        Spacer(),
        Text(
          'دردشة مع صديقك',
          style: AppStyle.bold16,
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: AppColors.avatarColor,
          child: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: AppImage(image: 'menu.svg'),
              );
            },
          ),
        ),
      ],
    );
  }
}
