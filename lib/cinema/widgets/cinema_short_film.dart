
import 'package:etmaen/core/ui/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaShortFilm extends StatelessWidget {
  const CinemaShortFilm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 172.h,
    
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 12.r),
          width: 124.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: AppImage(image: 'short_film.png'),
        ),
      ),
    );
  }
}
