import 'package:get/get.dart';
import 'package:alquran_new/features/home/controllers/prayer_time_controller.dart';
import '../models/notification_settings.dart';
import '../services/notification_settings_service.dart';

class NotificationSettingsController extends GetxController {
  final NotificationSettingsService service;

  NotificationSettingsController(this.service);

  NotificationSettings settings = NotificationSettings();

  var notificationMode = 0.obs;
  var soundType = 'adzan'.obs;

  var imsak = true.obs;
  var subuh = true.obs;
  var dzuhur = true.obs;
  var ashar = true.obs;
  var maghrib = true.obs;
  var isya = true.obs;

  @override
  void onInit() {
    loadSettings();
    super.onInit();
  }

  Future<void> loadSettings() async {
    settings = await service.getSettings();

    notificationMode.value = settings.notificationMode;
    soundType.value = settings.soundType;

    imsak.value = settings.imsakEnabled;
    subuh.value = settings.subuhEnabled;
    dzuhur.value = settings.dzuhurEnabled;
    ashar.value = settings.asharEnabled;
    maghrib.value = settings.maghribEnabled;
    isya.value = settings.isyaEnabled;
  }

  Future<void> changeMode(int index) async {
    notificationMode.value = index;
    settings.notificationMode = index;
    await service.save(settings);
    await Get.find<PrayerTimeController>().rescheduleNotifications();
  }

  Future<void> changeSound(String type) async {
    soundType.value = type;
    settings.soundType = type;
    await service.save(settings);
    await Get.find<PrayerTimeController>().rescheduleNotifications();
  }

  Future<void> togglePrayer(String type) async {
    switch (type) {
      case 'imsak':
        imsak.toggle();
        settings.imsakEnabled = imsak.value;
        break;

      case 'subuh':
        subuh.toggle();
        settings.subuhEnabled = subuh.value;
        break;

      case 'dzuhur':
        dzuhur.toggle();
        settings.dzuhurEnabled = dzuhur.value;
        break;

      case 'ashar':
        ashar.toggle();
        settings.asharEnabled = ashar.value;
        break;

      case 'maghrib':
        maghrib.toggle();
        settings.maghribEnabled = maghrib.value;
        break;

      case 'isya':
        isya.toggle();
        settings.isyaEnabled = isya.value;
        break;
    }

    await service.save(settings);
    await Get.find<PrayerTimeController>().rescheduleNotifications();
  }
}