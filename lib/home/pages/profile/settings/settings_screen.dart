import 'dart:typed_data';
import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/profile/settings/widgets/setting_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/logic/user_prefs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'personal_settings_screen.dart';
import 'package:etmaen/home/pages/pro/pro_content_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsOn = true;
  final bool _isPro = false;
  String _userName = UserPrefs.defaultName;
  Uint8List? _avatarBytes;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final p = await UserPrefs.loadProfile();
    if (!mounted) return;
    setState(() {
      _userName = p['name'] as String;
      _avatarBytes = p['avatarBytes'] as Uint8List?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  AppBack(),
                  const Spacer(),
                  Text('اعداداتك', style: AppStyle.bold16),
                  Spacer(),
                ],
              ),

              SizedBox(height: 16.h),
              SettingHeader(
                loadProfile: _loadProfile,
                userName: _userName,
                ispro: _isPro,
              ),

              const SizedBox(height: 16),

              _SettingsGroup(
                items: [
                  _SettingsItem(
                    icon: Icons.notifications_rounded,
                    label: 'الاشعارات',
                    trailing: Switch(
                      value: _notificationsOn,
                      onChanged: (v) => setState(() => _notificationsOn = v),
                      activeColor: AppColors.primaryTop,
                      inactiveTrackColor: AppColors.textDisabled,
                    ),
                  ),
                  _SettingsItem(
                    icon: Icons.workspace_premium_rounded,
                    label: 'ترقية الحساب الى برو',
                    showChevron: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProContentScreen(),
                      ),
                    ),
                  ),
                  _SettingsItem(
                    icon: Icons.headset_mic_rounded,
                    label: 'الدعم والمساعدة',
                    showChevron: true,
                    onTap: () => _showSupportDialog(context),
                  ),
                  _SettingsItem(
                    icon: Icons.info_outline_rounded,
                    label: 'حول التطبيق',
                    showChevron: true,
                    onTap: () => _showAboutDialog(context),
                  ),
                  _SettingsItem(
                    icon: Icons.share_rounded,
                    label: 'مشاركة التطبيق',
                    showChevron: true,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'قريباً',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                          backgroundColor: AppColors.primaryBot,
                        ),
                      );
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.favorite_rounded,
                    label: 'ادعمنا للمزيد من التطوير',
                    showChevron: true,
                    onTap: () => _showRateDialog(context),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ── Legal group ──────────────────────
              _SettingsGroup(
                items: [
                  _SettingsItem(
                    icon: Icons.security_rounded,
                    label: 'سياسة الخصوصية',
                    showChevron: true,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'قريباً',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                          backgroundColor: AppColors.primaryBot,
                        ),
                      );
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.balance_rounded,
                    label: 'شروط الاستخدام',
                    showChevron: true,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'قريباً',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                          backgroundColor: AppColors.primaryBot,
                        ),
                      );
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.language_rounded,
                    label: 'خدمات الطرف الثالث',
                    showChevron: true,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'قريباً',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                          backgroundColor: AppColors.primaryBot,
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Delete account ───────────────────
              Center(
                child: GestureDetector(
                  onTap: () => _showDeleteDialog(context),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'حذف حسابي على التطبيق',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.redAccent,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ── Dialogs ──────────────────────────────────

  void _showRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => _AppRateDialog(
        onLeaveMessage: () {
          Navigator.pop(context);
          _showMessageDialog(context);
        },
        onRate: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'شكراً لتقييمك التطبيق!',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              backgroundColor: AppColors.primaryTop,
            ),
          );
        },
      ),
    );
  }

  void _showMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const _LeaveMessageDialog(),
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const _ProblemDialog(),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'حول اطمئن',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
            fontSize: 18,
          ),
        ),
        content: const Text(
          'اطمئن هو تطبيق دعم نفسي مبني على أسس العلاج المعرفي السلوكي (CBT). الإصدار 1.0.0',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontFamily: 'Cairo',
            fontSize: 13,
          ),
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
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => _DeleteAccountDialog(
        onKeep: () => Navigator.pop(context),
        onDelete: () {
          Navigator.pop(context);
          // TODO: call delete API
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Settings Group (card container with dividers)
// ─────────────────────────────────────────────
class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.items});
  final List<_SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: List.generate(items.length * 2 - 1, (i) {
            if (i.isOdd) {
              return const Divider(
                height: 1,
                color: Color(0xFF2A2A2A),
                indent: 16,
              );
            }
            return items[i ~/ 2];
          }),
        ),
      ),
    );
  }
}

