import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/constants/shadow_theme.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';
import 'text_theme.dart';

class AppTheme {
  AppTheme._();
    static SettingsController setting = Get.find<SettingsController>();

  static ThemeData lightTheme() {
    return ThemeData(
  useMaterial3: true,
  fontFamily: setting.fontSelected.value.toString(),
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  disabledColor: AppColors.lightDisableColor,

  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
        secondary: AppColors.secondary,
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
);}

 static ThemeData darkTheme() {
    return ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    disabledColor: AppColors.darkDisableColor,

  textTheme: AppTextTheme.darkTextTheme,

  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.darkSurface,
  ),


  iconTheme: IconThemeData(
    color: AppColors.textPrimaryDark,
  ),

  scaffoldBackgroundColor: HexColor.fromHex("#132D3B").withAlpha(120),
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
 }}