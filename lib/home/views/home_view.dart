import 'package:etmaen/core/logic/app_routes.dart';

import '../../core/ui/app_color.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_style.dart';
import '../models/home_model.dart';
import '../pages/chat_bot/chat_bot_page.dart';
import '../pages/doctors_page.dart';
import '../pages/home/home_page.dart';
import '../pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final list = [
    HomeModel(
      image: 'home.svg',
      page: HomePage(),
      title: 'الرئيسية',
    ),
    HomeModel(
      image: 'doctors.svg',
      page: DoctorsPage(),
      title: 'الأطباء',
    ),

    HomeModel(
      image: 'ai.svg',
      title: 'مساعدك',
    ),
    HomeModel(
      image: 'profile.svg',
      page: ProfilePage(),
      title: 'صفحتك',
    ),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: list[currentIndex].page,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.r),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            showSelectedLabels: true,
            selectedItemColor: AppColors.primiryColor,
            unselectedItemColor: AppColors.whiteColor,
            showUnselectedLabels: true,
            selectedLabelStyle: AppStyle.bold12,
            unselectedLabelStyle: AppStyle.bold12.copyWith(
              color: AppColors.whiteColor,
            ),
            currentIndex: currentIndex,

            onTap: (index) {
              if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.chatBot);
              }
              setState(() {
                currentIndex = index;
              });
            },
            items: List.generate(
              list.length,
              (index) => BottomNavigationBarItem(
                backgroundColor: AppColors.avatarColor,
                icon: AppImage(
                  image: list[index].image,
                ),
                activeIcon: AppImage(
                  image: list[index].image,
                  color: AppColors.primiryColor,
                ),
                label: list[index].title,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
