import 'dart:async';
import 'package:alquran_new/features/home/repository/prayer_time_repository.dart';
import 'package:alquran_new/features/lokasi/services/location_service.dart';
import 'package:alquran_new/features/home/models/prayer_time_model.dart';
import 'package:get/get.dart';

class PrayerTimeController extends GetxController {
  final PrayerTimeRepository repo;

  PrayerTimeController({required this.repo});

  var todayPrayer = Rxn<PrayerTimeModel>();

  var nextPrayerName = "".obs;
  var nextPrayerTime = Rxn<DateTime>();

  var remaining = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;

  var isLoading = true.obs;
  var errorMessage = RxnString();

  var currentCity = "Kab. Purworejo".obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchPrayerTimes();
  }

  // ================= FETCH =================
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


    final subuhTomorrow = _parseTime(item.subuh, now.add(const Duration(days: 1)));

    nextPrayerName.value = "Subuh";
    nextPrayerTime.value = subuhTomorrow;
  }


  void _startTimer(PrayerTimeModel item) {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();

      final next = nextPrayerTime.value;
      if (next == null) return;

      remaining.value = next.difference(now);

      if (remaining.value.isNegative) {
        fetchPrayerTimes();
      }

      totalDuration.value = remaining.value; 
    });
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