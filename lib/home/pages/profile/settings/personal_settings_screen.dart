import 'dart:typed_data';
import 'package:etmaen/core/logic/api/api_service.dart';
import 'package:etmaen/core/logic/helper_method.dart';
import 'package:etmaen/core/logic/user_prefs.dart';
import 'package:etmaen/core/ui/app_button.dart';
import 'package:etmaen/core/ui/app_input.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/profile/settings/widgets/personal_setting_header.dart';
import 'package:etmaen/home/pages/profile/settings/widgets/personal_upload_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalSettingsScreen extends StatefulWidget {
  const PersonalSettingsScreen({super.key});
  @override
  State<PersonalSettingsScreen> createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  Uint8List? _avatarBytes;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final p = await UserPrefs.loadProfile();
    if (!mounted) return;
    setState(() {
      _nameController.text = p['name'] as String;
      _emailController.text = p['email'] as String;
      _avatarBytes = p['avatarBytes'] as Uint8List?;
    });
  }

  Future<void> _handleUpdate() async {
    setState(() => _isLoading = true);

    final newName = _nameController.text.trim();
    final newEmail = _emailController.text.trim();
    final newPassword = _passwordController.text;

    // Update Name
    if (newName.isNotEmpty) {
      await ApiService.authenticatedPut('profile_update_name', {'fullName': newName});
      await UserPrefs.saveName(newName);
    }

    // Update Email
    if (newEmail.isNotEmpty) {
      await ApiService.authenticatedPut('profile_update_email', {'email': newEmail});
      await UserPrefs.saveEmail(newEmail);
    }

    // Change Password
    if (newPassword.isNotEmpty) {
      await ApiService.authenticatedPut('profile_change_password', {
        'currentPassword': '',
        'newPassword': newPassword,
      });
    }

    // Update Avatar (Local)
    if (_avatarBytes != null) {
      await UserPrefs.saveAvatarBytes(_avatarBytes!);
    } else {
      await UserPrefs.clearAvatar();
    }

    setState(() => _isLoading = false);

    if (mounted) {
      showSnak(context: context, title: 'تم تعديل البينات بنجاح');
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              PersonalSettingHeader(),
              SizedBox(height: 10.h),
              PersonalUploadPhoto(
                avatarBytes: _avatarBytes,
                onImageSelected: (newBytes) {
                  setState(() {
                    if (newBytes != null && newBytes.isEmpty) {
                      _avatarBytes = null;
                    } else {
                      _avatarBytes = newBytes;
                    }
                  });
                },
              ),

              SizedBox(height: 8),
              Center(
                child: Text('اضغط لتغيير الصورة', style: AppStyle.bold12),
              ),
              SizedBox(height: 28.h),

              Text(
                'الاسم',
                style: AppStyle.regular12,
              ),
              SizedBox(
                height: 5.h,
              ),
              AppInput(
                controller: _nameController,
                hintText: 'الاسم',
                prefixIcon: 'profile.svg',
                bottomSpacing: 16.h,
              ),

              Text(
                'البريد الالكتروني',
                style: AppStyle.regular12,
              ),
              SizedBox(
                height: 5.h,
              ),
              AppInput(
                controller: _emailController,
                hintText: 'البريد الالكتروني',
                prefixIcon: 'email.svg',
                bottomSpacing: 16.h,
              ),
              Text(
                'كلمة المرور',
                style: AppStyle.regular12,
              ),
              SizedBox(
                height: 5.h,
              ),
              AppInput(
                controller: _passwordController,
                isPasswrod: true,
                hintText: 'ادخل كلمة المرور الجديدة',
                prefixIcon: 'lock.svg',
                bottomSpacing: 16.h,
              ),
              SizedBox(height: 50.h),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      onTap: _handleUpdate,
                      title: 'تعديل البينات',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
