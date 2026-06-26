import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'models/audio_relaxing_model.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  int currentIndex = 0;
  final List<String> categories = [
    'عرض الكل',
    'أصوات الطبيعة',
    'النوم المريح',
    'الاسترخاء',
    'التأمل واليقظة',
  ];

  late final List<AudioRelaxing> exercises;

  @override
  void initState() {
    super.initState();
    exercises = AudioRelaxing.getAll();
  }

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
                    'جلسات استرخاء',
                    style: AppStyle.bold24.copyWith(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
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
            // List
            Expanded(
              child: Builder(builder: (context) {
                final activeCategory = categories[currentIndex];
                final filteredExercises = activeCategory == 'عرض الكل'
                    ? exercises
                    : exercises.where((ex) {
                        String engCategory = '';
                        switch (activeCategory) {
                          case 'أصوات الطبيعة':
                            engCategory = 'nature';
                            break;
                          case 'النوم المريح':
                            engCategory = 'sleep';
                            break;
                          case 'الاسترخاء':
                            engCategory = 'relaxation';
                            break;
                          case 'التأمل واليقظة':
                            engCategory = 'meditation';
                            break;
                        }
                        return ex.category == engCategory;
                      }).toList();

                if (filteredExercises.isEmpty) {
                  return Center(
                    child: Text(
                      'لا توجد تمارين حالياً',
                      style: AppStyle.regular16
                          .copyWith(color: AppColors.greyColor),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredExercises.length,
                  itemBuilder: (context, index) {
                    final ex = filteredExercises[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.audioPlayer,
                            arguments: {
                              'title': ex.titleAr,
                              'subtitle': 'جلسة استرخاء',
                              'fileName': ex.fileName,
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            // Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'جلسة استرخاء',
                                        style: AppStyle.regular12.copyWith(
                                            color: AppColors.greyColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    ex.titleAr,
                                    style: AppStyle.bold16
                                        .copyWith(color: Colors.white),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 24.w),
                            // Play Icon
                            Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(Icons.play_arrow,
                                  color: Colors.white, size: 28.r),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
