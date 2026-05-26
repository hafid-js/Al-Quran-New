import 'package:alquran_new/features/alquran/data/local/ayat_cache.dart';
import 'package:alquran_new/features/alquran/data/local/surah_cache.dart';
import 'package:alquran_new/features/alquran/data/local/tafsir_cache.dart';
import 'package:alquran_new/features/bookmark/models/bookmark_model.dart';
import 'package:alquran_new/features/doa/data/local/doa_cache.dart';
import 'package:alquran_new/features/lokasi/data/location_cache.dart';
import 'package:alquran_new/features/pengaturan/models/app_settings.dart';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
  if (Isar.instanceNames.isNotEmpty) {
    isar = Isar.getInstance()!;
    return;
  }

  final dir = await getApplicationDocumentsDirectory();

  isar = await Isar.open(
    [
      BookmarkModelSchema,
      AppSettingsSchema,
      SurahCacheSchema,
      TafsirCacheSchema,
      AyatCacheSchema,
      DoaCacheSchema,
      LocationCacheSchema
    ],
    directory: dir.path,
  );
}
}
