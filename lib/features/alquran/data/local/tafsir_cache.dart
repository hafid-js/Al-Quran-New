import 'package:isar/isar.dart';

part 'tafsir_cache.g.dart';

@collection
class TafsirCache {
  Id id = Isar.autoIncrement;

  late int nomorSurah;
  late int nomorAyat;
  late String tafsir;
}