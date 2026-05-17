import 'package:alquran_new/features/bookmark/models/bookmark_model.dart';
import 'package:alquran_new/features/pengaturan/models/app_settings.dart';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();

      isar = await Isar.open(
        [
          BookmarkModelSchema,
          AppSettingsSchema,
        ],
        directory: dir.path,
      );
    } else {
      isar = Isar.getInstance()!;
    }
  }
}