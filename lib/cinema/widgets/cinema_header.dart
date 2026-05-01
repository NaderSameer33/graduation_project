import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaHeader extends StatelessWidget {
  const CinemaHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppBack(),
        SizedBox(
          width: 20.w,
        ),

        Text(
          'سينما اطئن',
          style: AppStyle.bold16,
        ),
      ],
    );
  }
}
