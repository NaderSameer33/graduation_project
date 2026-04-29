import 'package:etmaen/core/ui/app_button.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_secondry_button.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';

class RateDialog extends StatelessWidget {
  const RateDialog({
    super.key,
    required this.onLeaveMessage,
    required this.onRate,
  });

  final VoidCallback onLeaveMessage;
  final VoidCallback onRate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
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
            // Heart icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primaryTop.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: AppColors.primaryTop,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'هل اعجبك التطبيق؟',
              textAlign: TextAlign.center,
              style: AppStyle.bold16,
            ),
            const SizedBox(height: 8),
            Text(
              'رأيك يهمنا ويساعدنا على التطوير',
              textAlign: TextAlign.center,
              style: AppStyle.bold12,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: AppSecondryButton(
                title: 'اترك لنا رسالة',
                onTap: onLeaveMessage,
              ),
            ),
            const SizedBox(height: 10),
            AppButton(
              onTap: onRate,
              title: 'قم بتقييم التطبيق',
            ),
          ],
        ),
      ),
    );
  }
}