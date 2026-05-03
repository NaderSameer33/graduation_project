import '../../../core/ui/app_color.dart';
import '../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizQuestion extends StatefulWidget {
  const QuizQuestion({super.key, required this.currentIndex, required this.isSelected, required this.onTap});
  final int currentIndex;
  final bool isSelected  ; 
final VoidCallback onTap ; 


  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  final list = const [
    QuestionModel(title: 'اسمع عن العلاج المعرفي السلوكي للمرة الاولى'),
    QuestionModel(title: 'انا على دراية جيدة بالمنهجية'),
    QuestionModel(title: 'أنا معالج نفسي محترف'),
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap , 
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        height: 68.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: widget.isSelected ? AppColors.primiryColor : AppColors.inputColor,
        ),
        child: Text(
          list[widget.currentIndex].title,
          style: AppStyle.regular16.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

class QuestionModel {
  final String title;
  const QuestionModel({required this.title});
}
