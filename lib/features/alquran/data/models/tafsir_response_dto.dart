import 'package:alquran_new/features/alquran/domain/entities/tafsir.dart';

class TafsirResponseDTO {
  final int code;
  final String message;
  final TafsirDetailDTO data;

  const TafsirResponseDTO({
    required this.code,
    required this.message,
    required this.data,
  });

  factory TafsirResponseDTO.fromJson(Map<String, dynamic> json) {
    return TafsirResponseDTO(
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] ?? '',
      data: TafsirDetailDTO.fromJson(json['data'] ?? {}),
    );
  }
}

class TafsirDetailDTO {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<TafsirAyatDTO> tafsir;

  const TafsirDetailDTO({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.tafsir,
  });

  factory TafsirDetailDTO.fromJson(Map<String, dynamic> json) {
    return TafsirDetailDTO(
      nomor: (json['nomor'] as num?)?.toInt() ?? 0,
      nama: json['nama'] ?? '',
      namaLatin: json['namaLatin'] ?? '',
      jumlahAyat: (json['jumlahAyat'] as num?)?.toInt() ?? 0,
      tempatTurun: json['tempatTurun'] ?? '',
      arti: json['arti'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      audioFull: _parseMap(json['audioFull']),
      tafsir: _parseTafsirList(json['tafsir']),
    );
  }

  static Map<String, String> _parseMap(dynamic json) {
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return {};
  }

  static List<TafsirAyatDTO> _parseTafsirList(dynamic json) {
    if (json is List) {
      return json.map((e) => TafsirAyatDTO.fromJson(e)).toList();
    }
    return [];
  }
}

class TafsirAyatDTO {
  final int ayat;
  final String teks;

  const TafsirAyatDTO({
    required this.ayat,
    required this.teks,
  });

  factory TafsirAyatDTO.fromJson(Map<String, dynamic> json) {
    return TafsirAyatDTO(
      ayat: (json['ayat'] as num?)?.toInt() ?? 0,
      teks: json['teks'] ?? '',
    );
  }

  TafsirAyat toEntity() {
    return TafsirAyat(
      ayat: ayat,
      teks: teks,
    );
  }
}