// ── Single settings row ───────────────────────
class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.label,
    this.trailing,
    this.showChevron = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Left: chevron or custom trailing
            if (showChevron)
              const Icon(
                Icons.chevron_left_rounded,
                color: AppColors.textSecondary,
                size: 20,
              )
            else if (trailing != null)
              trailing!,
            const Spacer(),
            // Right: label + icon
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon, color: AppColors.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Rate App Dialog  (rate.png)
// ─────────────────────────────────────────────
class _AppRateDialog extends StatelessWidget {
  const _AppRateDialog({
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
            // Close X
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close_rounded,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
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
            const Text(
              'هل اعجبك التطبيق؟',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'رأيك يهمنا ويساعدنا على التطوير',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 24),
            // Leave message button (outlined)
            GestureDetector(
              onTap: onLeaveMessage,
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.stroke, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'اترك لنا رسالة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Rate button (gradient)
            GestureDetector(
              onTap: onRate,
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryTop, AppColors.primaryBot],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'قم بتقييم التطبيق',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
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

// ─────────────────────────────────────────────
//  Leave Message Dialog  (message.png)
// ─────────────────────────────────────────────
class _LeaveMessageDialog extends StatefulWidget {
  const _LeaveMessageDialog();

  @override
  State<_LeaveMessageDialog> createState() => _LeaveMessageDialogState();
}

class _LeaveMessageDialogState extends State<_LeaveMessageDialog> {
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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close X
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textSecondary,
                    size: 22,
                  ),
                ),
              ),
              // Check icon
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
              const Text(
                'اترك لنا رسالة\nتساعدنا على التطوير',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              // Message textarea
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
              // Send button
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'تم ارسال رسالتك بنجاح',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                      backgroundColor: AppColors.primaryTop,
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryTop, AppColors.primaryBot],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'ارسال',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Problem Dialog  (probllem.png)
// ─────────────────────────────────────────────
class _ProblemDialog extends StatefulWidget {
  const _ProblemDialog();

  @override
  State<_ProblemDialog> createState() => _ProblemDialogState();
}

class _ProblemDialogState extends State<_ProblemDialog> {
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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close X
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textSecondary,
                    size: 22,
                  ),
                ),
              ),
              // Headset icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryTop.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.headset_mic_rounded,
                  color: AppColors.primaryTop,
                  size: 28,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'هل واجهتك مشكلة ؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              // Message textarea
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
              // Send button
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'تم ارسال استفسارك بنجاح ، سنتواصل معك قريباً',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                      backgroundColor: AppColors.primaryTop,
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryTop, AppColors.primaryBot],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'ارسال',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Delete Account Dialog  (rate-1.png)
// ─────────────────────────────────────────────
class _DeleteAccountDialog extends StatelessWidget {
  const _DeleteAccountDialog({
    required this.onKeep,
    required this.onDelete,
  });

  final VoidCallback onKeep;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close X
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: onKeep,
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textSecondary,
                    size: 22,
                  ),
                ),
              ),
              // Trash icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_rounded,
                  color: Colors.redAccent,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'حذف حسابك ؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'سيتم حذف كل البيانات ولن تتمكن من ارجاعها مره اخرى',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 24),
              // Keep account (gradient button)
              GestureDetector(
                onTap: onKeep,
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryTop, AppColors.primaryBot],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'الاحتفاظ بحسابي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Delete (text link)
              GestureDetector(
                onTap: onDelete,
                child: const Text(
                  'حذف الحساب',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
