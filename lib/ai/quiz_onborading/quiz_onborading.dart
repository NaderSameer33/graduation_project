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
  @override
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
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => QuizOnboradingItem(
          pageController: pageController,
          currentInex: currentIndex,
        ),
      ),
    );
  }
}
