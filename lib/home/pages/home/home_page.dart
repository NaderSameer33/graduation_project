import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/home/widgets/home_feel_item.dart';
import 'package:etmaen/home/pages/home/widgets/home_header.dart';
import 'package:etmaen/home/pages/home/widgets/therapeutic_content_header.dart';
import 'package:etmaen/home/pages/home/widgets/therapeutic_content_list_view.dart';
import 'package:etmaen/home/pages/home/widgets/therapeutic_traning_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20.h,
                ),
              ),
              SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 24.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  'أنت لست ضحية للمشاعر\n بل صانع الأفعال التي تغير المشهد',
                  style: AppStyle.regular16.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 24.h,
                ),
              ),
              SliverToBoxAdapter(
                child: HomeFeelItem(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20.h,
                ),
              ),
              TherapeuticContentHeader(
                title: 'محتوي علاجي مخصص لك',
              ),
              TherapeuticContentListView(),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              TherapeuticContentHeader(
                title: 'تمارين بناء المهارات النفسية',
              ),

              SliverToBoxAdapter(
                child: TherapeuticTraningGridView(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
