import 'package:alquran_new/features/alquran/data/local/ayat_cache.dart';
import 'package:alquran_new/features/alquran/data/local/surah_cache.dart';
import 'package:alquran_new/features/alquran/data/local/tafsir_cache.dart';
import 'package:alquran_new/features/bookmark/models/bookmark_model.dart';
import 'package:alquran_new/features/doa/data/local/doa_cache.dart';
import 'package:alquran_new/features/lokasi/data/location_cache.dart';
import 'package:alquran_new/features/pengaturan/models/app_settings.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static late Box<BookmarkModel> bookmarkBox;
  static late Box<AppSettings> settingsBox;
  static late Box<SurahCache> surahBox;
  static late Box<AyatCache> ayatBox;
  static late Box<TafsirCache> tafsirBox;
  static late Box<DoaCache> doaBox;
  static late Box<LocationCache> locationBox;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    Hive.registerAdapter(BookmarkModelAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
    Hive.registerAdapter(SurahCacheAdapter());
    Hive.registerAdapter(AyatCacheAdapter());
    Hive.registerAdapter(TafsirCacheAdapter());
    Hive.registerAdapter(DoaCacheAdapter());
    Hive.registerAdapter(LocationCacheAdapter());

    bookmarkBox = await Hive.openBox<BookmarkModel>('bookmarks');
    settingsBox = await Hive.openBox<AppSettings>('settings');
    surahBox = await Hive.openBox<SurahCache>('surahs');
    ayatBox = await Hive.openBox<AyatCache>('ayats');
    tafsirBox = await Hive.openBox<TafsirCache>('tafsirs');
    doaBox = await Hive.openBox<DoaCache>('doas');
    locationBox = await Hive.openBox<LocationCache>('locations');
  }
}
