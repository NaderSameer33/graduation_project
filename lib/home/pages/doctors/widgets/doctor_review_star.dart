import 'package:flutter/material.dart';

class DoctorReviewStar extends StatefulWidget {
  const DoctorReviewStar({super.key});

  @override
  State<DoctorReviewStar> createState() => _DoctorReviewStarState();
}

class _DoctorReviewStarState extends State<DoctorReviewStar> {
  int _stars = 5;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (i) {
        final starIndex = 5 - i;
        return GestureDetector(
          onTap: () => setState(() => _stars = starIndex),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Icon(
              Icons.star_rounded,
              color: starIndex <= _stars
                  ? const Color(0xFFFFAA00)
                  : const Color(0xFF3A3A3A),
              size: 36,
            ),
          ),
        );
      }),
    );
  }
}
