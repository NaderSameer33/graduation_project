import 'package:flutter/material.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';

// ─────────────────────────────────────────────
//  Settings Group  – card container with dividers
// ─────────────────────────────────────────────
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.items});
  final List<SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: List.generate(items.length * 2 - 1, (i) {
            if (i.isOdd) {
              return const Divider(
                  height: 1, color: Color(0xFF2A2A2A), indent: 16);
            }
            return items[i ~/ 2];
          }),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Settings Item  – single row in a SettingsGroup
// ─────────────────────────────────────────────
class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.showChevron = false,
    this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Left: chevron or custom trailing widget
            if (showChevron)
              const Icon(Icons.chevron_left_rounded,
                  color: AppColors.textSecondary, size: 20)
            else if (trailing != null)
              trailing!,
            const Spacer(),
            // Right: label + icon
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon,
                color: iconColor ?? AppColors.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }
}
