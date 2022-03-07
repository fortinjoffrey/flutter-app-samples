import 'package:flutter/material.dart';
import 'package:flutter_app_samples/common/presentation/theme/app_colors.dart';

final lightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      shadowColor: Colors.transparent,
      color: AppColors.grey1,
      toolbarHeight: 80,
    ),
    scaffoldBackgroundColor: AppColors.grey2,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.grey3),
      ),
    ),
  );
}
