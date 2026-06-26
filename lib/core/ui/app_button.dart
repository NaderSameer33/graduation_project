import 'dart:math' as math;
import 'app_color.dart';
import 'app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatefulWidget {
  const AppButton({super.key, required this.onTap, required this.title});
  final VoidCallback onTap;
  final String title;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _glowAnim;
  bool _pressing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _glowAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    setState(() => _pressing = true);
    _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _controller.reverse().then((_) {
      if (mounted) setState(() => _pressing = false);
    });
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse().then((_) {
      if (mounted) setState(() => _pressing = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnim.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: Container(
              alignment: Alignment.center,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: _pressing
                      ? [
                          AppColors.primiryColor.withValues(alpha: 0.85),
                          AppColors.secondryColor.withValues(alpha: 0.85),
                        ]
                      : [
                          AppColors.primiryColor,
                          AppColors.secondryColor,
                        ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primiryColor
                        .withValues(alpha: 0.3 + _glowAnim.value * 0.35),
                    blurRadius: 12.r + _glowAnim.value * 8.r,
                    spreadRadius: _glowAnim.value * 2.r,
                    offset: Offset(0, 4.r - _glowAnim.value * 2.r),
                  ),
                ],
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                style: AppStyle.bold16.copyWith(
                  letterSpacing: _pressing ? 1.2 : 0.0,
                ),
                child: Text(widget.title),
              ),
            ),
          ),
        );
      },
    );
  }
}
