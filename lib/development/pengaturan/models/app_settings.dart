import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 1)
class AppSettings extends HiveObject {
  @HiveField(0)
  int qariSelected = 4;
  @HiveField(1)
  int fontSelected = 0;
  @HiveField(2)
  int modeSelected = 0;
  @HiveField(3)
  int colorSelected = 0;
  @HiveField(4)
  int customColor = 0xFF2EC4B6;
}
