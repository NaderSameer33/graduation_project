import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaHeaderListView extends StatefulWidget {
  final Function(String) onFilterChanged;
  const CinemaHeaderListView({super.key, required this.onFilterChanged});

  @override
  State<CinemaHeaderListView> createState() => _CinemaHeaderListViewState();
}

class _CinemaHeaderListViewState extends State<CinemaHeaderListView> {
  int currentIndex = 0;
  final List<String> categories = [
    'عرض الكل',
    'تقبل الذات',
    'التحكم في القلق',
    'الثقة بالنفس',
    'الصمود النفسي'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        reverse: true, // Arabic right-to-left layout
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = index;
            });
            widget.onFilterChanged(categories[index]);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 7.r),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: index == currentIndex
                  ? AppColors.primiryColor
                  : AppColors.card,
              borderRadius: BorderRadius.circular(32.r),
              border: Border.all(
                color: index == currentIndex ? Colors.transparent : Colors.white12,
              )
            ),
            child: Text(
              categories[index],
              style: AppStyle.bold12.copyWith(
                color: index == currentIndex ? AppColors.whiteColor : AppColors.greyColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
