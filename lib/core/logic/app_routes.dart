import 'package:etmaen/auth/forget_passwrd/forget_passwrord_view.dart';
import 'package:etmaen/auth/new_passwrod/new_passwrd_view.dart';

import '../../auth/login/login_view.dart';
import '../../auth/otp/otp_view.dart';
import '../../auth/register/register_view.dart';

import '../../on_borading/on_borading_view.dart';
import '../../splash_view.dart';
import '../../welcome_view.dart';
import '../../welocme_login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String onBorading = '/onBorading';
  static const String welcome = '/welcome';
  static const String welcomeLogin = '/welcomeLogin';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgetPassword = '/forgetPasswrod';
  static const String newPassword = '/newPassword';

  static Route? routeSetting(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return CupertinoPageRoute(
          builder: (context) => const SplashView(),
        );
      case onBorading:
        return CupertinoPageRoute(
          builder: (context) => const OnBoradingView(),
        );
      case welcome:
        return CupertinoPageRoute(
          builder: (context) => const WelcomeView(),
        );
      case welcomeLogin:
        return CupertinoPageRoute(
          builder: (context) => const WelcomeLoginView(),
        );
      case login:
        return CupertinoPageRoute(
          builder: (context) => const LoginView(),
        );
      case register:
        return CupertinoPageRoute(
          builder: (context) => const RegisterView(),
        );
      case otp:
        return CupertinoPageRoute(
          builder: (context) => const OtpView(),
          settings: settings,
        );
      case forgetPassword:
        return CupertinoPageRoute(
          builder: (context) => const ForgetPasswrordView(),
        );
      case newPassword:
        return CupertinoPageRoute(
          builder: (context) => const NewPasswordView(),
        );

      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
