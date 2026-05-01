import 'package:flutter/material.dart';
import '../../../core/ui/app_color.dart';
import '../../../core/ui/app_style.dart';
import 'test_result_screen.dart';

// ─────────────────────────────────────────────
//  Tests Screen
//  Psychological self-assessment tests list.
//  Matches design: "tests.png"
// ─────────────────────────────────────────────

class _TestModel {
  const _TestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questionCount,
    required this.durationMin,
    required this.iconColor,
  });

  final String id;
  final String title;
  final String description;
  final int questionCount;
  final int durationMin;
  final Color iconColor;
}

const List<_TestModel> _tests = [
  _TestModel(
    id: 'depression',
    title: 'اختبار الاكتئاب',
    description:
        'هذا التقييم يعتمد على مقاييس نفسية عالمية، ويهدف للتوعية فقط، وليس بديلاً عن التشخيص الطبي.',
    questionCount: 30,
    durationMin: 8,
    iconColor: Color(0xFF5B3FA3),
  ),
  _TestModel(
    id: 'anxiety',
    title: 'اختبار القلق',
    description:
        'قياس مستوى القلق اليومي وتأثيره على حياتك باستخدام مقاييس علمية معتمدة دولياً.',
    questionCount: 20,
    durationMin: 6,
    iconColor: Color(0xFF3F7FA3),
  ),
  _TestModel(
    id: 'stress',
    title: 'اختبار الإجهاد',
    description:
        'تقييم مستوى ضغط الحياة اليومية والإجهاد المزمن وتحديد خطة الدعم الأمثل لك.',
    questionCount: 25,
    durationMin: 7,
    iconColor: Color(0xFFA35B3F),
  ),
];

// ─────────────────────────────────────────────
class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

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
                      'اختبارات نفسية',
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
                  'نقدم مجموعة من التقييمات النفسية المبنية على مقاييس عالمية معتمدة، لمساعدتك على فهم نفسك بشكل أعمق وتحديد خطة الدعم الأنسب لك. هذه التقييمات لا تمثل تشخيصاً طبياً ولا تُغني عن استشارة طبيب أو أخصائي نفسي.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontFamily: 'Cairo',
                    height: 1.7,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // "رحلة التعرف على الذات" heading
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'رحلة التعرف على الذات',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ── Tests list ───────────────────────
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  itemCount: _tests.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _TestCard(
                    test: _tests[i],
                    onTap: () => _startTest(context, _tests[i]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startTest(BuildContext ctx, _TestModel test) {
    // Navigate to quiz question screen first
    final questions = _buildQuestions(test);
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (_) => _QuizFlow(test: test, questions: questions),
      ),
    );
  }

  List<Map<String, dynamic>> _buildQuestions(_TestModel test) {
    // Depression test questions (matching q1.png / q2.png)
    if (test.id == 'depression') {
      return [
        {
          'q': 'خلال آخر أسبوعين، إلى أي مدى شعرت بالحزن أو الفراغ أو فقدان الأمل؟',
          'opts': ['أبداً', 'أحياناً', 'كثيراً', 'طوال الوقت'],
        },
        {
          'q': 'إلى أي مدى تشعر بالتعب أو فقدان الطاقة حتى بدون مجهود واضح؟',
          'opts': ['أبداً', 'أحياناً', 'كثيراً', 'طوال الوقت'],
        },
        {
          'q': 'هل فقدت الاهتمام أو المتعة في الأشياء التي كنت تستمتع بها؟',
          'opts': ['أبداً', 'أحياناً', 'كثيراً', 'طوال الوقت'],
        },
      ];
    }
    return [
      {
        'q': 'هل تشعر بالقلق في مواقف يومية بسيطة؟',
        'opts': ['أبداً', 'أحياناً', 'كثيراً', 'طوال الوقت'],
      },
    ];
  }
}

// ── Test card ─────────────────────────────────
class _TestCard extends StatelessWidget {
  const _TestCard({required this.test, required this.onTap});

