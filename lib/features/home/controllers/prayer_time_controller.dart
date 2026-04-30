import 'dart:async';
import 'package:alquran_new/features/home/models/prayer_time.dart';
import 'package:alquran_new/features/home/repository/prayer_time_repository.dart';
import 'package:get/get.dart';

class PrayerTimeController extends GetxController {
  final PrayerTimeRepository repo;

  PrayerTimeController({required this.repo});

  // reactive variables
  var todayPrayer = Rxn<PrayerTime>();
  var nextPrayerName = "".obs;
  var nextPrayerTime = Rxn<DateTime>();
  var remaining = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;

  var isLoading = true.obs;
  var errorMessage = RxnString();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchPrayerTimes();
  }

  void fetchPrayerTimes() async {
    try {
      isLoading.value = true;
      final data = await repo.fetchPrayerTimes(
        province: "Jawa Tengah",
        city: "Kab. Purworejo",
      );

      final schedules = data['schedules'] as List<PrayerTime>;
      if (schedules.isNotEmpty) {
        todayPrayer.value = schedules[0];
        getNextPrayer(schedules);
        _startTimer(schedules);
      }

      isLoading.value = false;
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
  }

  void getNextPrayer(List<PrayerTime> schedules) {
    final now = DateTime.now();

    for (final item in schedules) {
      final prayers = {
        "Subuh": item.fajr,
        "Dzuhur": item.dhuhr,
        "Ashar": item.asr,
        "Maghrib": item.maghrib,
        "Isya": item.isha,
      };

      for (final entry in prayers.entries) {
        final hour = int.parse(entry.value.split(":")[0]);
        final minute = int.parse(entry.value.split(":")[1]);
        final dt = DateTime(now.year, now.month, now.day, hour, minute);

        if (dt.isAfter(now)) {
          nextPrayerName.value = entry.key;
          nextPrayerTime.value = dt;
          totalDuration.value = dt.difference(now);
          remaining.value = totalDuration.value;
          return;
        }
      }
    }

    // Jika semua jadwal hari ini sudah lewat, ambil Subuh besok
    final tomorrow = schedules[0];
    final fajr = tomorrow.fajr.split(":");
    nextPrayerTime.value = DateTime(
      now.year,
      now.month,
      now.day + 1,
      int.parse(fajr[0]),
      int.parse(fajr[1]),
    );
    nextPrayerName.value = "Subuh";
    totalDuration.value = nextPrayerTime.value!.difference(now);
    remaining.value = totalDuration.value;
  }

  void _startTimer(List<PrayerTime> schedules) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();

      final prayers = {
        "Subuh": schedules[0].fajr,
        "Dzuhur": schedules[0].dhuhr,
        "Ashar": schedules[0].asr,
        "Maghrib": schedules[0].maghrib,
        "Isya": schedules[0].isha,
      };

      DateTime? nextPrayerDT;
      DateTime? currentPrayerDT;

      for (final entry in prayers.entries.toList()) {
        final hour = int.parse(entry.value.split(":")[0]);
        final minute = int.parse(entry.value.split(":")[1]);
        final dt = DateTime(now.year, now.month, now.day, hour, minute);

        if (dt.isAfter(now) && nextPrayerDT == null) {
          nextPrayerDT = dt;
          nextPrayerName.value = entry.key;
        }
        if (dt.isBefore(now) || dt.isAtSameMomentAs(now)) {
          currentPrayerDT = dt;
        }
      }

      if (nextPrayerDT == null) {
        final fajr = schedules[0].fajr.split(":");
        nextPrayerDT = DateTime(
          now.year,
          now.month,
          now.day + 1,
          int.parse(fajr[0]),
          int.parse(fajr[1]),
        );
        nextPrayerName.value = "Subuh";
        currentPrayerDT = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(schedules[0].isha.split(":")[0]),
          int.parse(schedules[0].isha.split(":")[1]),
        );
      }

      totalDuration.value = nextPrayerDT.difference(currentPrayerDT!);
      remaining.value = nextPrayerDT.difference(now);
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  double get percent {
    if (totalDuration.value.inSeconds > 0) {
      double p = (totalDuration.value.inSeconds - remaining.value.inSeconds) /
          totalDuration.value.inSeconds;
      return p.clamp(0.0, 1.0);
    }
    return 0.0;
  }
}