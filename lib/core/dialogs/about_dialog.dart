import '../ui/app_color.dart';
import '../ui/app_style.dart';
import 'package:flutter/material.dart';

class AboutDialog extends StatelessWidget {
  const AboutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'حول اطمئن',
        textAlign: TextAlign.right,
        style: AppStyle.bold16,
      ),
      content: Text(
        'اطمئن هو تطبيق دعم نفسي مبني على أسس العلاج المعرفي السلوكي (CBT). الإصدار 1.0.0',
        textAlign: TextAlign.right,
        style: AppStyle.bold12,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'حسناً',
            style: TextStyle(
              color: AppColors.primaryTop,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ],
    );
  }
}
