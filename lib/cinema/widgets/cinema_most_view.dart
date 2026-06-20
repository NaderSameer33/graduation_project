import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaMostView extends StatelessWidget {
  final String? filter;
  const CinemaMostView({super.key, this.filter});

  @override
  Widget build(BuildContext context) {
    int count = 10;
    if (filter != null && filter != 'عرض الكل') {
      if (filter == 'الاكتئاب') count = 4;
      else if (filter == 'التفكير الزائد') count = 2;
      else count = 0;
    }

    if (count == 0) {
      return SizedBox(
        height: 188.h,
        child: Center(
          child: Text(
            'لا توجد فيديوهات لهذه الفئة',
            style: AppStyle.regular16.copyWith(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 188.h,
      child: ListView.builder(
        itemCount: count,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.r),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.cinemaVideo),
            child: const AppImage(
              image: 'cinema.png',
            ),
          ),
        ),
      ),
    );
  }
}
