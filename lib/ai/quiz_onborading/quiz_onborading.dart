import '../../core/logic/api/api_service.dart';
import 'widget/quiz_onborading_item.dart';
import 'package:flutter/material.dart';

class QuizOnboradingView extends StatefulWidget {
  const QuizOnboradingView({super.key});

  @override
  State<QuizOnboradingView> createState() => _QuizOnboradingViewState();
}

class _QuizOnboradingViewState extends State<QuizOnboradingView> {
  PageController pageController = PageController();
  int currentIndex = 0;
  bool _isLoading = true;
  List<dynamic> _questions = [];

  Map<int, int> userAnswers = {};

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    final res = await ApiService.authenticatedGet('/api/general-quiz/questions');
    if (res.success && res.data != null) {
      if (mounted) {
        setState(() {
          // The API returns { "success": true, "data": [ ... ] }
          _questions = res.data['data'] ?? [];
          _isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Fallback static questions if DB fails or is empty
          _questions = [
            {'questionId': 1, 'text': 'هل تجد صعوبة في الاسترخاء؟'},
            {'questionId': 2, 'text': 'هل تشعر بالقلق باستمرار؟'},
            {'questionId': 3, 'text': 'كيف تصف شعورك العام مؤخرًا؟'}
          ];
        });
      }
    }
  }

  Future<void> _submitQuiz() async {
    setState(() => _isLoading = true);

    // Prepare data for API
    final answersPayload = userAnswers.entries.map((e) {
      final qId = _questions[e.key]['questionId'] ?? (e.key + 1);
      return {
        "questionId": qId,
        "answerValue": e.value + 1, // mapping 0-indexed option to 1..5
      };
    }).toList();

    // Call API
    final res = await ApiService.authenticatedPost('/api/general-quiz/submit', {
      "patientId": 1,
      "answers": answersPayload,
    });

    String planTitle = 'خطة تعزيز الإيجابية';
    String planDesc = 'يبدو أنك في حالة جيدة! خطتك تركز على بناء عادات إيجابية مستدامة والحفاظ على صحتك النفسية وتطوير مهاراتك الشخصية.';
    int levels = 4;
    int finalScore = 0;
    String finalDisease = 'صحة نفسية جيدة';

    if (res.success && res.data != null && res.data['data'] != null) {
      final data = res.data['data'];
      if (data['finalResult'] != null) {
        final disease = data['finalResult']['disease'] as String? ?? '';
        finalScore = data['finalResult']['score'] as int? ?? 0;
        
        if (disease.toLowerCase().contains('anxiety')) {
          finalDisease = 'القلق';
          planTitle = 'خطة تخفيف القلق والتوتر';
          planDesc = 'تشير النتيجة إلى وجود بعض التوتر أو القلق. العلاج السلوكي المعرفي (CBT) سيساعدك في تعلم تقنيات الاسترخاء وإعادة توجيه أفكارك لتستعيد هدوئك.';
          levels = 6;
        } else if (disease.toLowerCase().contains('depression')) {
          finalDisease = 'الاكتئاب';
          planTitle = 'خطة دعم وتجاوز الاكتئاب';
          planDesc = 'يبدو أنك تمر بمرحلة فيها بعض المشاعر الثقيلة أو فقدان الحماس. الجميل أن حالتك قابلة للتحسن بسهولة بمجرد أن تبدأ في اتباع خطوات الخطة المخصصة لك.';
          levels = 8;
        } else if (disease.toLowerCase().contains('overthinking')) {
          finalDisease = 'التفكير المفرط';
          planTitle = 'خطة إدارة التفكير المفرط';
          planDesc = 'التفكير المفرط يمكن أن يستنزف طاقتك. ستساعدك هذه الخطة على التركيز في الحاضر وتخفيف القلق المفرط من المستقبل.';
          levels = 5;
        } else if (disease.toLowerCase().contains('burnout')) {
          finalDisease = 'الاحتراق النفسي';
          planTitle = 'خطة التعافي من الاحتراق النفسي';
          planDesc = 'لقد استهلكت الكثير من طاقتك مؤخراً. الخطة ستركز على استعادة الشغف وإعادة بناء طاقتك من خلال تقنيات فعالة للراحة والإنجاز المتوازن.';
          levels = 6;
        } else {
          finalDisease = disease;
        }
      }
    } else {
      // Basic fallback heuristic if API fails
      finalScore = userAnswers.values.fold(0, (sum, val) => sum + (val + 1));
      if (finalScore > 20) finalDisease = 'إرهاق عام';
    }

    final planData = {
      'title': planTitle,
      'description': planDesc,
      'levels': levels.toString(),
      'score': finalScore.toString(),
      'disease': finalDisease,
    };

    if (mounted) {
      setState(() => _isLoading = false);
      // Navigate to AiAnalysisView, and pass the planData
      Navigator.pushReplacementNamed(
        context,
        '/aiAnalysis',
        arguments: planData,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _questions.length,
        itemBuilder: (context, index) => QuizOnboradingItem(
          pageController: pageController,
          currentInex: currentIndex,
          totalQuestions: _questions.length,
          questionData: _questions[index],
          selectedAnswerIndex: userAnswers[currentIndex],
          onAnswerSelected: (optIndex) {
            setState(() {
              userAnswers[currentIndex] = optIndex;
            });
          },
          onSubmit: _submitQuiz,
        ),
      ),
    );
  }
}
