import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaMostView extends StatelessWidget {
  const CinemaMostView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188.h,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.r),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.cinemaVideo),
            child: AppImage(image: 'cinema.png'),
          ),
        ),
      ),
    );
  }
}
