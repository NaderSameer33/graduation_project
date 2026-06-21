import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/core/ui/app_achievement.dart';
import 'package:etmaen/home/pages/home/models/content_model.dart';
import 'package:etmaen/home/pages/home/models/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleDetailView extends StatelessWidget {
  final String categoryTitle;
  final ContentItem? item;
  const ArticleDetailView({super.key, required this.categoryTitle, this.item});

  @override
  Widget build(BuildContext context) {
    final articleTitle = item?.title ?? categoryTitle;
    final doctorName = item?.doctorName ?? '';
    final doctorImage = item != null && item!.doctorId != null
        ? ContentRepository.getDoctorImage(item!.doctorId!)
        : 'assets/images/doctor.png';
    final body = item?.articleBody ??
        'العلاج المعرفي السلوكي (CBT) هو نهج علاجي يساعد الإنسان على فهم العلاقة بين أفكاره ومشاعره وسلوكياته. يعتمد هذا الأسلوب على ملاحظة الأفكار التلقائية التي تظهر بسرعة في المواقف اليومية، خاصة تلك التي تكون سلبية أو غير دقيقة، ثم التعامل معها بطريقة منظمة تساعد على تعديل تأثيرها.\n\nمن خلال هذا النهج، يمكن للفرد أن يكتسب أدوات عملية تساعده على التفكير بوضوح أكثر واتخاذ قرارات أفضل، مما يساهم في تحسين جودة حياته وتخفيف مشاعر القلق أو التوتر. يركز الـ CBT على الحاضر وعلى إيجاد حلول عملية للمشكلات الحالية بدلاً من الغوص عميقاً في الماضي، وهو ما يجعله فعالاً ومناسباً للكثيرين في حياتهم اليومية.';
    final categoryLabel = item?.categoryLabel ?? '';
    final description = item?.description ?? '';

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
                  Expanded(
                    child: Text(
                      articleTitle,
                      style: AppStyle.bold24.copyWith(
                          color: Colors.white,
                          fontSize: 13.sp,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
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

                    // Doctor info
                    if (doctorName.isNotEmpty) ...[
                      _buildDoctorInfo(doctorName, doctorImage),
                      SizedBox(height: 16.h),
                    ],

                    // Category & description tags
                    if (categoryLabel.isNotEmpty || description.isNotEmpty) ...[
                      if (categoryLabel.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.primiryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                                color: AppColors.primiryColor.withAlpha(80)),
                          ),
                          child: Text(
                            categoryLabel,
                            style: AppStyle.regular12.copyWith(
                              color: AppColors.primiryColor,
                            ),
                          ),
                        ),
                      if (description.isNotEmpty) ...[
                        SizedBox(height: 12.h),
                        Text(
                          description,
                          style: AppStyle.regular14.copyWith(
                            color: AppColors.greyColor,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                      SizedBox(height: 24.h),
                      Divider(color: Colors.white12, thickness: 1),
                      SizedBox(height: 24.h),
                    ],

                    // Article body
                    Text(
                      body,
                      style: AppStyle.regular16
                          .copyWith(color: Colors.white, height: 1.8),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 40.h),
                    // Achievement Button
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Show confetti and pop back
                          AppAchievement.show(context,
                              message: 'لقد أتممت قراءة المقال بنجاح!');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.w, vertical: 16.h),
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
                            style:
                                AppStyle.bold16.copyWith(color: Colors.white),
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

  Widget _buildDoctorInfo(String name, String imagePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              name,
              style: AppStyle.bold14.copyWith(color: Colors.white),
            ),
            SizedBox(height: 2.h),
            Text(
              'كاتب المقال',
              style: AppStyle.regular12.copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
        SizedBox(width: 12.w),
        Container(
          width: 44.r,
          height: 44.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.card,
            border: Border.all(color: AppColors.primiryColor.withAlpha(100), width: 2),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) =>
                Icon(Icons.person, color: Colors.white, size: 24.r),
          ),
        ),
      ],
    );
  }
}
