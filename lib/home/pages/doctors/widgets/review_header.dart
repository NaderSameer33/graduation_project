
import '../../../../core/ui/app_color.dart';
import '../doctor_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewHeader extends StatelessWidget {
  const ReviewHeader({
    super.key,
    required this.widget,
  });

  final DoctorDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(
            5,
            (_) => const Icon(
              Icons.star_rounded,
              color: Color(0xFFFFAA00),
              size: 16,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '(${widget.reviewCount} مراجعة)',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontFamily: 'Cairo',
          ),
        ),
        const Spacer(),
        const Text(
          'المراجعات',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}