import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetailView extends StatefulWidget {
  final String categoryTitle;
  const CategoryDetailView({super.key, required this.categoryTitle});

  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  int currentTab = 0;
  // Ordered from Right to Left in RTL: Videos, Podcasts, Articles
  final List<String> tabs = ['فيديوهات', 'بودكاست', 'مقالات'];

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
                    'علاج ${widget.categoryTitle}',
                    style: AppStyle.bold24.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 16.w),
                  const AppBack(),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // Tabs
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(tabs.length, (index) {
                  final isSelected = currentTab == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 105.w,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primiryColor : AppColors.card,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : Colors.white12,
                        ),
                      ),
                      child: Text(
                        tabs[index],
                        style: AppStyle.bold12.copyWith(
                          color: isSelected ? Colors.white : AppColors.greyColor,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 24.h),
            // Dynamic Content
            Expanded(
              child: _buildDynamicContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicContent() {
    return _buildLevelList();
  }

  Widget _buildLevelList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      physics: const BouncingScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        final isLocked = index > 0;
        final levels = ['الاول', 'الثاني', 'الثالث', 'الرابع'];
        return GestureDetector(
          onTap: () {
            if (!isLocked) {
              final titleArgs = 'علاج ${widget.categoryTitle} الخفيف';
              if (currentTab == 0) { // Videos
                Navigator.pushNamed(context, AppRoutes.videoList, arguments: titleArgs);
              } else if (currentTab == 1) { // Podcasts
                Navigator.pushNamed(context, AppRoutes.audioPlayer, arguments: {
                  'title': titleArgs,
                  'subtitle': 'المستوى ${levels[index]}'
                });
              } else if (currentTab == 2) { // Articles
                Navigator.pushNamed(context, AppRoutes.articleDetail, arguments: titleArgs);
              }
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16.h),
            height: 140.h,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: 120.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
                        color: AppColors.avatarColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
                        child: Image.asset(
                          'assets/images/doctor.png',
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => const SizedBox(),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'علاج ${widget.categoryTitle} الخفيف',
                            style: AppStyle.bold16.copyWith(color: Colors.white),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'المستوى ${levels[index]}',
                            style: AppStyle.regular12.copyWith(color: AppColors.greyColor),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                  ],
                ),
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(100),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      '12 جلسة',
                      style: AppStyle.regular12.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                if (isLocked)
                  Positioned(
                    bottom: 12.h,
                    right: 12.w,
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(100),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.lock_outline, color: Colors.white, size: 16.r),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
