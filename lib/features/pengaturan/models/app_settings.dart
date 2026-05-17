import 'package:isar/isar.dart';

part 'app_settings.g.dart';

@collection
class AppSettings {
  Id id = 0;

  int qariSelected = 4;
  int fontSelected = 0;
  int modeSelected = 0;
  int colorSelected = 0;

  int customColor = 0xFF2EC4B6;
}