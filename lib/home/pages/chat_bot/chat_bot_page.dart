import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({
    super.key,
  });

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      openRatio: .6,
      childDecoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      backdropColor: AppColors.inputColor,
      controller: _advancedDrawerController,
      drawer: SafeArea(
        child: Column(
          children: [
            Text('nader'),
          ],
        ),
      ),
      child: Scaffold(
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
                              _advancedDrawerController.showDrawer();
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
      ),
    );
  }
}
