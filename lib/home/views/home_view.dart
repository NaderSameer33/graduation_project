import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/models/home_model.dart';
import 'package:etmaen/home/pages/chat_with_ai_page.dart';
import 'package:etmaen/home/pages/doctors_page.dart';
import 'package:etmaen/home/pages/home/home_page.dart';
import 'package:etmaen/home/pages/profile_page.dart';
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
      page: ChatWithAiPage(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
