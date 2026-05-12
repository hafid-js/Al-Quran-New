import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/home/domain/repositories/prayer_time_repository.dart';

class GetPrayerTimes {
  final PrayerTimeRepository repository;

  GetPrayerTimes(this.repository);

  Future<Result<PrayerTimeResponse>> call({
    required String province,
    required String city,
  }) async {
    return repository.getPrayerTimes(province: province, city: city);
  }
}
