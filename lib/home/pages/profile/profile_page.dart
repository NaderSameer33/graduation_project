import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/home/pages/profile/widgets/profiel_today_tasks.dart';
import 'package:etmaen/home/pages/profile/widgets/profile_header.dart';
import 'package:etmaen/home/pages/profile/widgets/profile_track_point_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              ProfileHeader(),
              SizedBox(
                height: 32.h,
              ),
              ProfileTrackPointItem(),
              SizedBox(
                height: 16.h,
              ),
              ProfileTodayTasks(),
            ],
          ),
        ),
      ),
    );
  }
}
