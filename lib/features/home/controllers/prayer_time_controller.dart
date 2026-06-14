import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/core/services/notification_service.dart';
import 'package:alquran_new/features/home/data/datasources/prayer_time_local_datasource.dart';
import 'package:alquran_new/features/home/data/local/prayer_time_cache.dart';
import 'package:alquran_new/features/home/repository/prayer_time_repository.dart';
import 'package:alquran_new/features/lokasi/services/location_service.dart';
import 'package:alquran_new/features/home/models/prayer_time_model.dart';
import 'package:alquran_new/features/lokasi/data/location_cache.dart';
import 'package:alquran_new/features/pengaturan/controllers/notification_settings_controller.dart';

class PrayerTimeController extends GetxController {
  final PrayerTimeRepository repo;
  final PrayerTimeLocalDatasource local = PrayerTimeLocalDatasource();

  PrayerTimeController({required this.repo});

  final NotificationSettingsController settingsController =
      Get.find<NotificationSettingsController>();

  var todayPrayer = Rxn<PrayerTimeModel>();
  var nextPrayerName = "".obs;
  var nextPrayerTime = Rxn<DateTime>();

  var remaining = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;

  var isLoading = false.obs;
  var errorMessage = RxnString();
  var currentCity = "Kab. Purworejo".obs;
  bool _isRefreshing = false;
  bool _disposed = false;

  Timer? _prayerTimer;
  Timer? _countdownTimer;
  LocationCache? _cachedLocation;
  var locationStatus = "Idle".obs;

  @override
  void onInit() {
    super.onInit();
    _startCountdown();

  // Future.delayed(Duration(seconds: 2), () async {
  //   await NotificationService().testAdhanSound();
  // });
  //    Future.delayed(Duration.zero, () async {
  //   await _debugTestNotification();
  // });
    Future.delayed(Duration.zero, () {
      if (!_disposed) fetchPrayerTimes();
    });
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_disposed) return;
      final next = nextPrayerTime.value;
      remaining.value = next != null
          ? next.difference(DateTime.now())
          : Duration.zero;
    });
  }

Future<void> _debugTestNotification() async {
  final now = DateTime.now();
  final testTime = now.add(const Duration(seconds: 10));


  await NotificationService().scheduleNotification(
    id: 999,
    title: "DEBUG ADZAN TEST",
    body: "Ini test notifikasi 10 detik",
    scheduledDate: testTime,
    soundType: settingsController.soundType.value,
    notificationMode: settingsController.notificationMode.value,
  );
}


// Future<void> scheduleNotification({
//   required int id,
//   required String title,
//   required String body,
//   required DateTime scheduledDate,
// }) async {
//   const iosDetails = DarwinNotificationDetails(
//     sound: 'adzansubuh.wav', // 🔥 WAJIB SAMA PERSIS
//     presentAlert: true,
//     presentSound: true,
//     presentBadge: true,
//   );

//   const androidDetails = AndroidNotificationDetails(
//     'prayer_channel',
//     'Prayer Notifications',
//     importance: Importance.max,
//     priority: Priority.high,
//     playSound: true,
//   );

//   const details = NotificationDetails(
//     iOS: iosDetails,
//     android: androidDetails,
//   );

//   await FlutterLocalNotificationsPlugin.zonedSchedule(
//     id,
//     title,
//     body,
//     tz.TZDateTime.from(scheduledDate, tz.local),
//     details,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     matchDateTimeComponents: null,
//   );
// }
  void _schedulePrayerTimer() {
    _prayerTimer?.cancel();
    final next = nextPrayerTime.value;
    if (next == null) return;

    final diff = next.difference(DateTime.now());
    if (diff.isNegative) return;

    _prayerTimer = Timer(diff, () {
      if (!_disposed) fetchPrayerTimes();
    });
  }

