import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/cupertino.dart';

class StatChip extends StatelessWidget {
  const StatChip({
    super.key , 
    required this.icon,
    required this.label,
    this.iconColor = AppColors.textSecondary,
  });
  final IconData icon;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppStyle.regular12.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        const SizedBox(width: 4),
        Icon(icon, color: iconColor, size: 14),
      ],
    );
  }
}
