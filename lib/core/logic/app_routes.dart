import 'package:etmaen/on_borading_view.dart';
import 'package:etmaen/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String onBorading = '/onBorading';

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

      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
