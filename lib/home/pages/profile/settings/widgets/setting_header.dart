import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/profile/settings/personal_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader({
    super.key,
    required this.loadProfile,
    required this.userName,
    required this.ispro,
  });
  final VoidCallback loadProfile;
  final String userName;
  final bool ispro;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const PersonalSettingsScreen(),
        ),
      ).then((_) => loadProfile()),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            AppImage(
              image: 'setting.png',
              height: 50.h,
              width: 50.w,
              isCircle: true,
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  userName,
                  style: AppStyle.bold16,
                ),
                Text(
                  ispro ? 'الخطة المدفوعة' : 'الخطة المجانية',
                  style: TextStyle(
                    color: ispro
                        ? AppColors.primaryTop
                        : AppColors.textSecondary,
                    fontSize: 12,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),

            const Spacer(),

            AppImage(
              image: 'arrow.svg',
              height: 24.h,
              width: 12.w,
            ),
          ],
        ),
      ),
    );
  }
}
