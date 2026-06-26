import 'dart:math' as math;
import '../../core/logic/app_routes.dart';
import '../pages/home/widgets/home_bottom_sheet.dart';
import '../../core/ui/app_color.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_style.dart';
import '../models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  bool _menuOpen = false;

  late final AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _toggleMenu(BuildContext context) {
    if (_menuOpen) return;

    setState(() => _menuOpen = true);
    _fabController.forward();

    HomeBottomMenuOverlay.show(
      context: context,
      onClose: () {
        if (mounted) {
          setState(() => _menuOpen = false);
          _fabController.reverse();
        }
      },
    ).then((_) {
      if (mounted && _menuOpen) {
        setState(() => _menuOpen = false);
        _fabController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: list[currentIndex].page ?? const SizedBox(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      extendBody: true,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.r),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.avatarColor,
            showSelectedLabels: true,
            selectedItemColor: AppColors.primiryColor,
            unselectedItemColor: AppColors.whiteColor,
            showUnselectedLabels: true,
            selectedLabelStyle: AppStyle.bold12,
            unselectedLabelStyle: AppStyle.bold12.copyWith(
              color: AppColors.whiteColor,
            ),
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == 2) {
                _toggleMenu(context);
                return;
              }
              if (index == 3) {
                Navigator.pushNamed(context, AppRoutes.chatBot);
                return;
              }
              setState(() {
                currentIndex = index;
              });
            },
            items: List.generate(list.length, (index) {
              if (index == 2) {
                return BottomNavigationBarItem(
                  icon: _AnimatedFabIcon(
                    controller: _fabController,
                  ),
                  label: '',
                );
              }
              return BottomNavigationBarItem(
                backgroundColor: AppColors.avatarColor,
                icon: AppImage(image: list[index].image),
                activeIcon: _AnimatedNavIcon(
                  child: AppImage(
                    image: list[index].image,
                    color: AppColors.primiryColor,
                  ),
                ),
                label: list[index].title,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class SmilePainter extends CustomPainter {
  final Color color;
  SmilePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5.r
      ..strokeCap = StrokeCap.butt;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 - 2.r),
      width: size.width * 0.55,
      height: size.height * 0.55,
    );
    canvas.drawArc(rect, 0, 3.14159, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AnimatedFabIcon extends StatelessWidget {
  final AnimationController controller;

  const _AnimatedFabIcon({required this.controller});

  @override
  Widget build(BuildContext context) {
    final rotateAnim = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final t = controller.value;
        return Transform.rotate(
          angle: rotateAnim.value * 2 * 3.14159,
          child: Container(
            width: 48.r,
            height: 48.r,
            padding: EdgeInsets.all(5.5.r),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.primaryTop, AppColors.primaryBot],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 1.0 - t,
                    child: CustomPaint(
                      size: Size(24.r, 24.r),
                      painter: SmilePainter(color: AppColors.primaryBot),
                    ),
                  ),
                  Opacity(
                    opacity: t,
                    child: Icon(
                      Icons.close,
                      color: AppColors.primaryBot,
                      size: 24.r,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedNavIcon extends StatefulWidget {
  final Widget child;
  const _AnimatedNavIcon({required this.child});

  @override
  State<_AnimatedNavIcon> createState() => _AnimatedNavIconState();
}

class _AnimatedNavIconState extends State<_AnimatedNavIcon>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _glowController;
  late AnimationController _particleController;

  late Animation<double> _scaleAnim;
  late Animation<double> _jumpAnim;
  late Animation<double> _glowAnim;
  late Animation<double> _particleAnim;

  @override
  void initState() {
    super.initState();

    // Bounce + jump
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.3), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 0.85), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.0), weight: 35),
    ]).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOutCubic,
    ));
    _jumpAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 35),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 2.0), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 2.0, end: 0.0), weight: 30),
    ]).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOutCubic,
    ));

    // Neon glow pulse
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _glowAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.4), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.4, end: 0.0), weight: 30),
    ]).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeOut,
    ));

    // Particle burst
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _particleAnim = CurvedAnimation(
      parent: _particleController,
      curve: Curves.easeOut,
    );

    // Fire all
    _bounceController.forward();
    _glowController.forward();
    _particleController.forward();
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _glowController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _bounceController,
        _glowController,
        _particleController,
      ]),
      builder: (context, child) {
        return SizedBox(
          width: 48.r,
          height: 48.r,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Neon glow ring
              if (_glowAnim.value > 0)
                Positioned.fill(
                  child: Transform.scale(
                    scale: 1.0 + _glowAnim.value * 0.6,
                    child: Opacity(
                      opacity: _glowAnim.value * 0.7,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primiryColor,
                            width: 2.r,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primiryColor.withValues(
                                  alpha: _glowAnim.value * 0.6),
                              blurRadius: 12.r * _glowAnim.value,
                              spreadRadius: 4.r * _glowAnim.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // Particle burst (8 dots)
              if (_particleAnim.value > 0 && _particleAnim.value < 1.0)
                ...List.generate(8, (i) {
                  final angle = (i / 8) * 2 * math.pi;
                  final distance = 20.r * _particleAnim.value;
                  final opacity =
                      (1.0 - _particleAnim.value).clamp(0.0, 1.0);
                  final size = 4.r * (1.0 - _particleAnim.value * 0.5);
                  return Positioned(
                    left: 24.r + math.cos(angle) * distance - size / 2,
                    top: 24.r + math.sin(angle) * distance - size / 2,
                    child: Opacity(
                      opacity: opacity,
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i.isEven
                              ? AppColors.primiryColor
                              : AppColors.primaryTop,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primiryColor
                                  .withValues(alpha: opacity * 0.8),
                              blurRadius: 6.r,
                              spreadRadius: 1.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

              // The icon itself – bounce + jump
              Transform.translate(
                offset: Offset(0, _jumpAnim.value),
                child: Transform.scale(
                  scale: _scaleAnim.value,
                  child: widget.child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

