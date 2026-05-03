import '../../../../core/ui/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTrackModeItem extends StatefulWidget {
  const ProfileTrackModeItem({super.key});

  @override
  State<ProfileTrackModeItem> createState() => _ProfileTrackModeItemState();
}

class _ProfileTrackModeItemState extends State<ProfileTrackModeItem> {
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      alignment: Alignment.center,
      height: 52.h,
      width: 46.w,
      decoration: BoxDecoration(
        color: isTap ? AppColors.whiteColor : AppColors.blackColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text('😎'),
    );
  }
}
