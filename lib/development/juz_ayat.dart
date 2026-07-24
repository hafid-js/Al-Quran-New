import 'package:alquran_new/features/alquran/domain/entities/surah.dart';

class JuzAyat {
  final int numberInSurah;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final int surahNomor;
  final String surahNamaLatin;
  final String surahArti;
  final TempatTurun surahTempatTurun;
  final int surahJumlahAyat;
  final Map<String, String> audio;

  const JuzAyat({
    required this.numberInSurah,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.surahNomor,
    required this.surahNamaLatin,
    required this.surahArti,
    required this.surahTempatTurun,
    required this.surahJumlahAyat,
    required this.audio,
  });
}
