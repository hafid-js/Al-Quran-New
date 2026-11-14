import 'dart:convert';

import 'package:alquran_new/development/dev_alquran/domain/entities/ayat.dart';
import 'package:alquran_new/development/dev_alquran/data/local/ayat_cache.dart';
import 'package:alquran_new/development/dev_alquran/data/local/surah_cache.dart';
import 'package:alquran_new/development/dev_alquran/data/models/tempat_turun_mapper.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah.dart';

extension SurahCacheMapper on SurahCache {
  Surah toEntity() {
    return Surah(
      nomor: nomor,
      nama: nama,
      namaLatin: namaLatin,
      jumlahAyat: jumlahAyat,
      tempatTurun: tempatTurunFromString(tempatTurun),
      arti: arti,
      deskripsi: deskripsi,
      audioFull: _decodeStringMap(audioFullJson),
    );
  }
}

extension AyatCacheMapper on AyatCache {
  Ayat toEntity() {
    return Ayat(
      nomorAyat: nomorAyat,
      teksArab: teksArab,
      teksLatin: teksLatin,
      teksIndonesia: teksIndonesia,
      audio: _decodeStringMap(audioJson),
    );
  }
}

SurahCache surahToCache(Surah surah) {
  return SurahCache()
    ..nomor = surah.nomor
    ..nama = surah.nama
    ..namaLatin = surah.namaLatin
    ..jumlahAyat = surah.jumlahAyat
    ..tempatTurun = surah.tempatTurun.name
    ..arti = surah.arti
    ..deskripsi = surah.deskripsi
    ..audioFullJson = jsonEncode(surah.audioFull);
}

AyatCache ayatToCache(Ayat ayat, int surahNomor) {
  return AyatCache()
    ..surahNomor = surahNomor
    ..nomorAyat = ayat.nomorAyat
    ..teksArab = ayat.teksArab
    ..teksLatin = ayat.teksLatin
    ..teksIndonesia = ayat.teksIndonesia
    ..audioJson = jsonEncode(ayat.audio);
}

Map<String, String> _decodeStringMap(String value) {
  if (value.isEmpty) return const <String, String>{};

  try {
    final decoded = jsonDecode(value);
    if (decoded is Map) {
      return Map<String, String>.from(decoded);
    }
  } catch (_) {
    // Cache rusak / format lama: diianggap kosong.
  }

  return const <String, String>{};
}
