import '../../core/logic/api/api_service.dart';
import '../../core/logic/app_routes.dart';
import '../../core/ui/app_back.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_color.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswrordView extends StatefulWidget {
  const ForgetPasswrordView({super.key});

  @override
  State<ForgetPasswrordView> createState() => _ForgetPasswrordViewState();
}

class _ForgetPasswrordViewState extends State<ForgetPasswrordView> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleForgetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال البريد الإلكتروني')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final res = await ApiService.post('forgot_password', {'email': email});

    setState(() => _isLoading = false);

    if (res.success || res.statusCode == 200) {
      if (mounted) {
        Navigator.pushNamed(
          context,
          AppRoutes.otp,
          arguments: {
            'email': email,
            'isFromForgetPassword': true,
          },
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res.error ?? 'حدث خطأ أثناء الاتصال بالخادم')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
                height: 20.h,
              ),
              const AppBack(),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'نسيت كلمة المرور',
                style: AppStyle.regular28.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    'سنرسل لك ',
                    style: AppStyle.regular16.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    'كود تسجيل الدخول',
                    style: AppStyle.regular16.copyWith(
                      color: AppColors.primiryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'ادخل البريد الالكتروني',
                style: AppStyle.regular16,
              ),
              AppInput(
                controller: _emailController,
                topSpacing: 4.h,
                bottomSpacing: 16.h,
                hintText: 'مثل : Etmaen@gmail.com',
                prefixIcon: 'email.svg',
              ),
              SizedBox(
                height: 40.h,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      onTap: _handleForgetPassword,
                      title: 'ارسال الرمز',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
