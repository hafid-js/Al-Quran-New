import 'package:alquran_new/features/alquran/data/local/ayat_cache.dart';
import 'package:isar/isar.dart';

part 'surah_cache.g.dart';

@collection
class SurahCache {
  Id id = Isar.autoIncrement;

  late int nomor;
  late String namaLatin;
  late String nama;
  late int jumlahAyat;
  late String tempatTurun;
  late String arti;
  late String deskripsi;
  late String audioUrl;

  @Backlink(to: 'surah')
  final ayat = IsarLinks<AyatCache>();
}