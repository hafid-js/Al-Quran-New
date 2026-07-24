import 'package:hive/hive.dart';

part 'juz_ayat_cache.g.dart';

@HiveType(typeId: 9)
class JuzAyatCache extends HiveObject {
  @HiveField(0)
  late int juzNumber;

  @HiveField(1)
  late String ayatJson;
}
