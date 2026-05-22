import 'package:alquran_new/features/alquran/data/local/surah_cache.dart';
import 'package:isar/isar.dart';
part 'ayat_cache.g.dart';

@collection
class AyatCache {
    Id id = Isar.autoIncrement;
  late int nomorAyat;
  late String teksArab;
  late String teksLatin;
  late String teksIndonesia;

  late String audioJson;
  final surah = IsarLink<SurahCache>();
}