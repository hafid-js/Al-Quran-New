import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppBarThemes {
  AppBarThemes._();

  static final lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.textPrimaryLight,
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.textPrimaryDark,
  );
}