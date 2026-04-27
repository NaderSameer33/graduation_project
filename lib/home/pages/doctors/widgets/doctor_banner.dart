import 'package:carousel_slider/carousel_slider.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorBanner extends StatelessWidget {
  const DoctorBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        _PromoBanner(),
      ],
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        enlargeCenterPage: true,
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.primiryColor,
            AppColors.secondryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppImage(
            image: 'doctor.png',
            width: 136.h,
            height: 165.h,
          ),

          Align(
            alignment: Alignment.center,
            child: Text(
              textAlign: TextAlign.center,
              'مع كل جلسة... خطوة أقرب \nنحو نسخة أكثر وعيًا \nواتزانًا منك',
              style: AppStyle.bold16,
            ),
          ),
        ],
      ),
    );
  }
}
