import 'package:etmaen/core/logic/helper_method.dart';
import 'package:etmaen/core/ui/app_button.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';

class LeaveMessageDialog extends StatefulWidget {
  const LeaveMessageDialog({super.key});

  @override
  State<LeaveMessageDialog> createState() => _LeaveMessageDialogState();
}

class _LeaveMessageDialogState extends State<LeaveMessageDialog> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: AppImage(image: 'close.svg'),
              ),
            ),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryTop.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.primaryTop,
                size: 30,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'اترك لنا رسالة\nتساعدنا على التطوير',
              textAlign: TextAlign.center,
              style: AppStyle.bold16,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _ctrl,
                textAlign: TextAlign.right,
                maxLines: 4,
                style: AppStyle.bold12,
                decoration: const InputDecoration(
                  hintText:
                      'هل هناك شيء تود تحسينه او ميزة تود اضافتها ، شاركنا افكارك',
                  hintStyle: TextStyle(
                    color: AppColors.textDisabled,
                    fontFamily: 'Cairo',
                    fontSize: 12,
                  ),
                  contentPadding: EdgeInsets.all(12),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            AppButton(
              onTap: () {
                Navigator.pop(context);
                showSnak(
                  context: context,
                  title: 'تم ارسال رسالتك بنجاح',
                );
              },
              title: 'ارسال',
            ),
          ],
        ),
      ),
    );
  }
}
