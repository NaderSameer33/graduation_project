import '../../../core/logic/app_routes.dart';
import '../../../core/ui/app_color.dart';
import '../../../core/ui/app_style.dart';
import '../home/widgets/therapeutic_content_header.dart';
import 'widgets/profiel_today_tasks.dart';
import 'widgets/profiel_track_mode_item.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_track_point_item.dart';
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
              Text(
                'مهام الاسبوع',
                style: AppStyle.bold16,
              ),
              SizedBox(
                height: 16.h,
              ),
              ProfileTodayTasks(),
              SizedBox(
                height: 16.h,
              ),
              TherapeuticContentHeader(
                title: 'متتبع حالتك المزاجية ',
                isProfile: true,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.trackMode);
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 106.h,
                decoration: BoxDecoration(
                  color: AppColors.inputColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      6,
                      (index) => Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text(
                              'ن',
                              style: AppStyle.regular16.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ProfileTrackModeItem(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
