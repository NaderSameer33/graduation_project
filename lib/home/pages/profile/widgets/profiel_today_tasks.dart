import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTodayTasks extends StatefulWidget {
  const ProfileTodayTasks({super.key});

  @override
  State<ProfileTodayTasks> createState() => _ProfileTodayTasksState();
}

class _ProfileTodayTasksState extends State<ProfileTodayTasks> {
  final list = [
    ProfileTodayModel(
      title: 'مشاهدة جلسات المستوى\n الاول ',
      subTitle: 'ابدا الان',
      onTap: () {},
    ),
    ProfileTodayModel(
      title: 'تنفيذ 4 تحديات علاجية  من اختيارك',
      subTitle: 'ابدا الان',
      onTap: () {},
    ),
    ProfileTodayModel(
      title: 'تحديد فكرة مزعجة لك  ومناقشتها مع البوت',
      subTitle: 'ابدا الان',
      onTap: () {},
    ),
  ];
  bool isDone = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      height: 414.h,
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => list[index].onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: AppColors.avatarColor,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: 16.h,
                      width: 16.w,
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppColors.profileColor
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 70,
                    width: 1,
                    decoration: BoxDecoration(
                      color: isDone
                          ? AppColors.profileColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 14.w,
              ),

              Container(
                padding: EdgeInsets.all(12.r),
                margin: EdgeInsets.only(bottom: 20.h),
                height: 106.h,
                width: 246.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.blackColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list[index].title,
                      style: AppStyle.bold16,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      list[index].subTitle,
                      style: AppStyle.regular12,
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

class ProfileTodayModel {
  final String title, subTitle;
  final VoidCallback onTap;
  const ProfileTodayModel({
    required this.title,
    required this.subTitle,
    required this.onTap,
  });
}
