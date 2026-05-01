import 'package:etmaen/cinema/widgets/cinema_header.dart';
import 'package:etmaen/cinema/widgets/cinema_header_list_view.dart';
import 'package:etmaen/core/ui/app_color.dart';
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
            children: [
              CinemaHeader(),
              SizedBox(
                height: 30.h,
              ),

              CinemaHeaderListView(),
            ],
          ),
        ),
      ),
    );
  }
}
