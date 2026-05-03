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
                activeIcon: AppImage(
                  image: list[index].image,
                  color: AppColors.primiryColor,
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
