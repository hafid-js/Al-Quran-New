import 'package:alquran_new/features/pengaturan/models/app_settings.dart';
import 'package:isar/isar.dart';

class SettingsService {
  final Isar isar;

  SettingsService(this.isar);

  Future<AppSettings> getSettings() async {
    final data = await isar.appSettings.get(0);

    if(data != null) return data;

    final settings = AppSettings();

    await isar.writeTxn(() async {
      await isar.appSettings.put(settings);
    });

    return settings;
  }
  Future<void> save(AppSettings settings) async {
    await isar.writeTxn(() async {
      await isar.appSettings.put(settings);
    });
  }
}