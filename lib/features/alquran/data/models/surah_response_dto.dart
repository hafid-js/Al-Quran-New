import 'package:alquran_new/features/alquran/data/models/detail_surah_response_dto.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:alquran_new/features/alquran/models/detail_surah_model.dart';

class SurahDTO {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<AyatDTO> ayat;

  const SurahDTO({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat
  });

  factory SurahDTO.fromJson(Map<String, dynamic> json) {
    return SurahDTO(
      nomor: (json['nomor'] as num?)?.toInt() ?? 0,
      nama: json['nama'] ?? '',
      namaLatin: json['namaLatin'] ?? '',
      jumlahAyat: (json['jumlahAyat'] as num?)?.toInt() ?? 0,
      tempatTurun: json['tempatTurun'] ?? '',
      arti: json['arti'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      audioFull: _parseMap(json['audioFull']),
        ayat: (json['ayat'] as List? ?? [])
        .map((e) => AyatDTO.fromJson(e))
        .toList(),
    );
  }

  static Map<String, String> _parseMap(dynamic json) {
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return {};
  }

  Surah toEntity() {
    return Surah(
      nomor: nomor,
      nama: nama,
      namaLatin: namaLatin,
      jumlahAyat: jumlahAyat,
      tempatTurun: TempatTurunX.fromString(tempatTurun),
      arti: arti,
      deskripsi: deskripsi,
      audioFull: audioFull,
      ayat: ayat.map((a) => Ayat(
        nomorAyat: a.nomorAyat,
        teksArab: a.teksArab,
        teksLatin: a.teksLatin,
        teksIndonesia: a.teksIndonesia,
        audio: a.audio,
      )).toList(),
    );
  }
}

class SurahListResponseDTO {
  final int code;
  final String message;
  final List<SurahDTO> data;

  const SurahListResponseDTO({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SurahListResponseDTO.fromJson(Map<String, dynamic> json) {
    return SurahListResponseDTO(
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => SurahDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
