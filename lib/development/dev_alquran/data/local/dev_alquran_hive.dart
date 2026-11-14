import 'package:alquran_new/development/dev_alquran/data/local/ayat_cache.dart';
import 'package:alquran_new/development/dev_alquran/data/local/surah_cache.dart';
import 'package:hive_ce_flutter/adapters.dart';

class DevAlquranHive {
  static const String surahBoxName = 'dev_alquran_surahs';
  static const String ayatBoxName = 'dev_alquran_ayats';

  static Future<void>? _initFuture;
  static late Box<SurahCache> _surahBox;
  static late Box<AyatCache> _ayatBox;

  static Future<void> init() {
    return _initFuture ??= _openBoxes();
  }

  static Future<Box<SurahCache>> get surahBox async {
    await init();
    return _surahBox;
  }

  static Future<Box<AyatCache>> get ayatBox async {
    await init();
    return _ayatBox;
  }

  static Future<void> _openBoxes() async {
    if(!Hive.isAdapterRegistered(20)) {
      Hive.registerAdapter(SurahCacheAdapter());
    }
    if(!Hive.isAdapterRegistered(21)) {
      Hive.registerAdapter(AyatCacheAdapter());
    }

    _surahBox = await Hive.openBox<SurahCache>(surahBoxName);
    _ayatBox = await Hive.openBox<AyatCache>(ayatBoxName);
  }
}