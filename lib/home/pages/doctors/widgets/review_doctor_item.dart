import 'package:etmaen/core/ui/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewDoctorItem extends StatefulWidget {
  const ReviewDoctorItem({
    super.key,
  });

  @override
  State<ReviewDoctorItem> createState() => _ReviewDoctorItemState();
}

class _ReviewDoctorItemState extends State<ReviewDoctorItem> {
  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'فريده محمد',
      'rating': 5,
      'text':
          'تجربة مفيده جدا وممتعة واسلوب الدكتور هادي ومتفهم يجعلك تفهم افكارك اكثر وشعرت بفرق كبير في',
    },
    {
      'name': 'ليلى احمد',
      'rating': 3,
      'text':
          'تجربة مفيده جدا وممتعة الدكتور هادي ومتفهم وافكارك اكثر وشعرت بتحسن في تعاملي مع القلق وال',
    },
    {
      'name': 'فريده محمد',
      'rating': 5,
      'text':
          'تجربة مفيده جدا وممتعة واسلوب الدكتور هادي ومتفهم يجعلك تفهم افكارك اكثر وشعرت بفرق كبير في',
    },
    {
      'name': 'ليلى احمد',
      'rating': 3,
      'text':
          'تجربة مفيده جدا وممتعة الدكتور هادي ومتفهم وافكارك اكثر وشعرت بتحسن في تعاملي مع القلق وال',
    },
    {
      'name': 'فريده محمد',
      'rating': 5,
      'text':
          'تجربة مفيده جدا وممتعة واسلوب الدكتور هادي ومتفهم يجعلك تفهم افكارك اكثر وشعرت بفرق كبير في',
    },
    {
      'name': 'ليلى احمد',
      'rating': 3,
      'text':
          'تجربة مفيده جدا وممتعة الدكتور هادي ومتفهم وافكارك اكثر وشعرت بتحسن في تعاملي مع القلق وال',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 142.h,

      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _reviews.length,
        itemBuilder: (context, index) => _ReviewCard(
          review: _reviews[index],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final Map<String, dynamic> review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.r),
      width: 221.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Row(
                children: List.generate(
                  review['rating'] as int,
                  (_) => const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFAA00),
                    size: 12,
                  ),
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  review['name'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            review['text'] as String,
            textAlign: TextAlign.right,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontFamily: 'Cairo',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
