import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/features/home/data/local/prayer_time_cache.dart';

class PrayerTimeLocalDatasource {
  Future<void> save(PrayerTimeCache data) async {
    await HiveService.prayerTimeBox.clear();
    await HiveService.prayerTimeBox.add(data);
  }

  PrayerTimeCache? get() {
    return HiveService.prayerTimeBox.values.firstOrNull;
  }

  Future<void> clear() async {
    await HiveService.prayerTimeBox.clear();
  }
}
