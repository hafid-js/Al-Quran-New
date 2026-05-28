import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/features/alquran/data/local/surah_cache.dart';

class SurahLocalDatasource {
  Future<void> saveSurah(List<SurahCache> surahList) async {
    await HiveService.surahBox.clear();
    for (final item in surahList) {
      await HiveService.surahBox.add(item);
    }
  }

  Future<List<SurahCache>> getSurah() async {
    return HiveService.surahBox.values.toList();
  }

  Future<SurahCache?> getByNomor(int nomor) async {
    try {
      return HiveService.surahBox.values.firstWhere((s) => s.nomor == nomor);
    } catch (_) {
      return null;
    }
  }
}
