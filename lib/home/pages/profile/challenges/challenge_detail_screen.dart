import 'package:flutter/material.dart';
import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_style.dart';

// ─────────────────────────────────────────────
//  Challenge Detail Screen
//  Shows full description + steps for a challenge.
//  When isCompleted=false → "ابدأ التحدي"  (challenges-1.png)
//  When isCompleted=true  → "اتممت التحدي" (challenges-2.png)
// ─────────────────────────────────────────────

class ChallengeDetailScreen extends StatefulWidget {
  const ChallengeDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.steps,
    required this.stepsDetail,
    this.iconColor = const Color(0xFF6C63FF),
    this.isCompleted = false,
  });

  final String title;
  final String description;
  final String duration;
  final String difficulty;
  final List<String> steps;
  final String stepsDetail;
  final Color iconColor;
  final bool isCompleted;

  @override
  State<ChallengeDetailScreen> createState() =>
      _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  late bool _isCompleted;
  bool _showFullSteps = false;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.isCompleted;
  }

  void _startChallenge() {
    // Simulate starting/completing challenge
    setState(() => _isCompleted = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'تهانينا! لقد أتممت التحدي 🎉',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: AppColors.primaryBot,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
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
            child: Column(
              children: [
                // ── Header ──────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: [
                      GestureDetector(
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
                      const Spacer(),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Illustration ─────────────────────
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 200,
                  decoration: BoxDecoration(
                    color: widget.iconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(
                      _challengeIconData(),
                      color: widget.iconColor,
                      size: 100,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Description ───────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      height: 1.8,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Steps section ─────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'خطوات التنفيذ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Steps detail text
                      Text(
                        _isCompleted || _showFullSteps
                            ? widget.stepsDetail
                            : _truncated(widget.stepsDetail),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontFamily: 'Cairo',
                          height: 1.8,
                        ),
                      ),

                      // "Read more" toggle
                      if (!_isCompleted &&
                          !_showFullSteps &&
                          widget.stepsDetail.length > 150)
                        GestureDetector(
                          onTap: () =>
                              setState(() => _showFullSteps = true),
                          child: const Text(
                            '...قراءة المزيد',
                            style: TextStyle(
                              color: AppColors.primaryTop,
                              fontSize: 13,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      const SizedBox(height: 16),

                      // Bullet points (shown when completed or full view)
                      if (_isCompleted || _showFullSteps)
                        ...widget.steps.map(
                          (step) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  step,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryTop,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ── Action button ─────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _isCompleted
                      ? Column(
                          children: [
                            // "اتممت التحدي" – completed state
                            Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.primaryTop,
                                    AppColors.primaryBot,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  'اتممت التحدي',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // "انهاء واختيار تحدي آخر"
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                'انهاء واختيار تحدي آخر',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: _startChallenge,
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.primaryTop,
                                  AppColors.primaryBot,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'ابدأ التحدي',
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
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _challengeIconData() {
    if (widget.title.contains('هدوء') || widget.title.contains('تأمل')) {
      return Icons.self_improvement_rounded;
    } else if (widget.title.contains('شمس') || widget.title.contains('ضوء')) {
      return Icons.wb_sunny_rounded;
    } else {
      return Icons.directions_walk_rounded;
    }
  }

  /// Show only the first 150 chars of a string
  String _truncated(String text) {
    if (text.length <= 150) return text;
    return '${text.substring(0, 150)}...';
  }
}
