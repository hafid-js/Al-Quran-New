import 'package:alquran_new/core/utils/constants/shadow_theme.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_bar_theme.dart';
import 'card_theme.dart';
import 'text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  primaryColor: AppColors.primary,

  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    surface: AppColors.lightSurface,
  ),

  iconTheme: IconThemeData(
    color: AppColors.textPrimaryLight,
  ),


  textTheme: AppTextTheme.lightTextTheme,

  scaffoldBackgroundColor: AppColors.light,
  cardColor: AppColors.lightCard,
   extensions: [
    AppShadow(
      small: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        )
      ],
      medium: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 16,
          offset: Offset(0, 6),
        )
      ],
      large: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 24,
          offset: Offset(0, 10),
        )
      ],
    ),
  ],
);

 static ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
    primaryColor: AppColors.primary,

  textTheme: AppTextTheme.darkTextTheme,

  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    surface: AppColors.darkSurface,
  ),


  iconTheme: IconThemeData(
    color: AppColors.textPrimaryDark,
  ),

  scaffoldBackgroundColor: AppColors.dark,
  cardColor: AppColors.darkCard,
  extensions: [
    AppShadow(
      small: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        )
      ],
      medium: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 16,
          offset: Offset(0, 6),
        )
      ],
      large: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 24,
          offset: Offset(0, 10),
        )
      ],
    ),
  ],
);
}