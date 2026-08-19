import 'package:alquran_new/development/core/db/hive_service.dart';
import 'package:alquran_new/development/pengaturan/models/notification_settings.dart';

class NotificationSettingsService {

  final box = DevHiveService.notificationBox;

  Future<NotificationSettings> getSettings() async {
    return box.get(
      'notification',
      defaultValue: NotificationSettings(),
    )!;
  }

  Future<void> save(NotificationSettings settings) async {
    await box.put('notification', settings);
  }

  
}