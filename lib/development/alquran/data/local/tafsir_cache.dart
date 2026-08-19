import 'package:hive/hive.dart';

part 'tafsir_cache.g.dart';

@HiveType(typeId: 4)
class TafsirCache extends HiveObject {
  @HiveField(0)
  late int nomorSurah;
  @HiveField(1)
  late int nomorAyat;
  @HiveField(2)
  late String tafsir;
}