Future<void> detectLocation() async {
  try {
    isLoading.value = true;

    locationStatus.value = "Mendeteksi lokasi...";

    final location = await LocationService.detectAndSaveLocation();

    locationStatus.value = "Mengambil data kota...";

    _cachedLocation = location;
    currentCity.value = location.city;

    locationStatus.value = "Memperbarui jadwal...";

        await local.clear();


    await fetchPrayerTimes();

    locationStatus.value = "Selesai";

    Get.snackbar(
      "Sukses",
      "Lokasi diperbarui: ${location.city}",
    );
  } catch (e) {
    locationStatus.value = "Gagal";

    Get.snackbar("Error", e.toString());
  } finally {
    isLoading.value = false;

    // optional reset setelah delay
    Future.delayed(const Duration(seconds: 2), () {
      locationStatus.value = "Idle";
    });
  }
}



  Future<void> fetchPrayerTimes() async {
    if (_isRefreshing) return;
    if (_disposed) return;

    try {
      _isRefreshing = true;
      isLoading.value = true;

  final controller = Get.find<PrayerTimeController>();

controller._cachedLocation =
    await LocationService.getLocation();

await controller.fetchPrayerTimes();

      final String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

     final cached = local.get();

final sameLocation =
    cached != null &&
    cached.province == _cachedLocation?.province &&
    cached.city == _cachedLocation?.city;

if (cached != null &&
    cached.tanggalLengkap == todayStr &&
    sameLocation) {

  todayPrayer.value = cached.toEntity();

  final loc = _cachedLocation;
  if (loc != null) {
    currentCity.value = loc.city;
  }

  _calculateNextPrayer(cached.toEntity());

  isLoading.value = false;
  _isRefreshing = false;
  return;
}

      final net = Get.find<NetworkController>();
      if (!net.isConnected.value) {
        Get.snackbar(
          "Tidak Ada Koneksi",
          "Periksa koneksi internet untuk memuat jadwal sholat.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final data = await repo.fetchPrayerTimes(
        province: _cachedLocation?.province ?? "Jawa Tengah",
        city: _cachedLocation?.city ?? "Kab. Purworejo",
      );

      final schedules = data['schedules'] as List<PrayerTimeModel>;
      if (schedules.isEmpty) return;

      final item = schedules.first;
      todayPrayer.value = item;

      final loc = _cachedLocation;
      if (loc != null) {
        currentCity.value = loc.city;
      }

      final cacheData = PrayerTimeCache.fromEntity(item,
          province: loc?.province, city: loc?.city);
      await local.save(cacheData);

      final now = DateTime.now();

      final prayers = {
        "Subuh": item.subuh,
        "Dzuhur": item.dzuhur,
        "Ashar": item.ashar,
        "Maghrib": item.maghrib,
        "Isya": item.isya,
      };

      final prayerIds = {
        "Subuh": 1,
        "Dzuhur": 2,
        "Ashar": 3,
        "Maghrib": 4,
        "Isya": 5,
      };

      for (final entry in prayers.entries) {
        DateTime prayerTime = _parseTime(entry.value, now);
        if (prayerTime.isBefore(now)) {
          prayerTime = prayerTime.add(const Duration(days: 1));
        }
        if (_isPrayerEnabled(entry.key)) {
          await NotificationService().scheduleNotification(
            id: prayerIds[entry.key]!,
            title: "Al-Barokah: Quran & Sholat",
            body: "Saatnya sholat ${entry.key}",
            scheduledDate: prayerTime,
            soundType: settingsController.soundType.value,
            notificationMode: settingsController.notificationMode.value,
          );
        }
      }

      for (final entry in prayers.entries) {
  DateTime prayerTime = DateTime.now().add(const Duration(seconds: 10));

  if (_isPrayerEnabled(entry.key)) {
    await NotificationService().scheduleNotification(
      id: prayerIds[entry.key]!,
      title: "Al-Barokah: Quran & Sholat",
      body: "Saatnya sholat ${entry.key}",
      scheduledDate: prayerTime,
      soundType: settingsController.soundType.value,
      notificationMode: settingsController.notificationMode.value,
    );
  }
}

      _calculateNextPrayer(item);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      _isRefreshing = false;
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
        _schedulePrayerTimer();
        return;
      }
    }

    final tomorrow = now.add(const Duration(days: 1));
    nextPrayerName.value = "Subuh";
    nextPrayerTime.value = _parseTime(item.subuh, tomorrow);
    _schedulePrayerTimer();
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

  void pauseCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  void resumeCountdown() {
    if (_disposed) return;
    _startCountdown();
  }

  String get remainingText {
    final diff = remaining.value;
    if (diff.isNegative) return "--";
    return "${diff.inHours.toString().padLeft(2, '0')}:"
        "${(diff.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(diff.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  Future<void> rescheduleNotifications() async {
    final item = todayPrayer.value;
    if (item == null) return;

    await NotificationService().cancelAllNotification();

    final now = DateTime.now();
    final prayers = {
      "Subuh": item.subuh,
      "Dzuhur": item.dzuhur,
      "Ashar": item.ashar,
      "Maghrib": item.maghrib,
      "Isya": item.isya,
    };

    final prayerIds = {
      "Subuh": 1,
      "Dzuhur": 2,
      "Ashar": 3,
      "Maghrib": 4,
      "Isya": 5,
    };

    for (final entry in prayers.entries) {
      DateTime prayerTime = _parseTime(entry.value, now);
      if (prayerTime.isBefore(now)) {
        prayerTime = prayerTime.add(const Duration(days: 1));
      }
      if (_isPrayerEnabled(entry.key)) {
        await NotificationService().scheduleNotification(
          id: prayerIds[entry.key]!,
          title: "Al-Barokah: Quran & Sholat",
          body: "Saatnya sholat ${entry.key}",
          scheduledDate: prayerTime,
          soundType: settingsController.soundType.value,
          notificationMode: settingsController.notificationMode.value,
        );
      }
    }
  }

  @override
  void onClose() {
    _prayerTimer?.cancel();
    _countdownTimer?.cancel();
    _isRefreshing = false;
    _disposed = true;
    super.onClose();
  }
}
