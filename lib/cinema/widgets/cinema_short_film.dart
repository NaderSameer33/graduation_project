import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/logic/app_routes.dart';

class CinemaShortFilm extends StatelessWidget {
  final String? filter;
  const CinemaShortFilm({super.key, this.filter});

  @override
  Widget build(BuildContext context) {
    int count = 10;
    if (filter != null && filter != 'عرض الكل') {
      if (filter == 'الاجهاد والقلق') count = 5;
      else if (filter == 'التفكير الزائد') count = 3;
      else count = 0;
    }

    if (count == 0) {
      return SizedBox(
        height: 172.h,
        child: Center(
          child: Text(
            'لا توجد أفلام قصيرة لهذه الفئة',
            style: AppStyle.regular16.copyWith(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 172.h,
      child: ListView.builder(
        itemCount: count,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.cinemaVideo),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.r),
            width: 124.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const AppImage(image: 'short_film.png'),
          ),
        ),
      ),
    );
  }
}
