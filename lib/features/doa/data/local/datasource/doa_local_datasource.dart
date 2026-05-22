import 'package:alquran_new/core/db/isar_service.dart';
import 'package:alquran_new/features/doa/data/local/doa_cache.dart';
import 'package:alquran_new/features/doa/domain/entities/doa.dart';
import 'package:isar/isar.dart';

class DoaLocalDataSource {
  final isar = IsarService.isar;

  Future<List<Doa>> getAllDoa() async {
    final caches = await isar.doaCaches.where().findAll();
    return caches.map((e) => e.toEntity()).toList();
  }

  Future<void> saveAllDoa(List<Doa> doaList) async {
    await isar.writeTxn(() async {
      await isar.doaCaches.clear();
      final caches = doaList.map((e) => DoaCache.fromEntity(e)).toList();
      await isar.doaCaches.putAll(caches);
    });
  }
}
