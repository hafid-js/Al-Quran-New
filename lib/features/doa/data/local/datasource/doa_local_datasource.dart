import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/features/doa/data/local/doa_cache.dart';
import 'package:alquran_new/features/doa/domain/entities/doa.dart';

class DoaLocalDataSource {
  Future<List<Doa>> getAllDoa() async {
    final caches = HiveService.doaBox.values.toList();
    return caches.map((e) => e.toEntity()).toList();
  }

  Future<void> saveAllDoa(List<Doa> doaList) async {
    await HiveService.doaBox.clear();
    final caches = doaList.map((e) => DoaCache.fromEntity(e)).toList();
    for (final item in caches) {
      await HiveService.doaBox.add(item);
    }
  }
}
