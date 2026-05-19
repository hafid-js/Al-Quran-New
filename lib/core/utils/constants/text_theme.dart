import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(

    /// HEADLINE
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryLight,
    ),

    /// TITLE
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),

    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),

    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),

    /// BODY
    bodyLarge: TextStyle(
      fontSize: 16,
      color: AppColors.textPrimaryLight,
    ),

    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.textSecondaryLight,
    ),

     labelSmall: TextStyle(
      fontSize: 12,
         fontWeight: FontWeight.w300,
      color: AppColors.textSecondaryLight,
    ),

    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: AppColors.textSecondaryLight,
    ),

    /// LABEL
    labelLarge: TextStyle(
      fontSize: 16,
      // fontWeight: FontWeight.bold,
      color: AppColors.textSecondaryLight,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(

    /// HEADLINE
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryDark,
    ),

    /// TITLE
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),

    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),

    /// BODY
    bodyLarge: TextStyle(
      fontSize: 16,
      color: AppColors.textPrimaryDark,
    ),

    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.textSecondaryDark,
    ),

    /// LABEL
     labelSmall:  TextStyle(
      fontSize: 12,
      color: AppColors.textSecondaryDark,
    ),


     labelMedium: TextStyle(
      fontSize: 14,
            fontWeight: FontWeight.w300,
      color: AppColors.textSecondaryDark,
    ),

    /// LABEL
    labelLarge: TextStyle(
      fontSize: 16,
      // fontWeight: FontWeight.bold,
      color: AppColors.textSecondaryDark,
    ),
  );
}