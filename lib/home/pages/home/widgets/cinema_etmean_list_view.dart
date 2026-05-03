import '../../../../core/ui/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaEtmeanListView extends StatelessWidget {
  const CinemaEtmeanListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188.h,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (contex, index) => CinemaEtmeanLisItem(),
      ),
    );
  }
}

class CinemaEtmeanLisItem extends StatelessWidget {
  const CinemaEtmeanLisItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 13.r),
      width: 312.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: AppImage(image: 'cinema.png'),
    );
  }
}
