import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

final class AppColors {
static SettingsController get setting =>
      Get.find<SettingsController>();

  static Color get primary =>
      setting.currentColor.value;
  AppColors._();

  /// PRIMARY
  // static Color primary = setting.colorSelected;

  /// DARK
  static const Color dark = Color(0xFF0F202B);
  static const Color darkCard = Color(0xFF132E3A);
  static const Color darkSurface = Color(0xFF17404A);

  /// LIGHT
  static Color light = HexColor.fromHex("#F2F7F6");
  static Color lightCard = Colors.white;
  static Color textSection = HexColor.fromHex("#2D4A52");
  // static const Color lightContainer = Color(0xFFEAF4F3);
static const Color lightSurface = Color(0xFFD8EEEB);

  /// TEXT
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Color(0xFF8BA4B4);

static const Color textPrimaryLight = Color(0xFF2D4A52);
  static Color textSecondaryLight = HexColor.fromHex("#607D85");

  /// BORDER
  static const Color borderPrimary = Color(0x332DC8B9);
}