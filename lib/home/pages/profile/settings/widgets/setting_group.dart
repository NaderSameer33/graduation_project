
import '../../../../../core/ui/app_color.dart';
import 'setting_item.dart';
import 'package:flutter/material.dart';

class SettingGroup extends StatelessWidget {
  const SettingGroup({required this.items , super.key});
  final List<SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(items.length * 2 - 1, (i) {
          if (i.isOdd) {
            return const Divider(
              height: 1,
              color: Color(0xFF2A2A2A),
              indent: 16,
            );
          }
          return items[i ~/ 2];
        }),
      ),
    );
  }
}