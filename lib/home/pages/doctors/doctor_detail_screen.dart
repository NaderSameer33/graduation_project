import '../../../core/ui/app_button.dart';
import '../../../core/ui/app_image.dart';
import '../../../core/ui/app_secondry_button.dart';
import '../../../core/ui/app_style.dart';
import '../../../core/ui/custom_divider.dart';
import 'models/doctor_model.dart';
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
    required this.doctor,
  });

  final DoctorModel doctor;

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final doc = widget.doctor;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DoctorDetailsHeader(
                imageUrl: doc.imageUrl ?? doc.image,
                isFavorite: doc.isFavorite,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      doc.name,
                      style: AppStyle.bold16,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      doc.specialty,
                      style: AppStyle.regular12,
                    ),
                    SizedBox(height: 12.h),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        StatChip(
                          icon: Icons.access_time_rounded,
                          label: '${doc.sessionDuration} دقيقة',
                        ),
                        StatChip(
                          icon: Icons.star_rounded,
                          label: '${doc.rating} نجوم',
                          iconColor: const Color(0xFFFFAA00),
                        ),
                        StatChip(
                          icon: Icons.work_rounded,
                          label: '${doc.experience} سنوات خبرة',
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      doc.description,
                      textAlign: TextAlign.right,
                      style: AppStyle.regular12.copyWith(
                        color: AppColors.whiteColor.withAlpha(200),
                        height: 1.5,
                      ),
                    ),
                    const CustomDivider(),
                    const _SectionTitle('الموقع'),
                    SizedBox(height: 6.h),
                    Text(
                      doc.location,
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
                      doc.workingHours,
                      style: AppStyle.regular12,
                    ),
                    const CustomDivider(),
                    ReviewHeader(reviewCount: doc.reviewCount),
                    SizedBox(height: 12.h),
                    const ReviewDoctorItem(),
                    const CustomDivider(),
                    Text(
                      'هل قمت بزيارة هذا الدكتور ؟',
                      textAlign: TextAlign.center,
                      style: AppStyle.bold16,
                    ),
                    SizedBox(height: 12.h),
                    AppSecondryButton(
                      title: 'اكتب مراجعه',
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => WriteReviewScreen(
                            doctorName: doc.name,
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
                      title: 'احجز جلسة – ${doc.fees}',
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
