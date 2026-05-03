import 'dart:typed_data';
import 'package:etmaen/core/logic/helper_method.dart';
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
              PersonalUploadPhoto(avatarBytes: _avatarBytes),

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
                hintText: 'محمد الامام',
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
                hintText: 'habibaemam@gmail.com',
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
                isPasswrod: true,
                hintText: 'محمد الامام',
                prefixIcon: 'lock.svg',
                bottomSpacing: 16.h,
              ),
              SizedBox(height: 50.h),
              AppButton(
                onTap: () {
                  showSnak(context: context, title: 'تم تعديل البينات بنجاح');
                  Navigator.pop(context);
                },
                title: 'تعديل البينات',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
