import 'dart:async';
import 'package:alquran_new/core/services/notification_service.dart';
import 'package:alquran_new/features/home/repository/prayer_time_repository.dart';
import 'package:alquran_new/features/lokasi/services/location_service.dart';
import 'package:alquran_new/features/home/models/prayer_time_model.dart';
import 'package:alquran_new/features/pengaturan/controllers/notification_settings_controller.dart';
import 'package:get/get.dart';

class PrayerTimeController extends GetxController {
  final PrayerTimeRepository repo;

  PrayerTimeController({required this.repo});

  final NotificationSettingsController settingsController =
      Get.find<NotificationSettingsController>();

  var todayPrayer = Rxn<PrayerTimeModel>();

  var nextPrayerName = "".obs;
  var nextPrayerTime = Rxn<DateTime>();

  var remaining = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;

  var isLoading = true.obs;
  var errorMessage = RxnString();

  var currentCity = "Kab. Purworejo".obs;
  bool _alreadyNotified = false;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    final location = await LocationService.getLocation();
    try {
      isLoading.value = true;

      String targetProvince;
      String targetCity;

      if (location == null) {
        targetProvince = "Jawa Tengah";
        targetCity = "Kab. Purworejo";
      } else {
        targetProvince = location.province ?? "Jawa Tengah";
        targetCity = location.city ?? "Kab. Purworejo";
      }

      currentCity.value = targetCity;

      final data = await repo.fetchPrayerTimes(
        province: targetProvince,
        city: targetCity,
      );

      final schedules = data['schedules'] as List<PrayerTimeModel>;

      if (schedules.isNotEmpty) {
        todayPrayer.value = schedules.first;

        final item = schedules.first;
        final now = DateTime.now();

        await NotificationService().cancelAllNotification();

        final prayers = {
          "Imsak": item.imsak,
          "Subuh": item.subuh,
          "Dzuhur": item.dzuhur,
          "Ashar": item.ashar,
          "Maghrib": item.maghrib,
          "Isya": item.isya,
        };

        int id = 1;

        for (final prayer in prayers.entries) {
          final prayerTime = _parseTime(prayer.value, now);

          final enabled = _isPrayerEnabled(prayer.key);

          if (enabled && prayerTime.isAfter(now)) {
            await NotificationService().scheduleNotification(
              id: id++,
              title: "Waktu ${prayer.key}",
              body: "Saatnya menunaikan sholat ${prayer.key}",
              scheduledDate: prayerTime,
              soundType: "adhan",
            );
          }
        }

        _calculateNextPrayer(schedules.first);
        _startTimer(schedules.first);
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }

  DateTime _parseTime(String time, DateTime base) {
    final parts = time.split(":");
    return DateTime(
      base.year,
      base.month,
      base.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  bool _isPrayerEnabled(String prayer) {
    switch (prayer) {
      case "Imsak":
        return settingsController.imsak.value;
      case "Subuh":
        return settingsController.subuh.value;
      case "Dzuhur":
        return settingsController.dzuhur.value;
      case "Ashar":
        return settingsController.ashar.value;
      case "Maghrib":
        return settingsController.maghrib.value;
      case "Isya":
        return settingsController.isya.value;
      default:
        return false;
    }
  }

  void _calculateNextPrayer(PrayerTimeModel item) {
    final now = DateTime.now();

    final prayers = {
      "Subuh": item.subuh,
      "Dzuhur": item.dzuhur,
      "Ashar": item.ashar,
      "Maghrib": item.maghrib,
      "Isya": item.isya,
    };

    for (final entry in prayers.entries) {
      final dt = _parseTime(entry.value, now);

      if (dt.isAfter(now)) {
        nextPrayerName.value = entry.key;
        nextPrayerTime.value = dt;
        return;
      }
    }

    final subuhTomorrow = _parseTime(
      item.subuh,
      now.add(const Duration(days: 1)),
    );

    nextPrayerName.value = "Subuh";
    nextPrayerTime.value = subuhTomorrow;
  }

  void _startTimer(PrayerTimeModel item) {
    _timer?.cancel();
  }

  double get percent {
    final total = totalDuration.value.inSeconds;
    final remain = remaining.value.inSeconds;

    if (total <= 0) return 0.0;

    return ((total - remain) / total).clamp(0.0, 1.0);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
