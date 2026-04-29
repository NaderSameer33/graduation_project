import 'dart:typed_data';
import 'package:etmaen/core/logic/helper_method.dart';
import 'package:etmaen/core/ui/app_back.dart';

import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/profile/settings/widgets/setting_group.dart';
import 'package:etmaen/home/pages/profile/settings/widgets/setting_header.dart';
import 'package:etmaen/home/pages/profile/settings/widgets/setting_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide showAboutDialog;
import 'package:etmaen/core/logic/user_prefs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:etmaen/home/pages/pro/pro_content_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final bool _notificationsOn = true;
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
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  AppBack(),
                  SizedBox(
                    width: 36.w,
                  ),
                  Text('اعداداتك', style: AppStyle.bold16),
                ],
              ),

              SizedBox(height: 16.h),
              SettingHeader(
                loadProfile: _loadProfile,
                userName: _userName,
                ispro: _isPro,
              ),

              SizedBox(height: 16.h),

              SettingGroup(
                items: [
                  SettingsItem(
                    iconName: 'notification.svg',
                    label: 'الاشعارات',
                    isSwitch: true,
                  ),
                  SettingsItem(
                    iconName: 'pro.svg',
                    label: 'ترقية الحساب الى برو',

                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const ProContentScreen(),
                      ),
                    ),
                  ),
                  SettingsItem(
                    iconName: 'support.svg',
                    label: 'الدعم والمساعدة',
                    onTap: () => showSupportDialog(context),
                  ),
                  SettingsItem(
                    iconName: 'about.svg',
                    label: 'حول التطبيق',
                    onTap: () => showAboutDialog(context),
                  ),
                  SettingsItem(
                    iconName: 'share.svg',
                    label: 'مشاركة التطبيق',
                    onTap: () {
                      showSnak(context: context, title: 'قريباً');
                    },
                  ),
                  SettingsItem(
                    iconName: 'love.svg',
                    label: 'ادعمنا للمزيد من التطوير',
                    onTap: () => showRateDialog(context),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              SettingGroup(
                items: [
                  SettingsItem(
                    iconName: 'privacy.svg',
                    label: 'سياسة الخصوصية',
                    onTap: () {
                      showSnak(context: context, title: 'قريباً');
                    },
                  ),
                  SettingsItem(
                    iconName: 'using.svg',
                    label: 'شروط الاستخدام',
                    onTap: () {
                      showSnak(context: context, title: 'قريباً');
                    },
                  ),
                  SettingsItem(
                    iconName: 'global.svg',
                    label: 'خدمات الطرف الثالث',
                    onTap: () {
                      showSnak(context: context, title: 'قريباً');
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Center(
                child: GestureDetector(
                  onTap: () => showDeleteDialog(context),
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
}

