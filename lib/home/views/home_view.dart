import 'package:etmaen/core/logic/app_routes.dart';

import '../../core/ui/app_color.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_style.dart';
import '../models/home_model.dart';
import '../pages/chat_bot/chat_bot_page.dart';

import '../pages/doctors/doctors_screen.dart';
import '../pages/doctors_page.dart';
import '../pages/home/home_page.dart';
import '../pages/profile/profile_page.dart';
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
      image: '',
      title: '',
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

  void _showCenterMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.inputColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.r),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.school_outlined, color: AppColors.whiteColor),
                  title: Text('محتوى علاجي', style: AppStyle.bold16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.play_circle_outline, color: AppColors.whiteColor),
                  title: Text('سينما اطمئن', style: AppStyle.bold16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.nightlight_round, color: AppColors.whiteColor),
                  title: Text('تمارين نفسية', style: AppStyle.bold16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.info_outline, color: AppColors.whiteColor),
                  title: Text('اختبارات نفسية', style: AppStyle.bold16),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.tests);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.hourglass_empty, color: AppColors.whiteColor),
                  title: Text('تحديات نفسية', style: AppStyle.bold16),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.challenges);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.menu_book, color: AppColors.whiteColor),
                  title: Text('ركن القراءة', style: AppStyle.bold16),
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: list[currentIndex].page ?? const SizedBox(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.r),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
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
                _showCenterMenu(context);
                return;
              }
              if (index == 3) {
                Navigator.pushNamed(context, AppRoutes.chatBot);
                return;
              }
              setState(() {
                currentIndex = index;
              });
            },
            items: List.generate(
              list.length,
              (index) {
                if (index == 2) {
                  return BottomNavigationBarItem(
                    icon: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: AppColors.primiryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.auto_awesome, color: Colors.white, size: 24.r),
                    ),
                    label: '',
                  );
                }
                return BottomNavigationBarItem(
                  backgroundColor: AppColors.avatarColor,
                  icon: AppImage(
                    image: list[index].image,
                  ),
                  activeIcon: AppImage(
                    image: list[index].image,
                    color: AppColors.primiryColor,
                  ),
                  label: list[index].title,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
