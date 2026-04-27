import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/doctors/widgets/doctor_details_header.dart';
import 'package:etmaen/home/pages/doctors/widgets/review_doctor_item.dart';
import 'package:etmaen/home/pages/doctors/widgets/review_header.dart';
import 'package:etmaen/home/pages/doctors/widgets/statchip.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DoctorDetailsHeader(),
              SizedBox(
                height: 10.h,
              ),

              Text(
                widget.doctorName,
                style: AppStyle.bold16,
              ),
              SizedBox(height: 4.h),
              Text(
                widget.specialty,
                style: AppStyle.regular12,
              ),
              SizedBox(height: 12.h),

              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  StatChip(
                    icon: Icons.access_time_rounded,
                    label: '${widget.sessionDuration} دقيقة',
                  ),
                  StatChip(
                    icon: Icons.star_rounded,
                    label: '${widget.rating} نجوم',
                    iconColor: const Color(0xFFFFAA00),
                  ),
                  StatChip(
                    icon: Icons.work_rounded,
                    label: '${widget.experience} سنوات خبرة',
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              Text(
                'طبيب نفسي وخبير CBT. يقدم منهجيات علمية قائمة على الأدلة لتمكينك من إدارة عواطفك وأفكارك بفاعلية.',
                textAlign: TextAlign.right,
                style: AppStyle.regular12,
              ),

              const _Divider(),

              const _SectionTitle('الموقع'),
              SizedBox(height: 6.h),
              Text(
                'المنصورة، شارع بنك مصر برج الشاذلي الدور الرابع شقة 3',
                textAlign: TextAlign.right,
                style: AppStyle.regular12.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: 12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: AppImage(image: 'map.png'),
              ),

              const _Divider(),

              const _SectionTitle('مواعيد العمل'),
              SizedBox(height: 6.h),
              Text(
                'الاحد - الاربعاء (2 عصرا - 9 مساء)',
                style: AppStyle.regular12,
              ),

              const _Divider(),

              ReviewHeader(widget: widget),
              SizedBox(height: 12.h),
              ReviewDoctorItem(),
              const _Divider(),

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



class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.right,
      style: AppStyle.bold16,
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
