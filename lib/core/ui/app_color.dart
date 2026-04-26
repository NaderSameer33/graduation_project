import 'package:flutter/material.dart';

abstract class AppColors {
  static const primiryColor = Color(0xffB680D7);
  static const secondryColor = Color(0xff483354);
  static const whiteShadeColro = Color(0xffF3DFF3);
  static const whiteColor = Colors.white;
  static const greyColor = Color(0xffB3B3B3);
  static const inputColor = Color(0xff1E1E1E);
  static const inputHintColor = Color(0xff666666);
  static const avatarColor = Color(0xff333232);
  static const errorColro = Color(0xffEF9A9A);
  static const blackColor = Colors.black;
  static const profileColor = Color(0xffFFB74D) ; 

  // Etmaen specific colors
  static const Color background   = Color(0xFF121212);
  static const Color card         = Color(0xFF1E1E1E);
  static const Color cardGradientTop  = Color(0xFF333232);
  static const Color cardGradientBot  = Color(0xFF1E1E1E);
  static const Color primaryTop   = Color(0xFFB680D7);
  static const Color primaryBot   = Color(0xFF483354);
  static const Color textWhite    = Colors.white;
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textDisabled  = Color(0xFF666666);
  static const Color textPrimary   = Color(0xFFBD8DDB);
  static const Color textAccent    = Color(0xFFC393BD);
  static const Color stroke       = Color(0xFFB3B3B3);
  static const Color overlayGrey  = Color(0x7F666666);
}

class AppGradients {
  AppGradients._();

  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topCenter,
    end:   Alignment.bottomCenter,
    colors: [AppColors.primaryTop, AppColors.primaryBot],
  );

  static const LinearGradient backButton = LinearGradient(
    begin: Alignment.topCenter,
    end:   Alignment.bottomCenter,
    colors: [AppColors.cardGradientTop, AppColors.cardGradientBot],
  );

  static const LinearGradient progress = LinearGradient(
    begin: Alignment.topCenter,
    end:   Alignment.bottomCenter,
    colors: [AppColors.primaryTop, AppColors.primaryBot],
  );
}
