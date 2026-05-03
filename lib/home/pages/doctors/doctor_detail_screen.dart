import '../../../core/ui/app_button.dart';
import '../../../core/ui/app_image.dart';
import '../../../core/ui/app_secondry_button.dart';
import '../../../core/ui/app_style.dart';
import '../../../core/ui/custom_divider.dart';
import 'widgets/doctor_details_header.dart';
import 'widgets/review_doctor_item.dart';
import 'widgets/review_header.dart';
import 'widgets/statchip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/ui/app_color.dart';
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

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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

                    const CustomDivider(),

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

                    const CustomDivider(),

                    const _SectionTitle('مواعيد العمل'),
                    SizedBox(height: 6.h),
                    Text(
                      'الاحد - الاربعاء (2 عصرا - 9 مساء)',
                      style: AppStyle.regular12,
                    ),

                    const CustomDivider(),

                    ReviewHeader(widget: widget),
                    SizedBox(height: 12.h),
                    ReviewDoctorItem(),
                    const CustomDivider(),

                    Text(
                      textAlign: TextAlign.center,
                      'هل قمت بزيارة هذا الدكتور ؟',
                      style: AppStyle.bold16,
                    ),
                    SizedBox(height: 12.h),
                    AppSecondryButton(
                      title: 'اكتب مراجعه',
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => WriteReviewScreen(
                            doctorName: widget.doctorName,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    AppButton(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddCardScreen(),
                        ),
                      ),
                      title: 'احجز جلسة – ${widget.sessionPrice} جنية',
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
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
