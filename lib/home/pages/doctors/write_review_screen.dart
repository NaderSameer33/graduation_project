import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_button.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_input.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/core/ui/success_dialog.dart';
import 'package:etmaen/home/pages/doctors/widgets/doctor_review_star.dart';
import 'package:etmaen/home/pages/doctors/widgets/review_success_dialong.dart';
import 'package:flutter/material.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key, this.doctorName = 'دكتور محمد الامام'});
  final String doctorName;

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final _nameCtrl = TextEditingController();
  final _reviewCtrl = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _reviewCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_reviewCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'من فضلك اكتب مراجعتك',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    _isSubmitting = true;
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    _isSubmitting = false;

    showDialog(
      context: context,
      builder: (_) => ReviewSuccessDialog(
        onDone: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBack(),

              SizedBox(height: 24.h),

              Text(
                'اكتب مراجعة بناءً على زيارتك\nللدكتور ${widget.doctorName}',
                textAlign: TextAlign.center,
                style: AppStyle.regular20.copyWith(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 24.h),

              Text(
                'ما تقييمك للدكتور',
                textAlign: TextAlign.right,
                style: AppStyle.regular20,
              ),
              SizedBox(height: 8.h),
              DoctorReviewStar(),
              SizedBox(height: 24.h),

              Text(
                'الاسم',
                style: AppStyle.regular16,
              ),
              SizedBox(height: 6.h),
              AppInput(
                hintText: 'د نادر سمير',
                controller: _nameCtrl,
              ),
              SizedBox(height: 16.h),

              Text(
                'مراجعتك',
                style: AppStyle.regular16,
              ),
              AppInput(
                hintText: 'اكتب رايك في الجلسه',
                maxLines: 6,
                controller: _reviewCtrl,
              ),

              SizedBox(height: 32.h),

              AppButton(onTap: _submit, title: 'ارسال المراجعه'),
            ],
          ),
        ),
      ),
    );
  }
}

