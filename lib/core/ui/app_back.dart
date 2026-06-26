import 'app_color.dart';
import 'app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBack extends StatefulWidget {
  const AppBack({super.key});

  @override
  State<AppBack> createState() => _AppBackState();
}

class _AppBackState extends State<AppBack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          Navigator.pop(context);
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 - _controller.value * 0.12,
              child: CircleAvatar(
                backgroundColor: _controller.value > 0
                    ? AppColors.primiryColor.withValues(alpha: 0.2)
                    : AppColors.avatarColor,
                radius: 20.r,
                child: Transform.translate(
                  offset: Offset(3.0 * _controller.value, 0),
                  child: const AppImage(image: 'arrow_back.svg'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
