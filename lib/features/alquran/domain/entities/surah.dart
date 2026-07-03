import 'package:alquran_new/features/alquran/models/detail_surah_model.dart';

enum TempatTurun { Madinah, Mekah }

extension TempatTurunX on TempatTurun {
  static TempatTurun fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'Madinah':
        return TempatTurun.Madinah;
      case 'Mekah':
        return TempatTurun.Mekah;
      default:
        return TempatTurun.Mekah;
    }
  }

  String get name {
    switch (this) {
      case TempatTurun.Madinah:
        return 'Madinah';
      case TempatTurun.Mekah:
        return 'Mekah';
    }
  }
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
  final List<Ayat> ayat;

  const Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    this.ayat = const [],
  });
}
