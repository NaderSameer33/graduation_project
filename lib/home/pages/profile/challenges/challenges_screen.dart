import 'package:flutter/material.dart';
import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_style.dart';
import 'challenge_detail_screen.dart';

// ─────────────────────────────────────────────
//  Challenges Screen
//  List of mental health challenges.
//  Matches design: "challenges.png"
// ─────────────────────────────────────────────

// ── Challenge data model ──────────────────────
class ChallengeModel {
  const ChallengeModel({
    required this.id,
    required this.title,
    required this.goal,
    required this.duration,
    required this.difficulty,
    required this.steps,
    required this.stepsDetail,
    this.iconColor = const Color(0xFF6C63FF),
  });

  final String id;
  final String title;
  final String goal;
  final String duration;
  final String difficulty;
  final List<String> steps;
  final String stepsDetail;
  final Color iconColor;
}

// ── Sample challenges ─────────────────────────
const List<ChallengeModel> sampleChallenges = [
  ChallengeModel(
    id: '1',
    title: 'تحرك في مكان جديد',
    goal: 'الهدف: تنشيط الدماغ وكسر الجمود',
    duration: 'يوم واحد',
    difficulty: 'متوسط الصعوبة',
    steps: ['تنشيط الدماغ', 'كسر الروتين', 'تحسين المزاج'],
    stepsDetail:
        'اختر مكاناً جديداً لم تزوره من قبل. يمكن أن يكون مقهى صغيراً أو متنزهاً أو أي مكان مختلف عن روتينك اليومي. استكشف المكان بعيون فضولية لمدة ساعة على الأقل.',
    iconColor: Color(0xFF6C63FF),
  ),
  ChallengeModel(
    id: '2',
    title: 'لحظة هدوء',
    goal: 'الهدف: تهدئة الجهاز العصبي',
    duration: '7 أيام',
    difficulty: 'يتطلب التزام',
    steps: ['تقليل التوتر', 'تهدئة الأفكار', 'دعم الاستقرار النفسي'],
    stepsDetail:
        'خلال 7 أيام، ستخصص 5 دقائق يوميًا للجلوس أو الاستلقاء في مكان هادئ، مع الاستماع إلى تمرين تنفس أو صوت مريح، والتركيز فقط على عملية التنفس.',
    iconColor: Color(0xFFE91E8C),
  ),
  ChallengeModel(
    id: '3',
    title: 'التعرض لضوء الشمس',
    goal: 'رفع هرمون السيروتونين "هرمون السعادة"',
    duration: '3 أيام',
    difficulty: 'متوسط الصعوبة',
    steps: ['رفع المزاج', 'تنظيم الساعة البيولوجية', 'تحسين النوم'],
    stepsDetail:
        'كل يوم لمدة 3 أيام، اقضِ 15 دقيقة على الأقل في ضوء الشمس الطبيعي صباحاً. المشي في الهواء الطلق أو الجلوس على شرفتك كافٍ.',
    iconColor: Color(0xFFFFC107),
  ),
];

// ─────────────────────────────────────────────
class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.canPop(context)
                          ? Navigator.pop(context)
                          : null,
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
                    const Text(
                      'تحديات نفسية',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'تم تصميم هذه التحديات لمساعدتك على استعادة طاقتك وتحسين حالتك النفسية من خلال خطوات صغيرة قابلة للتنفيذ في حياتك اليومية.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontFamily: 'Cairo',
                    height: 1.7,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Challenge list ───────────────────
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  itemCount: sampleChallenges.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _ChallengeCard(
                    challenge: sampleChallenges[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChallengeDetailScreen(
                          title: sampleChallenges[i].title,
                          description:
                              'هذا التحدي مصمم لمساعدتك على تهدئة جهازك العصبي وإعادة التوازن إلى عقلك وجسمك من خلال لحظات قصيرة من الهدوء الواعي.',
                          duration: sampleChallenges[i].duration,
                          difficulty: sampleChallenges[i].difficulty,
                          steps: sampleChallenges[i].steps,
                          stepsDetail: sampleChallenges[i].stepsDetail,
                          iconColor: sampleChallenges[i].iconColor,
                          isCompleted: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Challenge card ────────────────────────────
class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({
    required this.challenge,
    required this.onTap,
  });

  final ChallengeModel challenge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Text content (right side in RTL)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Title
                  Text(
                    challenge.title,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Goal
                  Text(
                    challenge.goal,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Duration + difficulty chips
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _MetaChip(
                        icon: Icons.hourglass_bottom_rounded,
                        label: challenge.difficulty,
                        color: _difficultyColor(challenge.difficulty),
                      ),
                      const SizedBox(width: 8),
                      _MetaChip(
                        icon: Icons.access_time_rounded,
                        label: challenge.duration,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Illustration placeholder (left side in RTL layout)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: challenge.iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _challengeIcon(challenge.id),
                color: challenge.iconColor,
                size: 44,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _challengeIcon(String id) {
    switch (id) {
      case '1':
        return Icons.directions_walk_rounded;
      case '2':
        return Icons.self_improvement_rounded;
      case '3':
        return Icons.wb_sunny_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  Color _difficultyColor(String d) {
    if (d.contains('متوسط')) return const Color(0xFFFF8C00);
    if (d.contains('يتطلب')) return Colors.redAccent;
    return AppColors.textSecondary;
  }
}

// ── Meta chip ─────────────────────────────────
class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(width: 3),
        Icon(icon, color: color, size: 13),
      ],
    );
  }
}
