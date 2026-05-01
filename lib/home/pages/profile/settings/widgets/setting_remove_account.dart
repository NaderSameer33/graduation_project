import 'package:etmaen/core/logic/helper_method.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingRemoveAccount extends StatelessWidget {
  const SettingRemoveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return 
              GestureDetector(
                onTap: () => showDeleteDialog(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  height: 62.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.card,
                  ),
                  child: Row(
                    children: [
                      AppImage(image: 'trash.svg'),
                      SizedBox(width: 6),
                      Text(
                        'حذف حسابي على التطبيق',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}