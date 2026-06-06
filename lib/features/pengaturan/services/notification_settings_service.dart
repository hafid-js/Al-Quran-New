import 'package:alquran_new/features/pengaturan/models/notification_settings.dart';
import 'package:hive/hive.dart';

class NotificationSettingsService {

  
  final box = Hive.box<NotificationSettings>(
    'notification_settings',
  );

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