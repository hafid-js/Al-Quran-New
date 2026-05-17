import 'package:isar/isar.dart';

part 'bookmark_model.g.dart';

@Collection()
class BookmarkModel {
  Id id = Isar.autoIncrement;

  late int surahNumber;
  late String arabName;
  late String surahName;

  late int ayatNumber;

  DateTime createdAt = DateTime.now();
}