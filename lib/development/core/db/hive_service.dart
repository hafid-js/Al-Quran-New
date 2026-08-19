import 'package:alquran_new/development/alquran/data/hizb_ayat_cache.dart';
import 'package:alquran_new/development/alquran/data/juz_ayat_cache.dart';
import 'package:alquran_new/development/alquran/data/local/ayat_cache.dart';
import 'package:alquran_new/development/alquran/data/local/surah_cache.dart';
import 'package:alquran_new/development/alquran/data/local/tafsir_cache.dart';
import 'package:alquran_new/development/bookmark/models/bookmark_model.dart';
import 'package:alquran_new/development/doa/data/local/doa_cache.dart';
import 'package:alquran_new/development/home/data/local/prayer_time_cache.dart';
import 'package:alquran_new/development/lokasi/data/location_cache.dart';
import 'package:alquran_new/development/pengaturan/models/app_settings.dart';
import 'package:alquran_new/development/pengaturan/models/notification_settings.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class DevHiveService {
  static late Box<BookmarkModel> bookmarkBox;
  static late Box<AppSettings> settingsBox;
  static late Box<SurahCache> surahBox;
  static late Box<AyatCache> ayatBox;
  static late Box<TafsirCache> tafsirBox;
  static late Box<DoaCache> doaBox;
  static late Box<LocationCache> locationBox;
  static late Box<NotificationSettings> notificationBox;
  static late Box<PrayerTimeCache> prayerTimeBox;
  static late Box<JuzAyatCache> juzAyatBox;
  static late Box<HizbAyatCache> hizbAyatBox;

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
    Hive.registerAdapter(NotificationSettingsAdapter());
    Hive.registerAdapter(PrayerTimeCacheAdapter());
    Hive.registerAdapter(JuzAyatCacheAdapter());
    Hive.registerAdapter(HizbAyatCacheAdapter());

    bookmarkBox = await Hive.openBox<BookmarkModel>('dev_bookmarks');
    settingsBox = await Hive.openBox<AppSettings>('dev_settings');
    surahBox = await Hive.openBox<SurahCache>('dev_surahs');
    ayatBox = await Hive.openBox<AyatCache>('dev_ayats');
    tafsirBox = await Hive.openBox<TafsirCache>('dev_tafsirs');
    doaBox = await Hive.openBox<DoaCache>('dev_doas');
    locationBox = await Hive.openBox<LocationCache>('dev_locations');
    notificationBox = await Hive.openBox<NotificationSettings>('dev_notification_settings');
    prayerTimeBox = await Hive.openBox<PrayerTimeCache>('dev_prayer_times');
    juzAyatBox = await Hive.openBox<JuzAyatCache>('dev_juz_ayats');
    hizbAyatBox = await Hive.openBox<HizbAyatCache>('dev_hizb_ayats');
  }
}
