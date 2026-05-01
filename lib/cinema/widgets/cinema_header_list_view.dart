import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaHeaderListView extends StatefulWidget {
  const CinemaHeaderListView({
    super.key,
  });

  @override
  State<CinemaHeaderListView> createState() => _CinemaHeaderListViewState();
}

class _CinemaHeaderListViewState extends State<CinemaHeaderListView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            margin: EdgeInsets.symmetric(horizontal: 7.r),
            alignment: Alignment.center,
            width: 78.w,
            decoration: BoxDecoration(
              color: index == currentIndex
                  ? AppColors.primiryColor
                  : AppColors.card,
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Text(
              index == 0 ? 'عرض الكل' : 'تقبل الذات',
              style: AppStyle.bold12.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
