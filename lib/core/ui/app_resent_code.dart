import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResentCode extends StatefulWidget {
  const AppResentCode({super.key});

  @override
  State<AppResentCode> createState() => _AppResentCodeState();
}

class _AppResentCodeState extends State<AppResentCode> {
  bool isResend = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'لم تستلم رمز ؟',
          style: AppStyle.regular16.copyWith(
            color: Colors.white,
          ),
        ),

        if (isResend)
          CircularCountDownTimer(
            textStyle: AppStyle.bold16.copyWith(
              color: AppColors.inputHintColor,
            ),
            isReverse: true,
            textFormat: CountdownTextFormat.MM_SS,
            width: 50.w,
            height: 50.h,
            duration: 90,
            fillColor: Colors.transparent,
            ringColor: Colors.transparent,
            onComplete: () {
              isResend = false;
              setState(() {});
            },
          )
        else
          TextButton(
            onPressed: () {
              isResend = true;
              setState(() {});
            },
            child: Text(
              'أعد الارسال',
              style: AppStyle.bold16.copyWith(
                color: AppColors.primiryColor,
              ),
            ),
          ),
      ],
    );
  }
}
