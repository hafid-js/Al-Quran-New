import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/features/pengaturan/models/app_settings.dart';

class SettingsService {
  Future<AppSettings> getSettings() async {
    final box = HiveService.settingsBox;

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
    await HiveService.settingsBox.put(0, settings);
  }
}