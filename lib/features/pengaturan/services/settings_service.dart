import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/features/pengaturan/models/app_settings.dart';

class SettingsService {
  Future<AppSettings> getSettings() async {
    final data = HiveService.settingsBox.get(0);

    if(data != null) return data;

    final settings = AppSettings();
    await HiveService.settingsBox.put(0, settings);

    return settings;
  }

  Future<void> save(AppSettings settings) async {
    await HiveService.settingsBox.put(0, settings);
  }
}
