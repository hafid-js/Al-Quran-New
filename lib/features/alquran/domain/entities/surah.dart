enum TempatTurun { madinah, mekah }

extension TempatTurunX on TempatTurun {
  static TempatTurun fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'madinah':
        return TempatTurun.madinah;
      case 'mekah':
        return TempatTurun.mekah;
      default:
        return TempatTurun.mekah;
    }
  }

  String get name {
    switch (this) {
      case TempatTurun.madinah:
        return 'Madinah';
      case TempatTurun.mekah:
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

  const Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
  });
}
