import 'package:hive_flutter/hive_flutter.dart';

part 'notification_settings.g.dart';

@HiveType(typeId: 7)
class NotificationSettings extends HiveObject {
  @HiveField(0)
  int notificationMode;

  @HiveField(1)
  String soundType;

  @HiveField(2)
  bool imsakEnabled;

  @HiveField(3)
  bool subuhEnabled;

  @HiveField(4)
  bool dzuhurEnabled;

  @HiveField(5)
  bool asharEnabled;

  @HiveField(6)
  bool maghribEnabled;

  @HiveField(7)
  bool isyaEnabled;

  NotificationSettings({
    this.notificationMode = 0,
    this.soundType = 'adzan',
    this.imsakEnabled = true,
    this.subuhEnabled = true,
    this.dzuhurEnabled = true,
    this.asharEnabled = true,
    this.maghribEnabled = true,
    this.isyaEnabled = true,
  });
}
