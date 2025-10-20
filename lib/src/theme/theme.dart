import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';

// class AppColors {
//   static Color primaryColor = const Color.fromARGB(255, 96, 150, 186);
//   static Color primaryAccent = const Color.fromARGB(255, 39, 76, 119);
//   static Color textColor = const Color.fromARGB(255, 163, 206, 241);
//   static Color titleColor = const Color.fromARGB(255, 231, 236, 239);
//   static Color secondaryColor = const Color.fromARGB(255, 139, 140, 137);
// }

class AppColors {
  static Color primaryColor = const Color.fromARGB(255, 73, 80, 87);
  static Color primaryAccent = const Color.fromARGB(255, 33, 37, 41);
  static Color textColor = const Color.fromARGB(255, 173, 181, 189);
  static Color titleColor = const Color.fromARGB(255, 248, 249, 250);
  static Color secondaryColor = const Color.fromARGB(255, 139, 140, 137);
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  scaffoldBackgroundColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryAccent,
    foregroundColor: AppColors.textColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: Sizes.p16,
      letterSpacing: Sizes.p4,
    ),
    headlineMedium: TextStyle(
      color: AppColors.titleColor,
      fontSize: Sizes.p16,
      fontWeight: FontWeight.bold,
      letterSpacing: Sizes.p4,
    ),
    titleMedium: TextStyle(
      color: AppColors.titleColor,
      fontSize: Sizes.p20,
      fontWeight: FontWeight.bold,
      letterSpacing: Sizes.p8,
    ),
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: WidgetStatePropertyAll(AppColors.primaryColor),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  scaffoldBackgroundColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryAccent,
    foregroundColor: AppColors.textColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: Sizes.p16,
      letterSpacing: Sizes.p4,
    ),
    headlineMedium: TextStyle(
      color: AppColors.titleColor,
      fontSize: Sizes.p16,
      fontWeight: FontWeight.bold,
      letterSpacing: Sizes.p4,
    ),
    titleMedium: TextStyle(
      color: AppColors.titleColor,
      fontSize: Sizes.p20,
      fontWeight: FontWeight.bold,
      letterSpacing: Sizes.p8,
    ),
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: WidgetStatePropertyAll(AppColors.primaryColor),
  ),
);
