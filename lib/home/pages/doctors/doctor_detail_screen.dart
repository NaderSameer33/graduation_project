import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/home/pages/doctors/widgets/doctor_details_header.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../payment/add_card_screen.dart';
import 'write_review_screen.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.rating,
    required this.sessionPrice,
    required this.experience,
    required this.reviewCount,
    required this.sessionDuration,
  });

  final String doctorName;
  final String specialty;
  final double rating;
  final int sessionPrice;
  final int experience;
  final int reviewCount;
  final int sessionDuration;

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  final bool _isFavorite = false;

  // Sample reviews
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DoctorDetailsHeader(),

              Text(
                widget.doctorName,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              // Specialty
              Text(
                widget.specialty,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                alignment: WrapAlignment.end,
                spacing: 16,
                runSpacing: 8,
                children: [
                  _StatChip(
                    icon: Icons.access_time_rounded,
                    label: '${widget.sessionDuration} دقيقة',
                  ),
                  _StatChip(
                    icon: Icons.star_rounded,
                    label: '${widget.rating} نجوم',
                    iconColor: const Color(0xFFFFAA00),
                  ),
                  _StatChip(
                    icon: Icons.work_rounded,
                    label: '${widget.experience} سنوات خبرة',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Bio
              const Text(
                'طبيب نفسي وخبير CBT. يقدم منهجيات علمية قائمة على الأدلة لتمكينك من إدارة عواطفك وأفكارك بفاعلية.',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontFamily: 'Cairo',
                  height: 1.7,
                ),
              ),

              const _Divider(),

              // ── Location section ──────────────
              const _SectionTitle('الموقع'),
              const SizedBox(height: 6),
              const Text(
                'المنصورة، شارع بنك مصر برج الشاذلي الدور الرابع شقة 3',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 12),
              // Map placeholder
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF252525),
                  border: Border.all(
                    color: const Color(0xFF333333),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.map_rounded,
                        color: AppColors.textDisabled,
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'خريطة الموقع',
                        style: TextStyle(
                          color: AppColors.textDisabled,
                          fontFamily: 'Cairo',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const _Divider(),

              // ── Schedule ──────────────────────
              const _SectionTitle('مواعيد العمل'),
              const SizedBox(height: 6),
              const Text(
                'الاحد - الاربعاء (2 عصرا - 9 مساء)',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontFamily: 'Cairo',
                ),
              ),

              const _Divider(),

              // ── Reviews ───────────────────────
              Row(
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
              ),
              const SizedBox(height: 12),
              // Review cards
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _reviews
                    .map(
                      (r) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: _ReviewCard(review: r),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const _Divider(),

              // ── "هل قمت بزيارة هذا الدكتور؟" ──
              const Center(
                child: Text(
                  'هل قمت بزيارة هذا الدكتور ؟',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Write review button
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WriteReviewScreen(
                      doctorName: widget.doctorName,
                    ),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryTop,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'اكتب مراجعة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Book session button ────────────
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddCardScreen(),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryTop,
                        AppColors.primaryBot,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'احجز جلسة – ${widget.sessionPrice} جنية',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Supporting widgets ────────────────────────

class _StatChip extends StatelessWidget {
  const _StatChip({
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
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(width: 4),
        Icon(icon, color: iconColor, size: 14),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(color: Color(0xFF2A2A2A), height: 1),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final Map<String, dynamic> review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Reviewer name + stars
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
