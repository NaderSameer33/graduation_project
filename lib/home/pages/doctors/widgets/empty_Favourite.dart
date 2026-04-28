import 'package:etmaen/core/ui/app_color.dart';
import 'package:flutter/material.dart';

class EmptyFavorites extends StatelessWidget {
  const EmptyFavorites({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            color: AppColors.textDisabled,
            size: 60,
          ),
          SizedBox(height: 16),
          Text(
            'لم تضف أي دكتور للمفضلة بعد',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontFamily: 'Cairo',
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}