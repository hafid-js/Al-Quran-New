class TafsirResponse {
  final int code;
  final String message;
  final TafsirDetail data;

  const TafsirResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory TafsirResponse.fromJson(Map<String, dynamic> json) {
    return TafsirResponse(
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] ?? '',
      data: TafsirDetail.fromJson(json['data'] ?? {}),
    );
  }
}

class TafsirDetail {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<TafsirAyat> tafsir;

  const TafsirDetail({
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

  factory TafsirDetail.fromJson(Map<String, dynamic> json) {
    return TafsirDetail(
      nomor: (json['nomor'] as num?)?.toInt() ?? 0,
      nama: json['nama'] ?? '',
      namaLatin: json['namaLatin'] ?? '',
      jumlahAyat: (json['jumlahAyat'] as num?)?.toInt() ?? 0,
      tempatTurun: json['tempatTurun'] ?? '',
      arti: json['arti'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      audioFull: _mapString(json['audioFull']),
      tafsir: _parseTafsir(json['tafsir']),
    );
  }

  static Map<String, String> _mapString(dynamic json) {
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return {};
  }

  static List<TafsirAyat> _parseTafsir(dynamic json) {
    if (json is List) {
      return json.map((e) => TafsirAyat.fromJson(e)).toList();
    }
    return [];
  }
}

class TafsirAyat {
  final int ayat;
  final String teks;

  const TafsirAyat({
    required this.ayat,
    required this.teks,
  });

  factory TafsirAyat.fromJson(Map<String, dynamic> json) {
    return TafsirAyat(
      ayat: (json['ayat'] as num?)?.toInt() ?? 0,
      teks: json['teks'] ?? '',
    );
  }
}