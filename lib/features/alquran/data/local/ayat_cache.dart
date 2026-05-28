import 'package:hive/hive.dart';

part 'ayat_cache.g.dart';

@HiveType(typeId: 3)
class AyatCache extends HiveObject {
  @HiveField(0)
  late int nomorAyat;
  @HiveField(1)
  late String teksArab;
  @HiveField(2)
  late String teksLatin;
  @HiveField(3)
  late String teksIndonesia;
  @HiveField(4)
  late String audioJson;
  @HiveField(5)
  int surahNomor = 0;
}
