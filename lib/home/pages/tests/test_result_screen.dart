import 'package:flutter/material.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/home/views/home_view.dart';

// ─────────────────────────────────────────────
//  Test Result Screen
//  Shows the outcome of a psychological test.
//  Matches design: "result.png"
// ─────────────────────────────────────────────

class TestResultScreen extends StatelessWidget {
  const TestResultScreen({
    super.key,
    required this.testTitle,
    required this.resultTitle,
    required this.resultDescription,
    required this.additionalNote,
    required this.recommendations,
  });

  final String testTitle;
  final String resultTitle;
  final String resultDescription;
  final String additionalNote;
  final List<String> recommendations;

  // Recommendation cards data
  static const List<Map<String, String>> _recCards = [
    {
      'num': '1',
      'title': 'اتحرّك حتى لو مش عندك دافع',
      'body':
          'المشي 10 دقائق أو الوقوف في الشمس يمكن أن يرفع هرمونات المزاج حتى لو لم تكن ترغبة في ذلك.',
    },
    {
      'num': '2',
      'title': 'النوم المنتظم وجدول الإيقاع',
      'body':
          'استعد نظام نومك بالاستيقاظ في نفس الوقت كل يوم لتحسين مزاجك العام.',
    },
    {
      'num': '3',
      'title': 'تحدث مع شخص تثق به',
      'body':
          'مشاركة مشاعرك مع شخص قريب منك يخفف العبء النفسي بشكل ملحوظ.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ── Header ──────────────────────────
                Row(
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
                      testTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Result title (purple accent) ─────
                Text(
                  resultTitle,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: AppColors.primaryTop,
                    fontSize: 24,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 16),

                // Primary description
                Text(
                  resultDescription,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    height: 1.8,
                  ),
                ),

                const SizedBox(height: 12),

                // Additional note
                Text(
                  additionalNote,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    height: 1.8,
                  ),
                ),

                const SizedBox(height: 28),

                // ── "نصيحتنا لك" section ─────────────
                const Text(
                  'نصيحتنا لك',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 16),

                // Horizontal scrollable recommendation cards
                SizedBox(
                  height: 180,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _recCards.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, i) => _RecCard(card: _recCards[i]),
                  ),
                ),

                const SizedBox(height: 32),

                // ── Retry button ─────────────────────
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                    child: const Center(
                      child: Text(
                        'اعادة الاختبار',
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

                const SizedBox(height: 16),

                // Back to home
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const HomeView()),
                    (r) => false,
                  ),
                  child: Center(
                    child: Text(
                      'العودة للرئيسية',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textSecondary,
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

// ── Recommendation card ───────────────────────
class _RecCard extends StatelessWidget {
  const _RecCard({required this.card});
  final Map<String, String> card;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2A2A), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Number badge
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              gradient: AppGradients.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                card['num']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Title
          Text(
            card['title']!,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          // Body
          Expanded(
            child: Text(
              card['body']!,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                fontFamily: 'Cairo',
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
