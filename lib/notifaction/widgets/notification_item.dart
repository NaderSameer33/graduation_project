import '../../core/ui/app_color.dart';
import '../../core/ui/app_style.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyle.regular20,
        ),
        Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            'مسح الكل',
            style: AppStyle.regular12.copyWith(
              color: AppColors.errorColro,
            ),
          ),
        ),
      ],
    );
  }
}
