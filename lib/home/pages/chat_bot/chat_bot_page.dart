import '../../../core/ui/app_color.dart';
import '../../../core/ui/app_image.dart';
import '../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            children: [
              Row(
                children: [
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
