import '../../core/logic/api/api_service.dart';
import '../../core/logic/user_prefs.dart';
import '../../core/logic/app_routes.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_color.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال البريد الإلكتروني وكلمة المرور')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final res = await ApiService.post('login', {
      'email': email,
      'password': password,
    });

    setState(() => _isLoading = false);

    if (res.success) {
      // Try to get token from standard places in response
      final token = res.get<String>('token') ?? res.get<String>('jwt');
      if (token != null) {
        await UserPrefs.saveToken(token);
      }
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.aiQuiz);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res.error ?? 'فشل تسجيل الدخول')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                height: 80.h,
              ),
              Text(
                'تسجيل الدخول',
                style: AppStyle.regular28.copyWith(
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'عضو جديد',
                      style: AppStyle.bold16,
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.register,
                            ),
                            child: Text(
                              'انشاء حساب',
                              style: AppStyle.bold16.copyWith(
                                color: AppColors.primiryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
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
              Text(
                'ادخل كلمة المرور ',
                style: AppStyle.regular16,
              ),
              AppInput(
                controller: _passwordController,
                topSpacing: 4.h,
                bottomSpacing: 8.h,
                hintText: 'مثل : Etmaen@77',
                prefixIcon: 'lock.svg',
                isPasswrod: true,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.forgetPassword),
                child: Text(
                  'نسيت كلمة المرور ؟',
                  style: AppStyle.bold16.copyWith(
                    color: AppColors.primiryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      onTap: _handleLogin,
                      title: 'تسجيل الدخول',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
