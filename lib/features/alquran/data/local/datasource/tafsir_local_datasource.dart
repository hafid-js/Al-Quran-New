import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/features/alquran/data/local/tafsir_cache.dart';

class TafsirLocalDataSource {
  Future<void> saveTafsir(List<TafsirCache> data) async {
    final keysToDelete = HiveService.tafsirBox.values
        .where((t) => t.nomorSurah == data.first.nomorSurah)
        .map((t) => t.key as int)
        .toList();
    for (final key in keysToDelete) {
      await HiveService.tafsirBox.delete(key);
    }
    for (final item in data) {
      await HiveService.tafsirBox.add(item);
    }
  }

  Future<List<TafsirCache>> getBySurah(int nomor) {
    return Future.value(
      HiveService.tafsirBox.values
          .where((t) => t.nomorSurah == nomor)
          .toList(),
    );
  }
}
