import 'dart:async';

import 'package:alquran_new/features/adzan/screens/adzan_screen.dart';
import 'package:alquran_new/features/home/domain/entities/prayer_time.dart';
import 'package:alquran_new/features/home/domain/repositories/prayer_time_repository.dart';
import 'package:alquran_new/features/home/domain/usecases/get_prayer_times.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/core/services/notification_service.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/home/data/datasources/prayer_time_local_datasource.dart';
import 'package:alquran_new/features/home/data/local/prayer_time_cache.dart';
import 'package:alquran_new/features/lokasi/services/location_service.dart';
import 'package:alquran_new/features/lokasi/data/location_cache.dart';
import 'package:alquran_new/features/pengaturan/controllers/notification_settings_controller.dart';

class PrayerTimeController extends GetxController {
  final GetPrayerTimes _getPrayerTimes = Get.find();
  final PrayerTimeLocalDatasource local = PrayerTimeLocalDatasource();

  final NotificationSettingsController settingsController =
      Get.find<NotificationSettingsController>();

  var todayPrayer = Rxn<PrayerTime>();
  var nextPrayerName = "".obs;
  var nextPrayerTime = Rxn<DateTime>();

  var remaining = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;

  var isLoading = false.obs;
  var errorMessage = RxnString();
  var currentCity = "Kota Jakarta".obs;
  bool _isRefreshing = false;
  bool _disposed = false;

  Timer? _prayerTimer;
  Timer? _adzanTimer;
  Timer? _countdownTimer;
  LocationCache? _cachedLocation;
  var locationStatus = "Sedang memuat data...".obs;

  @override
  void onInit() {
    super.onInit();
    _startCountdown();
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

  DateTime? _lastAdzanTriggered;

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

  void _scheduleAdzanTimer() {
    final next = nextPrayerTime.value;
    if (next == null) return;

    final diff = next.difference(DateTime.now());
    if (diff.isNegative) return;

    _adzanTimer = Timer(diff + const Duration(seconds: 4), () {
      if (!_disposed) _triggerAdzan();
    });
  }

  void _triggerAdzan() {
    if (_lastAdzanTriggered != null &&
        DateTime.now().difference(_lastAdzanTriggered!) <
            const Duration(minutes: 1)) {
      return;
    }
    _lastAdzanTriggered = DateTime.now();
    Get.to(() => const AdzanScreen());
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

      Get.snackbar("Sukses", "Lokasi diperbarui: ${location.city}");
    } catch (e) {
      locationStatus.value = "Gagal";
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;

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

      _cachedLocation = await LocationService.getLocation();

      final String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final cached = local.get();

      final sameLocation =
          cached != null &&
          cached.province == _cachedLocation?.province &&
          cached.city == _cachedLocation?.city;

      if (cached != null && cached.tanggalLengkap == todayStr && sameLocation) {
        todayPrayer.value = cached.toEntity();

        final loc = _cachedLocation;
        if (loc != null) {
          currentCity.value = loc.city;
        }

        _calculateNextPrayer(cached.toEntity());

        await _schedulePrayerNotifications(cached.toEntity());

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

      final result = await _getPrayerTimes.call(
        province: _cachedLocation?.province ?? "DKI Jakarta",
        city: _cachedLocation?.city ?? "Kota Jakarta",
      );

      if (result is Failure) {
        errorMessage.value = (result as Failure).message;
        return;
      }

      final success = result as Success<PrayerTimeResponse>;
      final schedules = success.data.schedules;
      if (schedules.isEmpty) return;

      final todayDateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final item = schedules.firstWhere(
        (s) => s.tanggalLengkap == todayDateStr,
        orElse: () => schedules.first,
      );
      todayPrayer.value = item;

      final loc = _cachedLocation;
      if (loc != null) {
        currentCity.value = loc.city;
      }

      final cacheData = PrayerTimeCache.fromEntity(
        item,
        province: loc?.province,
        city: loc?.city,
      );
      await local.save(cacheData);

      await _schedulePrayerNotifications(item);

      _calculateNextPrayer(item);
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
      _isRefreshing = false;
    }
  }

  void _calculateNextPrayer(PrayerTime item) {
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
        _scheduleAdzanTimer();
        return;
      }
    }

    final tomorrow = now.add(const Duration(days: 1));
    nextPrayerName.value = "Subuh";
    nextPrayerTime.value = _parseTime(item.subuh, tomorrow);
    _schedulePrayerTimer();
    _scheduleAdzanTimer();
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

  Future<void> _schedulePrayerNotifications(PrayerTime item) async {
    final now = DateTime.now();
    final prayers = {
      "Imsak": item.imsak,
      "Subuh": item.subuh,
      "Dzuhur": item.dzuhur,
      "Ashar": item.ashar,
      "Maghrib": item.maghrib,
      "Isya": item.isya,
    };

    final prayerIds = {
      "Imsak": 6,
      "Subuh": 1,
      "Dzuhur": 2,
      "Ashar": 3,
      "Maghrib": 4,
      "Isya": 5,
    };

    for (final entry in prayers.entries) {
      DateTime prayerTime = _parseTime(entry.value, now);
      if (!prayerTime.isAfter(now.add(const Duration(seconds: 3)))) {
        prayerTime = prayerTime.add(const Duration(days: 1));
      }
      if (_isPrayerEnabled(entry.key)) {
        final isImsak = entry.key == "Imsak";
        await NotificationService().scheduleNotification(
          id: prayerIds[entry.key]!,
          title: "Al-Barokah: Quran & Sholat",
          body: isImsak ? "Waktu imsak tiba, bersiaplah untuk berpuasa" : "Saatnya sholat ${entry.key}",
          scheduledDate: prayerTime,
          soundType: settingsController.soundType.value,
          notificationMode: settingsController.notificationMode.value,
        );
      }
    }
  }

  Future<void> rescheduleNotifications() async {
    final item = todayPrayer.value;
    if (item == null) return;

    await NotificationService().cancelAllNotification();
    await _schedulePrayerNotifications(item);
  }

  @override
  void onClose() {
    _prayerTimer?.cancel();
    _adzanTimer?.cancel();
    _countdownTimer?.cancel();
    _isRefreshing = false;
    _disposed = true;
    super.onClose();
  }
}
