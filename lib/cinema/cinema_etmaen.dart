import 'package:carousel_slider/carousel_slider.dart';
import 'package:etmaen/cinema/widgets/cinema_header.dart';
import 'package:etmaen/cinema/widgets/cinema_header_list_view.dart';
import 'package:etmaen/cinema/widgets/cinema_slider.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaEtmaen extends StatelessWidget {
  const CinemaEtmaen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CinemaHeader(),
              SizedBox(
                height: 30.h,
              ),

              CinemaHeaderListView(),
              SizedBox(
                height: 28.h,
              ),
              Text(
                'شاهدته مؤخرا',
                style: AppStyle.bold16,
              ),
              SizedBox(
                height: 10.h,
              ),
              CinemaSlider(),
            ],
          ),
        ),
      ),
    );
  }
}

