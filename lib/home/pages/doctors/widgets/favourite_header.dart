import '../../../../core/ui/app_back.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';

class FavouriteHeader extends StatelessWidget {
  const FavouriteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppBack(),
        const Spacer(),
        Text(
          'الدكاترة المفضلة',
          style: AppStyle.bold16,
        ),
        const Spacer(),
       
      ],
    );
  }
}
