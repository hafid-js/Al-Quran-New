import 'dart:convert';

import 'package:alquran_new/development/core/db/hive_service.dart';
import 'package:alquran_new/development/alquran/data/hizb_ayat_cache.dart';
import 'package:alquran_new/development/alquran/models/juz_ayat.dart';
import 'package:alquran_new/development/alquran/domain/entities/surah.dart';

class HizbCacheDatasource {
  Future<List<JuzAyat>?> getHizb(int hizbNumber) async {
    try {
      final existing = DevHiveService.hizbAyatBox.values
          .where((c) => c.hizbNumber == hizbNumber)
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

  Future<void> saveHizb(int hizbNumber, List<JuzAyat> ayatList) async {
    final toDelete = DevHiveService.hizbAyatBox.values
        .where((c) => c.hizbNumber == hizbNumber)
        .map((c) => c.key as int)
        .toList();
    for (final key in toDelete) {
      await DevHiveService.hizbAyatBox.delete(key);
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

    final cache = HizbAyatCache()
      ..hizbNumber = hizbNumber
      ..ayatJson = jsonEncode(jsonData);

    await DevHiveService.hizbAyatBox.add(cache);
  }
}
