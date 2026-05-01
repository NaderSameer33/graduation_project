import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_style.dart';

// ─────────────────────────────────────────────
//  ETMAEN – Shared Widgets
// ─────────────────────────────────────────────

// ── Primary CTA Button ───────────────────────
/// Full-width gradient pill button used for main actions.
/// Example: "تسجيل الدخول", "انشاء حساب", "ابدأ الان"
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 343,
        height: 56,
        padding: const EdgeInsets.all(10),
        decoration: AppDecorations.primaryButton,
        child: Center(
          child: Text(label, style: AppTextStyles.body16Bold),
        ),
      ),
    );
  }
}

// ── Outlined Secondary Button ─────────────────
/// Border-only pill button used for secondary actions.
/// Example: "عضو جديد"
class OutlinedAppButton extends StatelessWidget {
  const OutlinedAppButton({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 343,
        height: 56,
        padding: const EdgeInsets.all(10),
        decoration: AppDecorations.outlinedButton,
        child: Center(
          child: Text(label, style: AppTextStyles.body16Bold),
        ),
      ),
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

// ── Row of 4 OTP Boxes ────────────────────────
/// Renders 4 equally spaced OTP input boxes.
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
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      child: Container(
        width: 36,
        height: 36,
        clipBehavior: Clip.antiAlias,
        decoration: AppDecorations.backButton,
        child: const Center(
          // Replace with actual back-arrow icon
          child: Icon(Icons.chevron_right, color: Colors.white, size: 20),
        ),
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

// ── Etmaen Brand Logo Row ─────────────────────
/// "اطمئن" brand name displayed in the accent colour.
/// Used on loading/analysis screens.
class EtmaenBrandLabel extends StatelessWidget {
  const EtmaenBrandLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('اطمئن', style: AppTextStyles.brandAccent18);
  }
}

// ── "اطمئن يقدم" Heading ──────────────────────
/// Shared heading used on onboarding slides 2–6.
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
