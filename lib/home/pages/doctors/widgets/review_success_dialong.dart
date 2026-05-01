import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewSuccessDialog extends StatelessWidget {
  const ReviewSuccessDialog({required this.onDone, super.key});
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImage(
              image: 'success.json',
              height: 200,
              width: 200,
            ),
            const Text(
              'تم إرسال مراجعتك بنجاح',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            const Text(
              'شكراً لمشاركتنا تجربتك',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: onDone,
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryTop, AppColors.primaryBot],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    'حسناً',
                    style: AppStyle.bold16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
