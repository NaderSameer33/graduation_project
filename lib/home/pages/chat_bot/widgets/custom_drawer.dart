import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import '../cubit/chat_bot_cubit.dart';
import '../cubit/chat_bot_state.dart';
import 'chat_bot_input_fild.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.blackColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 60.h),

            // ── Search bar ───────────────────────────────────────────────
            ChatBotInputFild(
              isSearch: true,
              controller: _searchController,
            ),
            SizedBox(height: 24.h),

            // ── New Chat Button ──────────────────────────────────────────
            InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {
                context.read<ChatBotCubit>().startNewChat();
                Navigator.pop(context); // Close drawer
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                child: Row(
                  children: [
                    AppImage(image: 'chat.svg'),
                    SizedBox(width: 8.w),
                    Text(
                      'دردشة جديدة',
                      style: TextStyle(
                        color: AppColors.primiryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    AppImage(
                      image: 'arrow.svg',
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),

            Text(
              'الدردشات السابقة',
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),

            // ── Dynamic Sessions List ────────────────────────────────────
            Expanded(
              child: BlocBuilder<ChatBotCubit, ChatBotState>(
                builder: (context, state) {
                  // Filter sessions by search query if any
                  final filteredSessions = state.sessions.where((session) {
                    if (_searchQuery.isEmpty) return true;
                    return session.title.toLowerCase().contains(_searchQuery) ||
                        session.messages.any((m) =>
                            m.text.toLowerCase().contains(_searchQuery));
                  }).toList();

                  if (filteredSessions.isEmpty) {
                    return Center(
                      child: Text(
                        _searchQuery.isEmpty
                            ? 'لا توجد محادثات سابقة'
                            : 'لا توجد نتائج مطابقة',
                        style: TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredSessions.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final session = filteredSessions[index];
                      final isActive = session.id == state.activeSessionId;

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {
                            context.read<ChatBotCubit>().selectSession(session.id);
                            Navigator.pop(context); // Close drawer
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 12.w,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.primiryColor.withAlpha(38) // ~0.15 opacity
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isActive
                                    ? AppColors.primiryColor.withAlpha(76) // ~0.3 opacity
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: [
                                // Active indicator dot
                                Container(
                                  height: 8.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isActive
                                        ? AppColors.primiryColor
                                        : AppColors.whiteColor.withAlpha(128),
                                  ),
                                ),
                                SizedBox(width: 12.w),

                                // Title text
                                Expanded(
                                  child: Text(
                                    session.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: isActive
                                          ? AppColors.whiteColor
                                          : AppColors.greyColor,
                                      fontWeight: isActive
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),

                                // Delete Session button
                                if (isActive)
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<ChatBotCubit>()
                                          .deleteSession(session.id);
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
