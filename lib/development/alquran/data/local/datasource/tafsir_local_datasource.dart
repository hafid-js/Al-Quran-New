import 'package:alquran_new/development/core/db/hive_service.dart';
import 'package:alquran_new/development/alquran/data/local/tafsir_cache.dart';

class TafsirLocalDataSource {
  Future<void> saveTafsir(List<TafsirCache> data) async {
    final keysToDelete = DevHiveService.tafsirBox.values
        .where((t) => t.nomorSurah == data.first.nomorSurah)
        .map((t) => t.key as int)
        .toList();
    for (final key in keysToDelete) {
      await DevHiveService.tafsirBox.delete(key);
    }
    for (final item in data) {
      await DevHiveService.tafsirBox.add(item);
    }
  }

  Future<List<TafsirCache>> getBySurah(int nomor) {
    return Future.value(
      DevHiveService.tafsirBox.values
          .where((t) => t.nomorSurah == nomor)
          .toList(),
    );
  }
}
