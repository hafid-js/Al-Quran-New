import 'package:flutter/material.dart';
import 'package:alquran_new/core/constants/shadow_theme.dart';

extension ShadowX on BuildContext {
  AppShadow get shadow => Theme.of(this).extension<AppShadow>()!;
}