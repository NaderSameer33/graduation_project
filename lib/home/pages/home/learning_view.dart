import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'models/content_model.dart';
import 'models/content_repository.dart';

class LearningView extends StatefulWidget {
  const LearningView({super.key});

  @override
  State<LearningView> createState() => _LearningViewState();
}

class _LearningViewState extends State<LearningView> {
  int currentIndex = 0;
  final List<String> categories = [
    'عرض الكل',
    'الاكتئاب',
    'الاجهاد والقلق',
    'الاحتراق النفسي',
    'التفكير الزائد',
  ];

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
                    'محتوى علاجي توعوي',
                    style: AppStyle.bold24.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 16.w),
                  const AppBack(),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // Filter Chips
            SizedBox(
              height: 40.h,
              child: ListView.builder(
                itemCount: categories.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                reverse: true, // Arabic right-to-left layout
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 7.r),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? AppColors.primiryColor
                          : AppColors.card,
                      borderRadius: BorderRadius.circular(32.r),
                      border: Border.all(
                        color: index == currentIndex
                            ? Colors.transparent
                            : Colors.white12,
                      ),
                    ),
                    child: Text(
                      categories[index],
                      style: AppStyle.bold12.copyWith(
                        color: index == currentIndex
                            ? AppColors.whiteColor
                            : AppColors.greyColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            // Grid
            Expanded(
              child: Builder(
                builder: (context) {
                  final activeCategory = categories[currentIndex];
                  int? filterConditionId;
                  if (activeCategory == 'الاكتئاب') filterConditionId = 1;
                  if (activeCategory == 'الاجهاد والقلق') filterConditionId = 2;
                  if (activeCategory == 'الاحتراق النفسي') filterConditionId = 3;
                  if (activeCategory == 'التفكير الزائد') filterConditionId = 4;

                  final List<ContentItem> filteredItems = filterConditionId == null
                      ? ContentRepository.getAll()
                      : ContentRepository.getByCondition(filterConditionId);
                      
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      final doctorImage = ContentRepository.getDoctorImage(index);
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context, 
                            AppRoutes.categoryDetail,
                            arguments: item.categoryLabel,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: AppColors.card,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Background Doctor Image from assets
                              Image.asset(
                                doctorImage,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(color: AppColors.avatarColor),
                              ),
                              // Simulated image styling (gradient overlay)
                              Positioned.fill(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withAlpha((0.1 * 255).toInt()),
                                        Colors.black.withAlpha((0.7 * 255).toInt()),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                              // Title Overlay at Bottom
                              Positioned(
                                bottom: 12.h,
                                left: 12.w,
                                right: 12.w,
                                child: Text(
                                  item.title,
                                  style: AppStyle.bold12.copyWith(color: Colors.white),
                                  textAlign: TextAlign.right,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              // Category Badge at Top Right
                              Positioned(
                                top: 12.h,
                                right: 12.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha((0.6 * 255).toInt()),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    item.categoryLabel,
                                    style: AppStyle.regular12
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
