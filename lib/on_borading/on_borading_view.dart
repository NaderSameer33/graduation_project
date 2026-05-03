import 'model/on_borading_model.dart';
import 'widget/on_borading_item.dart';
import 'package:flutter/material.dart';

class OnBoradingView extends StatefulWidget {
  const OnBoradingView({super.key});

  @override
  State<OnBoradingView> createState() => _OnBoradingViewState();
}

class _OnBoradingViewState extends State<OnBoradingView> {
  final list = const [
    OnBoradingModel(
      image: 'on_borading_2.png',
      title: 'اعادة صياغة الافكار السلبية',
      subtitle:
          'تحليل أفكارك المرهِقة باستخدام الذكاء\n الاصطناعي واعادة بنائها بأسلوب علمي يساعدك\n على كسر دوائر التفكير السلبي ورؤية الأمور\n بشكل أوضح وأكثر توازنًا.',
    ),
    OnBoradingModel(
      image: 'on_borading_3.png',
      title: 'تحديات نفسية',
      subtitle:
          'لمساعدتك على استعادة طاقتك وتحسين \nحالتك النفسية من خلال خطوات صغيرة قابلة\n للتنفيذ في حياتك اليومية.',
    ),
    OnBoradingModel(
      image: 'on_borading_4.png',
      title: 'جلسات دعم نفسي',
      subtitle:
          'استمتع بتمارين تهدئة، جلسات صوتية\n، فيديوهات ومقالات تساعدك على تقليل\n التوتر واستعادة التوازن النفسي في أي وقت.',
    ),
    OnBoradingModel(
      image: 'on_borading_5.png',
      title: 'اختبارات نفسية ',
      subtitle:
          'نقدم مجموعة اختبارات نفسية مبنية على\n مقاييس عالمية، نساعدك على فهم حالتك\n النفسية بدقة.',
    ),
    OnBoradingModel(
      image: 'on_borading_6.png',
      title: 'الاهتمام بصحتك النفسية',
      subtitle:
          ' هي اول خطوة نحو استعادة طاقتك وحيويتكاطمئن يمنحك الفرصة لتروي روحك وتعيد إليها الحياة من جديد ',
    ),
  ];

  late PageController pageController;
  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: list.length,
        itemBuilder: (context, index) => OnBoradingItem(
          pageController: pageController,
          index: index,
          model: list[index],
        ),
      ),
    );
  }
}
