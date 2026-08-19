import 'package:alquran_new/development/core/db/hive_service.dart';
import 'package:alquran_new/development/doa/data/local/doa_cache.dart';
import 'package:alquran_new/development/doa/domain/entities/doa.dart';

class DoaLocalDataSource {
  Future<List<Doa>> getAllDoa() async {
    final caches = DevHiveService.doaBox.values.toList();
    return caches.map((e) => e.toEntity()).toList();
  }

  Future<void> saveAllDoa(List<Doa> doaList) async {
    await DevHiveService.doaBox.clear();
    final caches = doaList.map((e) => DoaCache.fromEntity(e)).toList();
    for (final item in caches) {
      await DevHiveService.doaBox.add(item);
    }
  }
}
