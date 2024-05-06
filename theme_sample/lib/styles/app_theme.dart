import 'package:flutter/material.dart';
import 'package:theme_sample/styles/app_colors.dart';
import 'package:theme_sample/styles/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: AppTextTheme.textTheme,
    appBarTheme: const AppBarTheme(
      color: AppColors.blue,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
  );
}
