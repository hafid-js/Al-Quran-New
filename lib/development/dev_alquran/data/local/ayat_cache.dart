import 'package:hive_ce/hive_ce.dart';

part 'ayat_cache.g.dart';

@HiveType(typeId: 21)
class AyatCache {
  @HiveField(0)
  late int surahNomor;

  @HiveField(1)
  late int nomorAyat;

  @HiveField(2)
  late String teksArab;

  @HiveField(3)
  late String teksLatin;

  @HiveField(4)
  late String teksIndonesia;

  @HiveField(5)
  late String audioJson;
}