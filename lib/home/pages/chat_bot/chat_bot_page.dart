import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/chat_bot_cubit.dart';
import 'cubit/chat_bot_state.dart';
import 'models/chat_message_model.dart';
import 'widgets/chat_bot_header.dart';
import 'widgets/chat_bot_input.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_bubble_friend.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/typing_indicator.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBotCubit(),
      child: const _ChatBotView(),
    );
  }
}

class _ChatBotView extends StatefulWidget {
  const _ChatBotView();

  @override
  State<_ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<_ChatBotView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────────────
              const ChatBotHeader(),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocConsumer<ChatBotCubit, ChatBotState>(
                  listener: (context, state) {
                    // Scroll to bottom whenever a new message arrives
                    _scrollToBottom();
                  },
                  builder: (context, state) {
                    final messages = state.messages;
                    final isLoading = state is ChatBotLoading;

                    return Stack(
                      children: [
                        // ── Chat messages ──────────────────────────────
                        ListView.separated(
                          controller: _scrollController,
                          padding: EdgeInsets.only(
                            top: 8.h,
                            bottom: 90.h, // leave room for the input bar
                          ),
                          itemCount: messages.length + (isLoading ? 1 : 0),
                          separatorBuilder: (_, __) => SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            // Typing indicator as last item while loading
                            if (isLoading && index == messages.length) {
                              return const TypingIndicator();
                            }

                            final msg = messages[index];
                            return _MessageBubble(message: msg);
                          },
                        ),

                        // ── Input bar pinned to bottom ────────────────
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 5,
                          child: const ChatBotInput(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    if (message.isUser) {
      return ChatBubble(title: message.text);
    }
    return ChatBubbleBot(title: message.text);
  }
}
