import 'dart:typed_data';
import 'api/api_service.dart';
import 'app_routes.dart';
import 'user_prefs.dart';
import 'package:etmaen/home/pages/profile/settings/widgets/personal_setting_bottom_sheet.dart';

import '../dialogs/delete_account_dialog.dart';
import '../dialogs/leaving_message_dialog.dart';
import '../dialogs/rate_dialog.dart';
import '../dialogs/support_dialog.dart';
import '../ui/app_color.dart';
import '../ui/app_style.dart';
import 'package:flutter/material.dart';

void showSnak({required BuildContext context, required String title}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: AppStyle.bold16,
      ),
      backgroundColor: AppColors.primiryColor,
    ),
  );
}

void showSupportDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => SupportDialog(),
  );
}

void showAboutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AboutDialog(),
  );
}

void showRateDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => RateDialog(
      onLeaveMessage: () {
        Navigator.pop(context);
        showMessageDialog(context);
      },
      onRate: () {
        Navigator.pop(context);
        showSnak(
          context: context,
          title: 'شكراً لتقييمك التطبيق!',
        );
      },
    ),
  );
}

void showMessageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const LeaveMessageDialog(),
  );
}

void showDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => DeleteAccountDialog(
      onKeep: () => Navigator.pop(context),
      onDelete: () async {
        Navigator.pop(context); // Close dialog
        
        // Show loading indicator (optional but good UX)
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );

        final res = await ApiService.delete('deactivate');

        if (context.mounted) {
          Navigator.pop(context); // Close loading indicator
          if (res.success) {
            await UserPrefs.clearAll();
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
          } else {
            showSnak(context: context, title: res.error ?? 'فشل حذف الحساب');
          }
        }
      },
    ),
  );
}


  Future<Uint8List?> pickImage({
    required BuildContext context,
    Uint8List? currentAvatarBytes,
  }) async {
    return await showModalBottomSheet<Uint8List?>(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => PersonalSettingBottomSheet(
        currentAvatarBytes: currentAvatarBytes,
      ),
    );
  }
