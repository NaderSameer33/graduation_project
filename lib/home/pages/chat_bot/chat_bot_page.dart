import 'widgets/chat_bot_header.dart';
import 'widgets/chat_bot_input.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_bubble_friend.dart';
import 'widgets/custom_drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            children: [
              ChatBotHeader(),
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        ChatBubbleBot(
                          title: 'عرفني بنفسك ',
                        ),

                        SizedBox(
                          height: 32.h,
                        ),
                        ChatBubble(
                          title: 'انا مراد مساعدك الشخصي',
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        ChatBubbleBot(
                          title: 'كيف يمكنك مساعدتي',
                        ),

                        SizedBox(
                          height: 32.h,
                        ),
                        ChatBubble(
                          title:
                              'يمكنني دعمك نفسيا وتوجيهك للطبيب النفسي المناسب ومساعدتك لتحديد اهدافك وحل مشاكلك واعادة صياغة افكارك السلبية',
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        ChatBubbleBot(
                          title: 'كيف يمكنك مساعدتي',
                        ),

                        SizedBox(
                          height: 32.h,
                        ),
                        ChatBubble(
                          title:
                              'يمكنني دعمك نفسيا وتوجيهك للطبيب النفسي المناسب ومساعدتك لتحديد اهدافك وحل مشاكلك واعادة صياغة افكارك السلبية',
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        ChatBubbleBot(
                          title: 'كيف يمكنك مساعدتي',
                        ),

                        SizedBox(
                          height: 32.h,
                        ),
                        ChatBubble(
                          title:
                              'يمكنني دعمك نفسيا وتوجيهك للطبيب النفسي المناسب ومساعدتك لتحديد اهدافك وحل مشاكلك واعادة صياغة افكارك السلبية',
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        ChatBubbleBot(
                          title: 'كيف يمكنك مساعدتي',
                        ),

                        SizedBox(
                          height: 32.h,
                        ),
                        ChatBubble(
                          title:
                              'يمكنني دعمك نفسيا وتوجيهك للطبيب النفسي المناسب ومساعدتك لتحديد اهدافك وحل مشاكلك واعادة صياغة افكارك السلبية',
                        ),
                      ],
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 5,
                      child: ChatBotInput(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
