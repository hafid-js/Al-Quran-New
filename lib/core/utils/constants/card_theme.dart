import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppCardTheme {
  AppCardTheme._();

  static CardThemeData lightCardTheme = CardThemeData(
    color: AppColors.lightCard,
    elevation: 6,
     surfaceTintColor: Colors.transparent, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    
  );

  static CardThemeData darkCardTheme = CardThemeData(
    color: AppColors.darkCard,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
}