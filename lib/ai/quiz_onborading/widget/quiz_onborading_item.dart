import 'quiz_question.dart';
import '../../../core/logic/app_routes.dart';
import '../../../core/ui/app_button.dart';
import '../../../core/ui/app_color.dart';
import '../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizOnboradingItem extends StatefulWidget {
  const QuizOnboradingItem({
    super.key,
    required this.currentInex,
    required this.pageController,
  });

  final int currentInex;
  final PageController pageController;

  @override
  State<QuizOnboradingItem> createState() => _QuizOnboradingItemState();
}

class _QuizOnboradingItemState extends State<QuizOnboradingItem> {
  double oldProgress = 0;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final int totalQuestions = 3;
    final double newProgress = (widget.currentInex + 1) / totalQuestions;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: oldProgress,
                end: newProgress,
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              onEnd: () {
                oldProgress = newProgress;
              },
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 8.h,
                  backgroundColor: AppColors.inputHintColor,
                  color: AppColors.primiryColor,
                  borderRadius: BorderRadius.circular(32.r),
                );
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'هل انت على دراية بالدعم',
                style: AppStyle.bold19.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'نحن نطبق اساليب العلاج المعرفي السلوكي \n(CBT) المثبتة ما مدى معرفتك بهذا النهج',
                style: AppStyle.regular16.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            ...List.generate(
              3,
              (index) => QuizQuestion(
                isSelected: selectedIndex == index,
                onTap: () {
                  selectedIndex = index;
                  setState(() {});
                },
                currentIndex: index,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            AppButton(
              onTap: () {
                if (widget.currentInex == 2) {
                  Navigator.pushNamed(context, AppRoutes.aiAnalysis);
                } else {
                  widget.pageController.nextPage(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              title: 'المتابعه',
            ),
          ],
        ),
      ),
    );
  }
}
