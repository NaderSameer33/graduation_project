import '../../core/logic/api/api_service.dart';
import '../../core/logic/app_routes.dart';
import '../../core/logic/user_prefs.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_color.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isActive = false;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _handleRegister() async {
    final email = _emailController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phoneNumber = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تعبئة جميع الحقول')),
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

    final res = await ApiService.post('register', {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
    });

    setState(() => _isLoading = false);

    if (res.success) {
      final token = res.get<String>('token') ?? res.get<String>('jwt');
      if (token != null) {
        await UserPrefs.saveToken(token);
      }
      
      await UserPrefs.saveName('$firstName $lastName');
      await UserPrefs.saveEmail(email);

      if (mounted) {
        Navigator.pushNamed(
          context,
          AppRoutes.otp,
          arguments: email, // Passing email to OTP view (as requested, though OTP goes to phone)
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                height: 40.h,
              ),
              Text(
                'انشاء حساب',
                style: AppStyle.regular28.copyWith(
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'عضو مسجل بالفعل',
                      style: AppStyle.bold16,
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.login,
                            ),
                            child: Text(
                              'تسجيل الدخول',
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
                height: 20.h,
              ),
              Text(
                'الاسم الأول',
                style: AppStyle.regular16,
              ),
              AppInput(
                controller: _firstNameController,
                topSpacing: 4.h,
                bottomSpacing: 16.h,
                hintText: 'مثل : نادر',
                prefixIcon: 'person.svg',
              ),
              Text(
                'الاسم الأخير',
                style: AppStyle.regular16,
              ),
              AppInput(
                controller: _lastNameController,
                topSpacing: 4.h,
                bottomSpacing: 16.h,
                hintText: 'مثل : سمير',
                prefixIcon: 'person.svg',
              ),
              Text(
                'رقم الهاتف',
                style: AppStyle.regular16,
              ),
              AppInput(
                controller: _phoneController,
                topSpacing: 4.h,
                bottomSpacing: 16.h,
                hintText: 'مثل : 01000000000',
                prefixIcon: 'person.svg', // Assuming phone icon doesn't exist, fallback to person or omit
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
              Row(
                children: [
                  Transform.scale(
                    scale: 1.5.h,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: AppColors.primiryColor,
                      value: isActive,
                      onChanged: (value) {
                        isActive = value!;
                        setState(() {});
                      },
                    ),
                  ),
                  Text(
                    'تذكرني المرة القادمة',
                    style: AppStyle.regular16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      onTap: _handleRegister,
                      title: 'انشاء حساب',
                    ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
