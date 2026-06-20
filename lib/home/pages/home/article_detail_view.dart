import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/core/ui/app_achievement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleDetailView extends StatelessWidget {
  final String categoryTitle;
  const ArticleDetailView({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$categoryTitle',
                    style: AppStyle.bold24.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 16.w),
                  const AppBack(),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildProgressBar(),
                    SizedBox(height: 24.h),
                    _buildDoctorInfo('د يايليم لي'),
                    SizedBox(height: 24.h),
                    Text(
                      'العلاج المعرفي السلوكي (CBT) هو نهج علاجي يساعد الإنسان على فهم العلاقة بين أفكاره ومشاعره وسلوكياته. يعتمد هذا الأسلوب على ملاحظة الأفكار التلقائية التي تظهر بسرعة في المواقف اليومية، خاصة تلك التي تكون سلبية أو غير دقيقة، ثم التعامل معها بطريقة منظمة تساعد على تعديل تأثيرها.\n\nمن خلال هذا النهج، يمكن للفرد أن يكتسب أدوات عملية تساعده على التفكير بوضوح أكثر واتخاذ قرارات أفضل، مما يساهم في تحسين جودة حياته وتخفيف مشاعر القلق أو التوتر. يركز الـ CBT على الحاضر وعلى إيجاد حلول عملية للمشكلات الحالية بدلاً من الغوص عميقاً في الماضي، وهو ما يجعله فعالاً ومناسباً للكثيرين في حياتهم اليومية.',
                      style: AppStyle.regular16.copyWith(color: Colors.white, height: 1.8),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 40.h),
                    // Achievement Button
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Show confetti and pop back
                          AppAchievement.show(context, message: 'لقد أتممت قراءة المقال بنجاح!');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            color: AppColors.primiryColor,
                            borderRadius: BorderRadius.circular(30.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primiryColor.withAlpha(100),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            'إنهاء المقال',
                            style: AppStyle.bold16.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '10% مكتمل',
              style: AppStyle.regular12.copyWith(color: Colors.white),
            ),
            Text(
              '12 جلسة',
              style: AppStyle.regular12.copyWith(color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: 0.1,
            backgroundColor: AppColors.card,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primiryColor),
            minHeight: 8.h,
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorInfo(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          name,
          style: AppStyle.regular16.copyWith(color: Colors.white),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 40.r,
          height: 40.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'assets/images/doctor.png',
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Icon(Icons.person, color: Colors.black, size: 24.r),
          ),
        ),
      ],
    );
  }
}
