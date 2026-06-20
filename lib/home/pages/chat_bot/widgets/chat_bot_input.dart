import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import '../cubit/chat_bot_cubit.dart';
import 'chat_bot_input_fild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotInput extends StatefulWidget {
  const ChatBotInput({super.key});

  @override
  State<ChatBotInput> createState() => _ChatBotInputState();
}

class _ChatBotInputState extends State<ChatBotInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<ChatBotCubit>().sendMessage(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChatBotInputFild(
            controller: _controller,
            onSubmitted: _send,
          ),
        ),
        SizedBox(width: 15.w),
        CircleAvatar(
          radius: 25.r,
          backgroundColor: AppColors.inputColor,
          child: IconButton(
            onPressed: _send,
            icon: AppImage(image: 'send.svg'),
          ),
        ),
      ],
    );
  }
}
