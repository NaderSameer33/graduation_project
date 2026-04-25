import '../../../core/ui/app_color.dart';
import '../../../core/ui/app_style.dart';
import 'widgets/cinema_etmean_list_view.dart';
import 'widgets/home_feel_item.dart';
import 'widgets/home_header.dart';
import 'widgets/therapeutic_content_header.dart';
import 'widgets/therapeutic_content_list_view.dart';
import 'widgets/therapeutic_traning_grid_view.dart';
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
              SliverToBoxAdapter(
                child: TherapeuticContentHeader(
                  onTap: () {},
                  title: 'محتوي علاجي مخصص لك',
                ),
              ),
              TherapeuticContentListView(),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: TherapeuticContentHeader(
                  onTap: () {},

                  title: 'تمارين بناء المهارات النفسية',
                ),
              ),

              SliverToBoxAdapter(
                child: TherapeuticTraningGridView(),
              ),
              SliverToBoxAdapter(
                child: TherapeuticContentHeader(
                  onTap: () {},

                  title: 'ٍسينما اطمئن',
                ),
              ),
              SliverToBoxAdapter(
                child: CinemaEtmeanListView(),
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
