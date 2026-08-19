import 'package:alquran_new/development/core/db/hive_service.dart';
import 'package:alquran_new/development/pengaturan/models/app_settings.dart';

class SettingsService {
  Future<AppSettings> getSettings() async {
    final box = DevHiveService.settingsBox;

    if (!box.isOpen) {
      throw Exception("Settings box belum dibuka");
    }

    final data = box.get(0);

    if (data is AppSettings) return data;

    final settings = AppSettings();
    await box.put(0, settings);

    return settings;
  }

  Future<void> save(AppSettings settings) async {
    await DevHiveService.settingsBox.put(0, settings);
  }
}