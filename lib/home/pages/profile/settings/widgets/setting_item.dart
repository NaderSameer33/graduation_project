import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem({
    super.key,
    required this.label,

    this.onTap,
    required this.iconName,
    this.isSwitch = false,
  });

  final String label;
  final String iconName;
  final bool isSwitch;

  final VoidCallback? onTap;

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            AppImage(image: widget.iconName),
            SizedBox(width: 10.w),
            Text(
              widget.label,
              style: AppStyle.bold16,
            ),
            Spacer(),

            widget.isSwitch
                ? Switch(
                    value: isSwitch,
                    onChanged: (value) {
                      setState(() {
                        isSwitch = value;
                      });
                    },
                    activeColor: AppColors.primaryTop,
                    inactiveTrackColor: AppColors.textDisabled,
                  )
                : AppImage(
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
