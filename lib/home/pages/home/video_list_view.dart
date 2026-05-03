import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoListView extends StatelessWidget {
  final String categoryTitle;
  const VideoListView({super.key, required this.categoryTitle});

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
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'ستتعرف في المستوى الاول على الأسباب النفسية والسلوكية للاكتئاب الخفيف وكيفية فهم حالتك للبدء في العلاج مع منهج علاجي قائم على ال CBT',
                          style: AppStyle.regular16.copyWith(color: Colors.white, height: 1.8),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 24.h),
                        _buildProgressBar(),
                        SizedBox(height: 24.h),
                        _buildDoctorInfo('د محمد الامام'),
                        SizedBox(height: 24.h),
                        // Video List
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            final titles = [
                              'ما هو الاكتئاب الخفيف ؟',
                              'اساسيات العلاج بال CBT',
                              'تحديد التفكير الاسود والابيض'
                            ];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.cinemaVideo);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: AppColors.card,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        color: AppColors.avatarColor,
                                        borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
                                        child: Image.asset(
                                          'assets/images/depression_man.png',
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
                                            'المستوى الاول • فيديو ${index + 1} • 20 دقيقة',
                                            style: AppStyle.regular12.copyWith(color: AppColors.greyColor),
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            titles[index],
                                            style: AppStyle.bold16.copyWith(color: Colors.white),
                                            textAlign: TextAlign.right,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 80.h), // space for mini player
                      ],
                    ),
                  ),
                  // Mini Player
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                         Navigator.pushNamed(context, AppRoutes.cinemaVideo);
                      },
                      child: Container(
                        height: 80.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(128),
                              blurRadius: 10,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Play Button
                            Container(
                              height: 48.r,
                              width: 48.r,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.play_arrow, color: Colors.black, size: 28.r),
                            ),
                            Text(
                              'اساسيات العلاج بال CBT',
                              style: AppStyle.regular16.copyWith(color: Colors.white),
                            ),
                            // Thumbnail
                            Container(
                              height: 48.r,
                              width: 48.r,
                              decoration: BoxDecoration(
                                color: AppColors.avatarColor,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                'assets/images/depression_man.png',
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => const SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
