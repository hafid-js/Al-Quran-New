import 'package:hive_ce/hive_ce.dart';

part 'location_cache.g.dart';

@HiveType(typeId: 6)
class LocationCache extends HiveObject {
  @HiveField(0)
  late String province;
  @HiveField(1)
  late String city;
  @HiveField(2)
  DateTime updatedAt = DateTime.now();
}
