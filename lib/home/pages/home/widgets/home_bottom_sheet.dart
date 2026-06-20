import '../../../../core/logic/app_routes.dart';
import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class HomeBottomMenuOverlay {
  static Future<void> show({
    required BuildContext context,
    required VoidCallback onClose,
  }) {
    return Navigator.of(context).push(
      _FadeMenuRoute(
        builder: (_HomeMenuSheet(onClose: onClose)),
      ),
    );
  }
}

class _FadeMenuRoute extends PageRoute<void> {
  final Widget builder;

  _FadeMenuRoute({required this.builder})
      : super(settings: const RouteSettings());

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withValues(alpha: 0.85);

  @override
  String get barrierLabel => 'Dismiss';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class _HomeMenuSheet extends StatefulWidget {
  final VoidCallback onClose;

  const _HomeMenuSheet({required this.onClose});

  @override
  State<_HomeMenuSheet> createState() => _HomeMenuSheetState();
}

class _HomeMenuSheetState extends State<_HomeMenuSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_MenuItem> _items;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _items = [
      _MenuItem(
        icon: Icons.school_outlined,
        label: 'محتوى علاجي',
        onTap: () => _close(),
      ),
      _MenuItem(
        icon: Icons.ondemand_video,
        label: 'سينما اطمئن',
        onTap: () {
          _close();
          Navigator.pushNamed(context, AppRoutes.cinema);
        },
      ),
      _MenuItem(
        icon: Icons.nightlight_round,
        label: 'تمارين نفسية',
        onTap: () => _close(),
      ),
      _MenuItem(
        icon: Icons.info_outline,
        label: 'اختبارات نفسية',
        onTap: () {
          _close();
          Navigator.pushNamed(context, AppRoutes.tests);
        },
      ),
      _MenuItem(
        icon: Icons.hourglass_empty,
        label: 'تحديات نفسية',
        onTap: () {
          _close();
          Navigator.pushNamed(context, AppRoutes.challenges);
        },
      ),
      _MenuItem(
        icon: Icons.menu_book,
        label: 'ركن القراءة',
        onTap: () => _close(),
      ),
    ];
  }

  void _close() async {
    await _controller.reverse();
    if (mounted) {
      widget.onClose();
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _close,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 110.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ..._items.asMap().entries.map((entry) {
                    final int revIdx = _items.length - 1 - entry.key;
                    return _AnimatedMenuItem(
                      item: entry.value,
                      index: revIdx,
                      controller: _controller,
                      totalItems: _items.length,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedMenuItem extends StatelessWidget {
  final _MenuItem item;
  final int index;
  final AnimationController controller;
  final int totalItems;

  const _AnimatedMenuItem({
    required this.item,
    required this.index,
    required this.controller,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    final double startInterval = (index / totalItems) * 0.5;
    final double endInterval = startInterval + 0.5;

    final slide = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(startInterval, endInterval, curve: Curves.easeOutBack),
    ));

    final fade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(startInterval, endInterval, curve: Curves.easeOut),
    ));

    final scale = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(startInterval, endInterval, curve: Curves.easeOutBack),
    ));

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: ScaleTransition(
          scale: scale,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: item.onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 40.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    color: Colors.white,
                    size: 32.r,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item.label,
                    style: AppStyle.bold16.copyWith(
                      color: AppColors.whiteColor,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
