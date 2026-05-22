import 'package:alquran_new/core/db/isar_service.dart';
import 'package:alquran_new/features/alquran/data/local/tafsir_cache.dart';
import 'package:isar/isar.dart';

class TafsirLocalDataSource {
  final isar = IsarService.isar;

  Future<void> saveTafsir(List<TafsirCache> data) async {
    await isar.writeTxn(() async {
      await isar.tafsirCaches.putAll(data);
    });
  }

  Future<List<TafsirCache>> getBySurah(int nomor) {
    return isar.tafsirCaches
    .filter()
    .nomorSurahEqualTo(nomor)
    .findAll();
  }
}