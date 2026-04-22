import 'package:etmaen/core/ui/app_button.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/views/widgets/app_plan_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButtomSheet extends StatefulWidget {
  const AppButtomSheet({super.key});

  @override
  State<AppButtomSheet> createState() => _AppButtomSheetState();
}

class _AppButtomSheetState extends State<AppButtomSheet> {
  final list = [
    HomeBottomSheetModel(image: '😔', title: 'متعب'),
    HomeBottomSheetModel(image: '😌', title: 'هادئ'),
    HomeBottomSheetModel(image: '😎', title: 'قلق | خائف'),
    HomeBottomSheetModel(image: '🤔', title: 'غاضب'),
    HomeBottomSheetModel(image: '😒', title: 'فاقد الامل'),
    HomeBottomSheetModel(image: '😁', title: 'حزين'),
  ];
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            'ما هو شعورك الآن ؟',
            style: AppStyle.bold24,
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 290.h,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                childAspectRatio: 166.w / 88.h,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => AppPlanItem(
                title: list[index].image,
                subTitle: list[index].title,
                isSelceted: currentIndex == index,
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Flexible(
            child: AppButton(
              onTap: () => Navigator.pop(context),
              title: 'استمر',
            ),
          ),
        ],
      ),
    );
  }
}

class HomeBottomSheetModel {
  final String title, image;
  const HomeBottomSheetModel({required this.image, required this.title});
}
