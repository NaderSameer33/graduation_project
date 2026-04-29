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
      onDelete: () {
        Navigator.pop(context);
      },
    ),
  );
}
