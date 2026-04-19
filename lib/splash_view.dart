import 'core/ui/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/logic/app_routes.dart';
import 'core/ui/app_color.dart';
import 'core/ui/app_image.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  bool showSecondScreen = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadeAnimation = Tween<double>(begin: 1, end: 0).animate(controller);

    startAnimation();
  }

  void startAnimation() async {
    await controller.forward();

    setState(() {
      showSecondScreen = true;
    });

    await Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushNamed(context, AppRoutes.welcome);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: showSecondScreen ? 1 : 0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppImage(
                      image: 'logo.png',
                      height: 200.h,
                      bottomSpacing: 5.h,
                    ),

                    Text(
                      'اطمئن',
                      style: AppStyle.regular37,
                    ),
                  ],
                ),
              ),
            ),
          ),

          AnimatedBuilder(
            animation: fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: fadeAnimation.value,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.primiryColor,
                        AppColors.whiteColor,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
