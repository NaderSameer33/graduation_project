import 'package:etmaen/home/pages/doctors/doctors_screen.dart';
import 'package:etmaen/home/pages/home/home_page.dart';
import 'package:etmaen/home/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class HomeModel {
  final String image, title;
  final Widget? page;

  const HomeModel({required this.image,  this.page, required this.title});
}

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