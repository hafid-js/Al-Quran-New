import 'package:alquran_new/core/db/isar_service.dart';
import 'package:alquran_new/features/alquran/data/local/surah_cache.dart';
import 'package:isar/isar.dart';

class SurahLocalDatasource {
  final isar = IsarService.isar;

  Future<void> saveSurah(List<SurahCache> surahList) async {
    await isar.writeTxn(() async {
      await isar.surahCaches.clear();
      await isar.surahCaches.putAll(surahList);
    });
  }

  Future<List<SurahCache>> getSurah() async {
    return await isar.surahCaches.where().findAll();
  }

  Future<SurahCache?> getByNomor(int nomor) async {
    return await isar.surahCaches
    .filter()
    .nomorEqualTo(nomor)
    .findFirst();
  }
}