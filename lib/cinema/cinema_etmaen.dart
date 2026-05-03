import 'package:etmaen/cinema/widgets/cinema_header.dart';
import 'package:etmaen/cinema/widgets/cinema_header_list_view.dart';
import 'package:etmaen/cinema/widgets/cinema_most_view.dart';
import 'package:etmaen/cinema/widgets/cinema_short_film.dart';
import 'package:etmaen/cinema/widgets/cinema_slider.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaEtmaen extends StatefulWidget {
  const CinemaEtmaen({super.key});

  @override
  State<CinemaEtmaen> createState() => _CinemaEtmaenState();
}

class _CinemaEtmaenState extends State<CinemaEtmaen> {
  String selectedFilter = 'عرض الكل';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CinemaHeader(),
              SizedBox(
                height: 30.h,
              ),

              CinemaHeaderListView(
                onFilterChanged: (filter) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
              ),
              SizedBox(
                height: 28.h,
              ),
              Text(
                'شاهدته مؤخرا',
                style: AppStyle.bold16,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: 10.h,
              ),
              // We could pass selectedFilter to CinemaSlider if needed, but 'recently watched' 
              // is usually independent of filters.
              const CinemaSlider(),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'الاكثر مشاهدة',
                style: AppStyle.bold16,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: 10.h,
              ),
              // Filter logic can be applied inside CinemaMostView
              CinemaMostView(filter: selectedFilter),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'افلام قصيرة',
                style: AppStyle.bold16,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: 10.h,
              ),
              CinemaShortFilm(filter: selectedFilter),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
