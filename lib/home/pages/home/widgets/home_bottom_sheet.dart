import '../../../../core/logic/app_routes.dart';
import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBottomSheet extends StatelessWidget {
  const HomeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.all(20.r),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.school_outlined,
                    color: AppColors.whiteColor,
                  ),
                  title: Text('محتوى علاجي', style: AppStyle.bold16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.play_circle_outline,
                    color: AppColors.whiteColor,
                  ),
                  title: Text('سينما اطمئن', style: AppStyle.bold16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.nightlight_round,
                    color: AppColors.whiteColor,
                  ),
                  title: Text('تمارين نفسية', style: AppStyle.bold16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: AppColors.whiteColor,
                  ),
                  title: Text('اختبارات نفسية', style: AppStyle.bold16),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.tests);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.hourglass_empty,
                    color: AppColors.whiteColor,
                  ),
                  title: Text('تحديات نفسية', style: AppStyle.bold16),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.challenges);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.menu_book, color: AppColors.whiteColor),
                  title: Text('ركن القراءة', style: AppStyle.bold16),
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
  }
}