import 'package:flutter/material.dart';
import 'package:worktracker/core/utils/constants/colors.dart';
import 'package:worktracker/core/utils/theme/button_theme.dart';
import 'package:worktracker/core/utils/theme/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'TT Interphases',
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primaryBackground,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppButtonTheme.lightOutlinedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'TT Interphases',
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.dark,
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: AppButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppButtonTheme.darkOutlinedButtonTheme,
  );
}
