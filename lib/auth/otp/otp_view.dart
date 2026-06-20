import 'dart:developer';
import '../../core/logic/api/api_service.dart';
import '../../core/logic/app_routes.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_resent_code.dart';
import '../../core/ui/app_verfiy_code.dart';

import '../../core/ui/app_back.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpView extends StatefulWidget {
  const OtpView({
    super.key,
  });

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  String _otp = '';
  bool _isLoading = false;

  Future<void> _handleVerify(String email, bool isFromForgetPassword) async {
    if (_otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال الرمز كاملاً')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final res = await ApiService.post('verify_otp', {
      'email': email,
      'otp': _otp,
    });

    setState(() => _isLoading = false);

    if (res.success) {
      if (mounted) {
        Navigator.pushNamed(
          context,
          isFromForgetPassword ? AppRoutes.newPassword : AppRoutes.login,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res.error ?? 'رمز التحقق غير صحيح')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    // The argument can be an email string or a boolean depending on the route.
    // If it's a string, we treat it as an email. If it's false, it's normal register flow.
    final bool isFromForgetPassword = args == true;
    final String email = (args is String) ? args : 'example@gmail.com';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.h,
              ),
              const AppBack(),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'ارسلنا لك كود ',
                style: AppStyle.regular28.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    'علي الايميل $email',
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('تغيير الايميل '),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              AppVerfiyCode(
                onChanged: (val) {
                  _otp = val;
                },
                onCompleted: (val) {
                  _otp = val;
                  _handleVerify(email, isFromForgetPassword);
                },
              ),
              SizedBox(
                height: 50.h,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      onTap: () => _handleVerify(email, isFromForgetPassword),
                      title: 'تأكيد الرمز',
                    ),
              SizedBox(
                height: 10.h,
              ),
              const AppResentCode(),
            ],
          ),
        ),
      ),
    );
  }
}
