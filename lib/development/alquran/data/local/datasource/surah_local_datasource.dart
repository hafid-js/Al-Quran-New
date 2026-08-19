import 'package:alquran_new/development/core/db/hive_service.dart';
import 'package:alquran_new/development/alquran/data/local/surah_cache.dart';

class SurahLocalDatasource {
  Future<void> saveSurah(List<SurahCache> surahList) async {
    await DevHiveService.surahBox.clear();
    for (final item in surahList) {
      await DevHiveService.surahBox.add(item);
    }
  }

  Future<List<SurahCache>> getSurah() async {
    return DevHiveService.surahBox.values.toList();
  }

  Future<SurahCache?> getByNomor(int nomor) async {
    try {
      return DevHiveService.surahBox.values.firstWhere((s) => s.nomor == nomor);
    } catch (_) {
      return null;
    }
  }
}
