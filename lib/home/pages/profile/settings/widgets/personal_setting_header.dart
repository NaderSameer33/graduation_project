import 'dart:math';

import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';

class PersonalSettingHeader extends StatelessWidget {
  const PersonalSettingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'تعديل بياناتك الشخصية',
          overflow: TextOverflow.ellipsis,
          style: AppStyle.bold16,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Transform.rotate(
              angle: pi / 2,
              child: AppImage(image: 'arrow_back.svg'),
            ),
          ),
        ),
      ],
    );
  }
}
