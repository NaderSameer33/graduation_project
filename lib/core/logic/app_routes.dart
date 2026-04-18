import 'package:etmaen/on_borading/on_borading_view.dart';
import 'package:etmaen/splash_view.dart';
import 'package:etmaen/welcome_view.dart';
import 'package:etmaen/welocme_login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String onBorading = '/onBorading';
  static const String welcome = '/welcome';
  static const String welcomeLogin = '/welcomeLogin';

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

      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
