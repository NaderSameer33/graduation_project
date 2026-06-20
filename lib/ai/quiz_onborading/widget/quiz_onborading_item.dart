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
    required this.totalQuestions,
    required this.questionData,
    this.selectedAnswerIndex,
    required this.onAnswerSelected,
    required this.onSubmit,
  });

  final int currentInex;
  final PageController pageController;
  final int totalQuestions;
  final dynamic questionData;
  final int? selectedAnswerIndex;
  final ValueChanged<int> onAnswerSelected;
  final VoidCallback onSubmit;

  @override
  State<QuizOnboradingItem> createState() => _QuizOnboradingItemState();
}

class _QuizOnboradingItemState extends State<QuizOnboradingItem> {
  double oldProgress = 0;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final double newProgress = (widget.currentInex + 1) / widget.totalQuestions;
    final String title = widget.questionData['title'] ?? 'سؤال';
    final String text = widget.questionData['text'] ?? '';
    // The API does not return options, so we use the standard assessment options
    final List<String> options = [
      'لا أوافق إطلاقاً',
      'نادراً',
      'أحياناً',
      'غالباً',
      'دائماً'
    ];

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
                title,
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
                text,
                style: AppStyle.regular16.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            ...List.generate(
              options.length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: GestureDetector(
                  onTap: () {
                    widget.onAnswerSelected(index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: widget.selectedAnswerIndex == index ? AppColors.primiryColor : AppColors.inputColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: widget.selectedAnswerIndex == index ? AppColors.primiryColor : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            options[index].toString(),
                            style: AppStyle.regular16.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        if (widget.selectedAnswerIndex == index)
                          Icon(Icons.check_circle, color: Colors.white, size: 24.r),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            AppButton(
              onTap: () {
                if (widget.selectedAnswerIndex == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('الرجاء اختيار إجابة للمتابعة', style: TextStyle(fontFamily: 'Cairo')),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }

                if (widget.currentInex == widget.totalQuestions - 1) {
                  widget.onSubmit();
                } else {
                  widget.pageController.nextPage(
                    duration: const Duration(seconds: 1),
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
