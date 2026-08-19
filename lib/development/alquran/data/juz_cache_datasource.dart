import 'dart:convert';

import 'package:alquran_new/development/core/db/hive_service.dart';
import 'package:alquran_new/development/alquran/models/juz_ayat.dart';
import 'package:alquran_new/development/alquran/data/juz_ayat_cache.dart';
import 'package:alquran_new/development/alquran/domain/entities/surah.dart';

class JuzCacheDatasource {
  Future<List<JuzAyat>?> getJuz(int juzNumber) async {
    try {
      final existing = DevHiveService.juzAyatBox.values
          .where((c) => c.juzNumber == juzNumber)
          .toList();

      if (existing.isEmpty) return null;

      final List<dynamic> decoded = jsonDecode(existing.first.ayatJson);
      return decoded.map((e) => JuzAyat(
        numberInSurah: e['numberInSurah'] ?? 0,
        teksArab: e['teksArab'] ?? '',
        teksLatin: e['teksLatin'] ?? '',
        teksIndonesia: e['teksIndonesia'] ?? '',
        surahNomor: e['surahNomor'] ?? 0,
        surahNamaLatin: e['surahNamaLatin'] ?? '',
        surahArti: e['surahArti'] ?? '',
        surahTempatTurun: TempatTurunX.fromString(e['surahTempatTurun']),
        surahJumlahAyat: e['surahJumlahAyat'] ?? 0,
        audio: Map<String, String>.from(e['audio'] ?? {}),
      )).toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> saveJuz(int juzNumber, List<JuzAyat> ayatList) async {
    final toDelete = DevHiveService.juzAyatBox.values
        .where((c) => c.juzNumber == juzNumber)
        .map((c) => c.key as int)
        .toList();
    for (final key in toDelete) {
      await DevHiveService.juzAyatBox.delete(key);
    }

    final jsonData = ayatList.map((a) => {
      'numberInSurah': a.numberInSurah,
      'teksArab': a.teksArab,
      'teksLatin': a.teksLatin,
      'teksIndonesia': a.teksIndonesia,
      'surahNomor': a.surahNomor,
      'surahNamaLatin': a.surahNamaLatin,
      'surahArti': a.surahArti,
      'surahTempatTurun': a.surahTempatTurun.name,
      'surahJumlahAyat': a.surahJumlahAyat,
      'audio': a.audio,
    }).toList();

    final cache = JuzAyatCache()
      ..juzNumber = juzNumber
      ..ayatJson = jsonEncode(jsonData);

    await DevHiveService.juzAyatBox.add(cache);
  }
}
