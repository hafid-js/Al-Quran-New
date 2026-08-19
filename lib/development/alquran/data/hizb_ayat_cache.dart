import 'package:hive/hive.dart';

part 'hizb_ayat_cache.g.dart';

@HiveType(typeId: 10)
class HizbAyatCache extends HiveObject {
  @HiveField(0)
  late int hizbNumber;

  @HiveField(1)
  late String ayatJson;
}
