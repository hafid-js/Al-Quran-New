import 'package:get/get.dart';

class SurahResponse {
  final int code;
  final String message;
  final List<Surah> data;

  const SurahResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SurahResponse.fromJson(Map<String, dynamic> json) {
    return SurahResponse(
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => Surah.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class Surah {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final TempatTurun tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
    RxString kondisiAudio;

  Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
      RxString? kondisiAudio,
  }) : kondisiAudio = kondisiAudio ?? "stop".obs;

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      nomor: (json['nomor'] as num?)?.toInt() ?? 0,
      nama: json['nama'] ?? '',
      namaLatin: json['namaLatin'] ?? '',
      jumlahAyat: (json['jumlahAyat'] as num?)?.toInt() ?? 0,
      tempatTurun: TempatTurunX.fromString(json['tempatTurun']),
      arti: json['arti'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      audioFull: _parseAudio(json['audioFull']),
    );
  }

  Map<String, dynamic> toJson() => {
        'nomor': nomor,
        'nama': nama,
        'namaLatin': namaLatin,
        'jumlahAyat': jumlahAyat,
        'tempatTurun': tempatTurun.toApi(),
        'arti': arti,
        'deskripsi': deskripsi,
        'audioFull': audioFull,
      };

  static Map<String, String> _parseAudio(dynamic json) {
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return {};
  }
}

enum TempatTurun { MADINAH, MEKAH }

extension TempatTurunX on TempatTurun {
  static TempatTurun fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'madinah':
        return TempatTurun.MADINAH;
      case 'mekah':
        return TempatTurun.MEKAH;
      default:
        return TempatTurun.MEKAH;
    }
  }

  String toApi() {
    switch (this) {
      case TempatTurun.MADINAH:
        return 'Madinah';
      case TempatTurun.MEKAH:
        return 'Mekah';
    }
  }
}