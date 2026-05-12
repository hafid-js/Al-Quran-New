import 'package:alquran_new/features/alquran/domain/entities/detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/entities/ayat.dart';

class DetailSurahResponseDTO {
  final int code;
  final String message;
  final DetailSurahDTO data;

  const DetailSurahResponseDTO({
    required this.code,
    required this.message,
    required this.data,
  });

  factory DetailSurahResponseDTO.fromJson(Map<String, dynamic> json) {
    return DetailSurahResponseDTO(
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] ?? '',
      data: DetailSurahDTO.fromJson(json['data'] ?? {}),
    );
  }
}

class DetailSurahDTO {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<AyatDTO> ayat;

  const DetailSurahDTO({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat,
  });

  factory DetailSurahDTO.fromJson(Map<String, dynamic> json) {
    return DetailSurahDTO(
      nomor: (json['nomor'] as num?)?.toInt() ?? 0,
      nama: json['nama'] ?? '',
      namaLatin: json['namaLatin'] ?? '',
      jumlahAyat: (json['jumlahAyat'] as num?)?.toInt() ?? 0,
      tempatTurun: json['tempatTurun'] ?? '',
      arti: json['arti'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      audioFull: _parseMap(json['audioFull']),
      ayat: _parseAyatList(json['ayat']),
    );
  }

  static Map<String, String> _parseMap(dynamic json) {
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return {};
  }

  static List<AyatDTO> _parseAyatList(dynamic json) {
    if (json is List) {
      return json.map((e) => AyatDTO.fromJson(e)).toList();
    }
    return [];
  }

  DetailSurah toEntity() {
    return DetailSurah(
      nomor: nomor,
      nama: nama,
      namaLatin: namaLatin,
      jumlahAyat: jumlahAyat,
      tempatTurun: tempatTurun,
      arti: arti,
      deskripsi: deskripsi,
      audioFull: audioFull,
      ayat: ayat.map((a) => a.toEntity()).toList(),
    );
  }
}

class AyatDTO {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<String, String> audio;

  const AyatDTO({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory AyatDTO.fromJson(Map<String, dynamic> json) {
    return AyatDTO(
      nomorAyat: (json['nomorAyat'] as num?)?.toInt() ?? 0,
      teksArab: json['teksArab'] ?? '',
      teksLatin: json['teksLatin'] ?? '',
      teksIndonesia: json['teksIndonesia'] ?? '',
      audio: _parseMap(json['audio']),
    );
  }

  static Map<String, String> _parseMap(dynamic json) {
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return {};
  }

  Ayat toEntity() {
    return Ayat(
      nomorAyat: nomorAyat,
      teksArab: teksArab,
      teksLatin: teksLatin,
      teksIndonesia: teksIndonesia,
      audio: audio,
    );
  }
}
