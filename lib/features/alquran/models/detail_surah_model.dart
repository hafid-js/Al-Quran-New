class DetailSurah {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<Ayat> ayat;
  final SurahNav? suratSelanjutnya;
  final SurahNav? suratSebelumnya;

  const DetailSurah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat,
    this.suratSelanjutnya,
    this.suratSebelumnya,
  });

  factory DetailSurah.fromJson(Map<String, dynamic> json) {
    return DetailSurah(
      nomor: (json['nomor'] as num?)?.toInt() ?? 0,
      nama: json['nama'] ?? '',
      namaLatin: json['namaLatin'] ?? '',
      jumlahAyat: (json['jumlahAyat'] as num?)?.toInt() ?? 0,
      tempatTurun: json['tempatTurun'] ?? '',
      arti: json['arti'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      audioFull: _mapString(json['audioFull']),
      ayat: _parseAyat(json['ayat']),
      suratSelanjutnya: json['suratSelanjutnya'] is Map<String, dynamic>
          ? SurahNav.fromJson(json['suratSelanjutnya'])
          : null,
      suratSebelumnya: json['suratSebelumnya'] is Map<String, dynamic>
          ? SurahNav.fromJson(json['suratSebelumnya'])
          : null,
    );
  }

  static Map<String, String> _mapString(dynamic json) {
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return {};
  }

  static List<Ayat> _parseAyat(dynamic json) {
    if (json is List) {
      return json.map((e) => Ayat.fromJson(e)).toList();
    }
    return [];
  }
}

class Ayat {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<String, String> audio;

  const Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      nomorAyat: (json['nomorAyat'] as num?)?.toInt() ?? 0,
      teksArab: json['teksArab'] ?? '',
      teksLatin: json['teksLatin'] ?? '',
      teksIndonesia: json['teksIndonesia'] ?? '',
      audio: _mapAudio(json['audio']),
    );
  }

  static Map<String, String> _mapAudio(dynamic json) {
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return {};
  }
}

class SurahNav {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;

  const SurahNav({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory SurahNav.fromJson(Map<String, dynamic> json) {
    return SurahNav(
      nomor: (json['nomor'] as num?)?.toInt() ?? 0,
      nama: json['nama'] ?? '',
      namaLatin: json['namaLatin'] ?? '',
      jumlahAyat: (json['jumlahAyat'] as num?)?.toInt() ?? 0,
    );
  }
}