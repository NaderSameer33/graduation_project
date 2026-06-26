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

    if (res.success || res.statusCode == 200) {
      if (mounted) {
        Navigator.pushNamed(
          context,
          isFromForgetPassword ? AppRoutes.newPassword : AppRoutes.login,
          arguments: email, // Pass email to newPassword view
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
    bool isFromForgetPassword = false;
    String email = 'example@gmail.com';

    if (args is Map) {
      email = args['email'] ?? '';
      isFromForgetPassword = args['isFromForgetPassword'] ?? false;
    } else if (args is String) {
      email = args;
    }

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
              AppResentCode(
                onResend: () async {
                  await ApiService.post('forgot_password', {'email': email});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
