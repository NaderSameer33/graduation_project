import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_style.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _pressing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
    widget.onTap?.call();
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 343,
              height: 56,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: AppGradients.primary,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primiryColor
                        .withValues(alpha: _pressing ? 0.6 : 0.25),
                    blurRadius: _pressing ? 20 : 8,
                    spreadRadius: _pressing ? 2 : 0,
                    offset: Offset(0, _pressing ? 2 : 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(widget.label, style: AppTextStyles.body16Bold),
              ),
            ),
          ),
        );
      },
    );
  }
}

class OutlinedAppButton extends StatefulWidget {
  const OutlinedAppButton({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  State<OutlinedAppButton> createState() => _OutlinedAppButtonState();
}

class _OutlinedAppButtonState extends State<OutlinedAppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _pressing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
    widget.onTap?.call();
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 343,
              height: 56,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: _pressing
                      ? AppColors.primiryColor
                      : AppColors.stroke,
                  width: _pressing ? 2 : 1,
                ),
                color: _pressing
                    ? AppColors.primiryColor.withValues(alpha: 0.1)
                    : Colors.transparent,
                boxShadow: _pressing
                    ? [
                        BoxShadow(
                          color: AppColors.primiryColor.withValues(alpha: 0.3),
                          blurRadius: 16,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 120),
                  style: AppTextStyles.body16Bold.copyWith(
                    color: _pressing ? AppColors.primiryColor : Colors.white,
                  ),
                  child: Text(widget.label),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Labelled Input Field ──────────────────────
/// Dark card input field with a label above and placeholder hint.
class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    required this.label,
    required this.hint,
    this.hasIcon = false,
    this.isPassword = false,
  });

  final String label;
  final String hint;
  final bool hasIcon;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Label above the field
        SizedBox(
          width: 343,
          child: Text(
            label,
            textAlign: TextAlign.right,
            style: AppTextStyles.body12Secondary,
          ),
        ),
        const SizedBox(height: 4),
        // The actual input container
        Container(
          width: 343,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: AppDecorations.inputField,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(hint, style: AppTextStyles.body16Disabled),
              if (hasIcon) ...[
                const SizedBox(width: 8),
                // Icon placeholder – replace with actual icon widget
                const SizedBox(width: 20, height: 20),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ── OTP Box ───────────────────────────────────
/// Single digit box used in OTP / code-confirmation screens.
class OtpBox extends StatelessWidget {
  const OtpBox({super.key, this.digit});

  final String? digit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      height: 74,
      decoration: AppDecorations.otpBox,
      child: Center(
        child: digit != null
            ? Text(
                digit!,
                style: AppTextStyles.heading28White,
              )
            : null, // empty when no input yet
      ),
    );
  }
}

class OtpRow extends StatelessWidget {
  const OtpRow({super.key, this.digits = const ['', '', '', '']});

  final List<String> digits;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        4,
        (i) => OtpBox(digit: digits[i].isNotEmpty ? digits[i] : null),
      ),
    );
  }
}

// ── Back Button ───────────────────────────────
/// Small circular gradient back button shown on sub-screens.
class AppBackButton extends StatefulWidget {
  const AppBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  State<AppBackButton> createState() => _AppBackButtonState();
}

class _AppBackButtonState extends State<AppBackButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        (widget.onTap ?? () => Navigator.of(context).maybePop())();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - _controller.value * 0.15,
            child: Container(
              width: 36,
              height: 36,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: AppGradients.backButton,
                boxShadow: _controller.value > 0
                    ? [
                        BoxShadow(
                          color: AppColors.primiryColor
                              .withValues(alpha: _controller.value * 0.4),
                          blurRadius: 10 * _controller.value,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Transform.translate(
                  offset: Offset(-3.0 * _controller.value, 0),
                  child: const Icon(
                      Icons.chevron_right, color: Colors.white, size: 20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Progress Bar ──────────────────────────────
/// Labelled horizontal progress indicator used in the quiz flow.
/// [percent] is 0.0 – 1.0.
class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({
    super.key,
    required this.percent,
    required this.label,
  });

  final double percent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Track
        Container(
          width: double.infinity,
          height: 8,
          decoration: ShapeDecoration(
            color: AppColors.overlayGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: percent,
              child: Container(
                height: 8,
                decoration: ShapeDecoration(
                  gradient: AppGradients.progress,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Label e.g. "30% مكتمل"
        Text(
          label,
          textAlign: TextAlign.right,
          style: AppTextStyles.body16White,
        ),
      ],
    );
  }
}

class EtmaenBrandLabel extends StatelessWidget {
  const EtmaenBrandLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('اطمئن', style: AppTextStyles.brandAccent18);
  }
}

class EtmaenYuqaddimHeading extends StatelessWidget {
  const EtmaenYuqaddimHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'اطمئن ', style: AppTextStyles.brandAccent19),
          TextSpan(
            text: 'يقدم',
            style: AppTextStyles.heading19White,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
