import 'package:carousel_slider/carousel_slider.dart';
import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/home/models/content_model.dart';
import 'package:etmaen/home/pages/home/models/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaSlider extends StatefulWidget {
  const CinemaSlider({super.key});

  @override
  State<CinemaSlider> createState() => _CinemaSliderState();
}

class _CinemaSliderState extends State<CinemaSlider> {
  int currentIndex = 0;
  late final List<ContentItem> _featured;

  @override
  void initState() {
    super.initState();
    // Pick 5 featured videos from the repository
    _featured = ContentRepository.getAll()
        .where((e) => e.isVideo)
        .take(5)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_featured.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _featured.length,
          itemBuilder: (context, index, _) {
            final item = _featured[index];
            final img = ContentRepository.getDoctorImage(item.id);
            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.cinemaVideo,
                arguments: item,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.card,
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Thumbnail
                    Image.asset(
                      img,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) =>
                          Container(color: AppColors.avatarColor),
                    ),
                    // Dark gradient overlay
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(200),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    // Category badge
                    Positioned(
                      top: 12.h,
                      left: 12.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.primiryColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          item.categoryLabel,
                          style:
                              AppStyle.regular12.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    // Play button
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white30, width: 2),
                        ),
                        child: Icon(Icons.play_arrow_rounded,
                            color: Colors.white, size: 32.r),
                      ),
                    ),
                    // Title at bottom
                    Positioned(
                      bottom: 12.h,
                      right: 12.w,
                      left: 12.w,
                      child: Text(
                        item.title,
                        style: AppStyle.bold14.copyWith(color: Colors.white),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) {
              setState(() {
                currentIndex = index;
              });
            },
            autoPlayCurve: Curves.easeInOut,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            enlargeCenterPage: false,
          ),
        ),

        SizedBox(height: 10.h),

        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _featured.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: EdgeInsets.symmetric(horizontal: 4.r),
              height: 8.h,
              width: currentIndex == index ? 24.w : 8.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: currentIndex == index
                    ? AppColors.primiryColor
                    : AppColors.whiteColor.withAlpha(80),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
