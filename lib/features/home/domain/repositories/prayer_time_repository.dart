import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/home/domain/entities/prayer_time.dart';

abstract class PrayerTimeRepository {
  Future<Result<PrayerTimeResponse>> getPrayerTimes({
    required String province,
    required String city,
  });
}

class PrayerTimeResponse {
  final String province;
  final String city;
  final List<PrayerTime> schedules;

  const PrayerTimeResponse({
    required this.province,
    required this.city,
    required this.schedules,
  });
}