  final _TestModel test;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Illustration area
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    test.iconColor.withOpacity(0.4),
                    test.iconColor.withOpacity(0.1),
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16)),
              ),
              child: Center(
                child: Icon(
                  _testIcon(test.id),
                  color: test.iconColor,
                  size: 64,
                ),
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    test.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    test.description,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontFamily: 'Cairo',
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${test.durationMin} دقائق',
                        style: const TextStyle(
                          color: AppColors.textDisabled,
                          fontSize: 12,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.access_time_rounded,
                          color: AppColors.textDisabled, size: 14),
                      const SizedBox(width: 12),
                      Text(
                        '${test.questionCount} سؤال',
                        style: const TextStyle(
                          color: AppColors.textDisabled,
                          fontSize: 12,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.quiz_rounded,
                          color: AppColors.textDisabled, size: 14),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _testIcon(String id) {
    switch (id) {
      case 'depression':
        return Icons.mood_bad_rounded;
      case 'anxiety':
        return Icons.psychology_rounded;
      case 'stress':
        return Icons.battery_alert_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }
}

// ─────────────────────────────────────────────
//  Quiz Flow wrapper (runs questions then shows result)
// ─────────────────────────────────────────────
class _QuizFlow extends StatefulWidget {
  const _QuizFlow({required this.test, required this.questions});

  final _TestModel test;
  final List<Map<String, dynamic>> questions;

  @override
  State<_QuizFlow> createState() => _QuizFlowState();
}

class _QuizFlowState extends State<_QuizFlow> {
  int _currentQuestion = 0;
  int? _selectedOption;
  final List<int> _answers = [];

  void _next() {
    if (_selectedOption == null) return;
    _answers.add(_selectedOption!);
    if (_currentQuestion < widget.questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedOption = null;
      });
    } else {
      // All questions answered → show result
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TestResultScreen(
            testTitle: 'نتيجة ${widget.test.title}',
            resultTitle: _calcResult(),
            resultDescription:
                'هذا يعني أن لديك بعض أعراض الاكتئاب بدرجة بسيطة، مثل انخفاض المزاج أو فقدان المتعة أو الطاقة في بعض الأيام.',
            additionalNote:
                'هذه الأعراض لا تمنعك من ممارسة حياتك اليومية، لكنها قد تجعلك تشعر بالإرهاق أو الثقل النفسي من وقت لآخر.',
            recommendations: const [
              'اتحرّك حتى لو مش عندك دافع',
              'النوم المنتظم وجدول الإيقاع',
              'تحدث مع شخص تثق به',
            ],
          ),
        ),
      );
    }
  }

  void _prev() {
    if (_currentQuestion > 0) {
      setState(() {
        _currentQuestion--;
        _selectedOption = null;
      });
    }
  }

  String _calcResult() {
    final total = _answers.fold(0, (a, b) => a + b);
    if (total < 3) return 'طبيعي';
    if (total < 6) return 'اكتئاب خفيف';
    if (total < 9) return 'اكتئاب متوسط';
    return 'اكتئاب شديد';
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[_currentQuestion];
    final total = widget.questions.length;
    final progress = (_currentQuestion + 1) / total;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Header
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
                      widget.test.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Progress counter
                Text(
                  '${_currentQuestion + 1}/$total',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.overlayGrey,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryTop),
                    minHeight: 8,
                  ),
                ),

                const SizedBox(height: 28),

                // Question text
                Text(
                  q['q'] as String,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 24),

                // Options
                Expanded(
                  child: ListView(
                    children: (q['opts'] as List<String>)
                        .asMap()
                        .entries
                        .map((e) {
                      final idx = e.key;
                      final opt = e.value;
                      final selected = _selectedOption == idx;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedOption = idx),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 18),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primaryBot.withOpacity(0.3)
                                  : AppColors.card,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primaryTop
                                    : const Color(0xFF2A2A2A),
                                width: selected ? 1.5 : 1,
                              ),
                            ),
                            child: Text(
                              opt,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : AppColors.textSecondary,
                                fontSize: 15,
                                fontFamily: 'Cairo',
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Navigation buttons
                Padding(
                  padding: const EdgeInsets.only(bottom: 24, top: 8),
                  child: Row(
                    children: [
                      // Previous
                      if (_currentQuestion > 0)
                        Expanded(
                          child: GestureDetector(
                            onTap: _prev,
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: AppColors.card,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: const Color(0xFF2A2A2A)),
                              ),
                              child: const Center(
                                child: Text(
                                  'السابق',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (_currentQuestion > 0) const SizedBox(width: 12),
                      // Next
                      Expanded(
                        child: GestureDetector(
                          onTap: _selectedOption != null ? _next : null,
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              gradient: _selectedOption != null
                                  ? const LinearGradient(
                                      colors: [
                                        AppColors.primaryTop,
                                        AppColors.primaryBot,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    )
                                  : null,
                              color: _selectedOption == null
                                  ? AppColors.card
                                  : null,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'التالي',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
