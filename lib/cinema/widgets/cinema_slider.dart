import 'package:carousel_slider/carousel_slider.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaSlider extends StatefulWidget {
  const CinemaSlider({
    super.key,
  });

  @override
  State<CinemaSlider> createState() => _CinemaSliderState();
}

class _CinemaSliderState extends State<CinemaSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: [
            AppImage(image: 'cinema.png'),
            AppImage(image: 'cinema.png'),
            AppImage(image: 'cinema.png'),
            AppImage(image: 'cinema.png'),
            AppImage(image: 'cinema.png'),
          ],
          options: CarouselOptions(
            viewportFraction: 1,

            onPageChanged: (index, _) {
              setState(() {
                currentIndex = index;
              });
            },

            autoPlayCurve: Curves.linear,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            enlargeCenterPage: true,
          ),
        ),

        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              5,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 500),
                margin: EdgeInsets.symmetric(horizontal: 4.r),
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex == index
                      ? AppColors.primiryColor
                      : AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
