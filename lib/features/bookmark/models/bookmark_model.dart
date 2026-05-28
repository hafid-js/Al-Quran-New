import 'package:hive/hive.dart';

part 'bookmark_model.g.dart';

@HiveType(typeId: 0)
class BookmarkModel extends HiveObject {
  @HiveField(0)
  late int surahNumber;
  @HiveField(1)
  late String arabName;
  @HiveField(2)
  late String surahName;
  @HiveField(3)
  late int ayatNumber;
  @HiveField(4)
  DateTime createdAt = DateTime.now();
}
