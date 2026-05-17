import 'dart:ui';

import 'package:alquran_new/features/pengaturan/models/app_settings.dart';
import 'package:alquran_new/features/pengaturan/services/settings_service.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final SettingsService service;

  SettingsController(this.service);

  AppSettings settings = AppSettings();

  var qariSelected = 4.obs;
  var fontSelected = 0.obs;
  var modeSelected = 0.obs;
  var colorSelected = 0.obs;

  var currentColor = const Color(0xFF2EC4B6).obs;


  @override
  void onInit() {
    loadSettings();
    super.onInit();
  }


  Future<void> loadSettings() async {
    settings = await service.getSettings();

    qariSelected.value = settings.qariSelected;
    fontSelected.value = settings.fontSelected;
    modeSelected.value = settings.modeSelected;
    colorSelected.value = settings.colorSelected;

    currentColor.value = Color(settings.customColor);
  }

  Future<void> changeQari(int index) async {
    qariSelected.value = index;

    settings.qariSelected = index;

    await service.save(settings);
  }

  Future<void> changeFont(int index) async {
    fontSelected.value = index;

    settings.fontSelected = index;

    await service.save(settings);
  }

  Future<void> changeMode(int index) async {
    modeSelected.value = index;

    settings.modeSelected = index;

    await service.save(settings);
  }

  Future<void> changeColor(int index, Color color) async {
  colorSelected.value = index;
  currentColor.value = color;

  settings.colorSelected = index;
  settings.customColor = color.value;

  await service.save(settings);
}
}