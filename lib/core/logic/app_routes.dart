import 'package:etmaen/auth/login/login_view.dart';

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
          builder: (context) => const LoginView(),
        );

      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
