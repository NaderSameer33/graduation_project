import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import 'chat_bot_input_fild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotInput extends StatelessWidget {
  const ChatBotInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChatBotInputFild(),
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
