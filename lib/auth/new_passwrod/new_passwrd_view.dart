import '../../core/logic/api/api_service.dart';
import '../../core/logic/app_routes.dart';
import '../../core/ui/app_back.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleResetPassword(String email) async {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال كلمة المرور')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمات المرور غير متطابقة')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final res = await ApiService.post('Auth/reset-password', {
      'email': email,
      'newPassword': password,
    });

    setState(() => _isLoading = false);

    if (res.success || res.statusCode == 200) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
        );
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res.error ?? 'حدث خطأ أثناء تغيير كلمة المرور')),
        );
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
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
                'ادخل كلمة مرور جديدة',
                style: AppStyle.regular28.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30.h,
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
              Text(
                'تأكيد كلمة المرور ',
                style: AppStyle.regular16,
              ),
              AppInput(
                controller: _confirmPasswordController,
                topSpacing: 4.h,
                bottomSpacing: 8.h,
                hintText: 'مثل : Etmaen@77',
                prefixIcon: 'lock.svg',
                isPasswrod: true,
              ),
              const SizedBox(
                height: 100,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      onTap: () => _handleResetPassword(email),
                      title: 'كلمه مرور جديده',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
