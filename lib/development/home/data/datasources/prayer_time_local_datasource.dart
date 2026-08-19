import 'package:alquran_new/development/core/db/hive_service.dart';
import 'package:alquran_new/development/home/data/local/prayer_time_cache.dart';

class PrayerTimeLocalDatasource {
  Future<void> save(PrayerTimeCache data) async {
    await DevHiveService.prayerTimeBox.clear();
    await DevHiveService.prayerTimeBox.add(data);
  }

  PrayerTimeCache? get() {
    return DevHiveService.prayerTimeBox.values.firstOrNull;
  }

  Future<void> clear() async {
    await DevHiveService.prayerTimeBox.clear();
  }
}
