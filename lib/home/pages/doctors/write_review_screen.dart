import 'package:flutter/material.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';

// ─────────────────────────────────────────────
//  Write Review Screen
//  User submits a review for a doctor.
//  Matches design: "Success-1.png"
// ─────────────────────────────────────────────

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key, this.doctorName = 'دكتور محمد الامام'});
  final String doctorName;

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  int _stars = 5;
  final _nameCtrl = TextEditingController(text: 'محمد الامام');
  final _reviewCtrl = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _reviewCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_reviewCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('من فضلك اكتب مراجعتك',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    // Show success dialog
    showDialog(
      context: context,
      builder: (_) => _SuccessDialog(
        onDone: () {
          Navigator.of(context).pop(); // close dialog
          Navigator.of(context).pop(); // go back
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ── Header ────────────────────────
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.chevron_right_rounded,
                          color: Colors.white, size: 22),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Title ─────────────────────────
                Text(
                  'اكتب مراجعة بناءً على زيارتك\nللدكتور ${widget.doctorName}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                // ── Star rating ───────────────────
                const Text(
                  'ما تقييمك للدكتور',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(5, (i) {
                    final starIndex = 5 - i; // RTL: 5 4 3 2 1
                    return GestureDetector(
                      onTap: () => setState(() => _stars = starIndex),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.star_rounded,
                          color: starIndex <= _stars
                              ? const Color(0xFFFFAA00)
                              : const Color(0xFF3A3A3A),
                          size: 36,
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 24),

                // ── Name field ────────────────────
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'الاسم',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _nameCtrl,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontSize: 15,
                    ),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: InputBorder.none,
                      hintText: 'اسمك',
                      hintStyle: TextStyle(
                          color: AppColors.textDisabled, fontFamily: 'Cairo'),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Review textarea ───────────────
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'مراجعتك',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _reviewCtrl,
                    textAlign: TextAlign.right,
                    maxLines: 6,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontSize: 15,
                    ),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: InputBorder.none,
                      hintText: 'اكتب رأيك في الجلسة',
                      hintStyle: TextStyle(
                          color: AppColors.textDisabled, fontFamily: 'Cairo'),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // ── Submit button ─────────────────
                GestureDetector(
                  onTap: _isSubmitting ? null : _submit,
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryTop, AppColors.primaryBot],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : const Text(
                              'ارسال المراجعة',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Success dialog ────────────────────────────
class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({required this.onDone});
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Checkmark icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primaryTop.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.primaryTop,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'تم إرسال مراجعتك بنجاح',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'شكراً لمشاركتنا تجربتك',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onDone,
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryTop, AppColors.primaryBot],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text(
                    'حسناً',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
