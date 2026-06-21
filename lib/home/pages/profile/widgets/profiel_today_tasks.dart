import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/logic/app_routes.dart';

class ProfileTodayTasks extends StatelessWidget {
  final List<bool> taskStatus;
  final Function(int) onToggleTask;

  const ProfileTodayTasks({
    super.key,
    required this.taskStatus,
    required this.onToggleTask,
  });

  @override
  Widget build(BuildContext context) {
    final list = [
      ProfileTodayModel(
        title: 'مشاهدة جلسات المستوى الاول',
        subTitle: 'ابدا الان',
        onTap: () {
          // Go to learning tab or category
          Navigator.pushNamed(context, AppRoutes.learning);
        },
      ),
      ProfileTodayModel(
        title: 'تنفيذ 4 تحديات علاجية من اختيارك',
        subTitle: 'ابدا الان',
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.challenges);
        },
      ),
      ProfileTodayModel(
        title: 'تحديد فكرة مزعجة لك ومناقشتها مع البوت',
        subTitle: 'ابدا الان',
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.chatBot);
        },
      ),
    ];

    return Container(
      padding: EdgeInsets.all(20.r),
      // No fixed height — let content size naturally to avoid overflow
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(list.length, (index) {
          final isCompleted = index < taskStatus.length ? taskStatus[index] : false;
          final isNextCompleted =
              (index + 1) < taskStatus.length ? taskStatus[index + 1] : false;
          final isLast = index == list.length - 1;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Left column: circle + connector line ──
              GestureDetector(
                onTap: () => onToggleTask(index),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor: AppColors.avatarColor,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 16.h,
                        width: 16.w,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? AppColors.profileColor
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: isCompleted
                            ? const Icon(Icons.check, color: Colors.white, size: 10)
                            : null,
                      ),
                    ),
                    if (!isLast) ...[
                      SizedBox(height: 4.h),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        // Use a fixed connector height that matches the card
                        height: 72.h,
                        width: 2.w,
                        decoration: BoxDecoration(
                          color: isCompleted && isNextCompleted
                              ? AppColors.profileColor
                              : Colors.white12,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 14.w),
              // ── Right column: task card ──
              Expanded(
                child: GestureDetector(
                  onTap: () => list[index].onTap(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    margin: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
                    constraints: BoxConstraints(minHeight: 72.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColors.blackColor,
                      border: Border.all(
                        color: isCompleted
                            ? AppColors.profileColor.withOpacity(0.4)
                            : Colors.white12,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Trash / reset button on far left
                        if (isCompleted)
                          GestureDetector(
                            onTap: () => onToggleTask(index),
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: Icon(
                                Icons.restart_alt_rounded,
                                color: Colors.white30,
                                size: 18.r,
                              ),
                            ),
                          ),
                        if (isCompleted) SizedBox(width: 8.w),
                        // Text block
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                list[index].title,
                                style: AppStyle.bold12.copyWith(
                                  color: isCompleted
                                      ? Colors.white38
                                      : Colors.white,
                                  decoration: isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  decorationColor: Colors.white38,
                                ),
                                textAlign: TextAlign.right,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                isCompleted ? 'تم الانجاز ✓' : list[index].subTitle,
                                style: AppStyle.regular12.copyWith(
                                  color: isCompleted
                                      ? AppColors.profileColor
                                      : AppColors.primiryColor,
                                ),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class ProfileTodayModel {
  final String title, subTitle;
  final VoidCallback onTap;
  const ProfileTodayModel({
    required this.title,
    required this.subTitle,
    required this.onTap,
  });
}
