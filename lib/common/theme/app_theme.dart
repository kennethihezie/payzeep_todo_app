import 'package:flutter/material.dart';
import 'package:todo_app/common/theme/color/app_colors.dart';

abstract class AppTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryGreen),
    );
  }
}