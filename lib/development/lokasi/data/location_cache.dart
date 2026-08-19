import 'package:hive/hive.dart';

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
