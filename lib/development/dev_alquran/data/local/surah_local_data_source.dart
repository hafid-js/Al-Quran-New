import 'package:alquran_new/development/dev_alquran/data/local/ayat_cache.dart';
import 'package:alquran_new/development/dev_alquran/data/local/dev_alquran_hive.dart';
import 'package:alquran_new/development/dev_alquran/data/local/surah_cache.dart';

abstract class SurahLocalDataSource {
  Future<List<SurahCache>> getAllSurah();

  Future<SurahCache?> getSurahByNomor(int nomor);

  Future<List<AyatCache>> getAyatBySurah(int nomor);

  Future<void> saveAllSurah(List<SurahCache> surahs);

  Future<void> saveSurahDetail(SurahCache surah, List<AyatCache> ayat);
}

class SurahLocalDataSourceImpl implements SurahLocalDataSource {
  @override
  Future<List<SurahCache>> getAllSurah() async {
    final box = await DevAlquranHive.surahBox;
    final result = box.values.toList();

    result.sort((a, b) => a.nomor.compareTo(b.nomor));
    return result;
  }

  @override
  Future<SurahCache?> getSurahByNomor(int nomor) async {
    final box = await DevAlquranHive.surahBox;
    return box.get(nomor);
  }

  @override
  Future<List<AyatCache>> getAyatBySurah(int nomor) async {
    final box = await DevAlquranHive.ayatBox;
    final result = box.values.where((e) => e.surahNomor == nomor).toList();

    result.sort((a, b) => a.nomorAyat.compareTo(b.nomorAyat));
    return result;
  }

  @override
  Future<void> saveAllSurah(List<SurahCache> surahs) async {
    final box = await DevAlquranHive.surahBox;

    await box.clear();
    for (final surah in surahs) {
      await box.put(surah.nomor, surah);
    }
  }

  @override
  Future<void> saveSurahDetail(SurahCache surah, List<AyatCache> ayat) async {
    final surahBox = await DevAlquranHive.surahBox;
    final ayatBox = await DevAlquranHive.ayatBox;

    await surahBox.put(surah.nomor, surah);

    final oldKeys = ayatBox.keys.where((key) {
      final item = ayatBox.get(key);
      return item != null && item.surahNomor == surah.nomor;
    }).toList();

    await ayatBox.deleteAll(oldKeys);

    for (final item in ayat) {
      await ayatBox.put('${surah.nomor}_${item.nomorAyat}', item);
    }
  }
}
