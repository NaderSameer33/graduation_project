import '../logic/helper_method.dart';
import '../ui/app_button.dart';
import '../ui/app_color.dart';
import '../ui/app_image.dart';
import '../ui/app_style.dart';
import 'package:flutter/material.dart';

class SupportDialog extends StatefulWidget {
  const SupportDialog({super.key});

  @override
  State<SupportDialog> createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog> {
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
            SizedBox(
              height: 100,
              child: FittedBox(
                fit: BoxFit.contain,
                child: AppImage(
                  image: 'support.json',
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'هل واجهتك مشكلة ؟',
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
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontSize: 13,
                ),
                decoration: const InputDecoration(
                  hintText: 'اكتب سؤالك وسنتواصل معك في اقرب وقت',
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
                  title: 'تم ارسال استفسارك بنجاح ، سنتواصل معك قريباً',
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
