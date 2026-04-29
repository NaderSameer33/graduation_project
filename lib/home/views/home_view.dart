import '../../core/logic/app_routes.dart';
import '../pages/home/widgets/home_bottom_sheet.dart';
import '../../core/ui/app_color.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_style.dart';
import '../models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  void _showCenterMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.inputColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return HomeBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: list[currentIndex].page ?? const SizedBox(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      extendBody: true,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.r),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.avatarColor,
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
                      child: Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 24.r,
                      ),
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
