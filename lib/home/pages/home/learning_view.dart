import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    'التفكير الزائد',
  ];

  final List<Map<String, String>> items = [
    {'title': 'الامتنان', 'image': 'assets/images/depression_man.png'}, // Use placeholder or existing asset
    {'title': 'الاكتئاب', 'image': 'assets/images/depression_man.png'},
    {'title': 'التقبل', 'image': 'assets/images/depression_man.png'},
    {'title': 'التركيز', 'image': 'assets/images/depression_man.png'},
    {'title': 'القلق', 'image': 'assets/images/depression_man.png'},
    {'title': 'التعاطف', 'image': 'assets/images/depression_man.png'},
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
                  final filteredItems = activeCategory == 'عرض الكل'
                      ? items
                      : items.where((item) => item['title'] == activeCategory || item['title'] == 'الامتنان').toList();
                      
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.categoryDetail,
                              arguments: item['title']);
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
                              // Background Image Placeholder
                              // We use a dark color as fallback if image doesn't exist
                              Container(color: AppColors.avatarColor),
                              // Simulated image styling
                              Positioned.fill(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withAlpha((0.1 * 255).toInt()),
                                        Colors.black.withAlpha((0.6 * 255).toInt()),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                              // Badge
                              Positioned(
                                top: 12.h,
                                right: 12.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha((0.5 * 255).toInt()),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    item['title']!,
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
