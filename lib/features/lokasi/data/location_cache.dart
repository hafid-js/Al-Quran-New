import 'package:isar/isar.dart';

part 'location_cache.g.dart';

@Collection()
class LocationCache {
  Id id = Isar.autoIncrement;

  late String province;
  late String city;

  DateTime updatedAt = DateTime.now();
}