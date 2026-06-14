import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'prayer_notification';
  static const String _channelName = 'Notifikasi Sholat';

  static const Map<String, String> _soundResources = {
    'default': 'alarmbeep',
    'adzan': 'adzansubuh',
  };

  Future<void> initialize() async {
    await _requestAndroidPermissions();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('ic_notification');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
  }

  void _onNotificationResponse(NotificationResponse response) {}

  Future<void> _requestAndroidPermissions() async {
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.requestNotificationsPermission();
  }

  String _resolveSoundResource(String? soundType) {
    if (soundType == null) return '';
    return _soundResources[soundType] ?? '';
  }

  Future<void> showNotification({
    int id = 0,
    String title = 'Notification',
    String body = 'This is a notification message',
    String? soundType,
    int notificationMode = 0,
  }) async {
    final soundResource = _resolveSoundResource(soundType);
    final isSilent = notificationMode == 3;
    final playSound = notificationMode == 0 || notificationMode == 1;
    final vibrate = notificationMode == 0 || notificationMode == 2;

    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: 'Notifikasi waktu sholat',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
          playSound: playSound,
          sound: playSound && soundResource.isNotEmpty
              ? RawResourceAndroidNotificationSound(soundResource)
              : null,
          enableVibration: vibrate,
          silent: isSilent,
        );

    final DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: !isSilent,
          presentBadge: !isSilent,
          presentSound: playSound && soundResource.isNotEmpty,
          presentBanner: !isSilent,
          sound: playSound && soundResource.isNotEmpty
              ? soundResource
              : null,
        );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }

Future<void> testAdhanSound() async {
  await _notificationsPlugin.show(
    id: 33,
    title: "TEST ADZAN",
    body: "Harusnya bunyi adzan",
    notificationDetails: const NotificationDetails(
      iOS: DarwinNotificationDetails(
        sound: 'alarmsound1.wav',
        presentSound: true,
        presentAlert: true,
      ),
      android: AndroidNotificationDetails(
        'prayer_notification',
        'Notifikasi Sholat',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('audio_default'),
        
      ),
      
    ),
    
    
  );
}

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? soundType,
    int notificationMode = 0,
  }) async {
    final soundResource = _resolveSoundResource(soundType);
    final isSilent = notificationMode == 3;
    final playSound = notificationMode == 0 || notificationMode == 1;
    final vibrate = notificationMode == 0 || notificationMode == 2;

    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: 'Notifikasi waktu sholat',
          importance: Importance.max,
          priority: Priority.high,
          playSound: playSound,
          sound: playSound && soundResource.isNotEmpty
              ? RawResourceAndroidNotificationSound(soundResource)
              : null,
          enableVibration: vibrate,
          silent: isSilent,
        );

    final DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: !isSilent,
          presentBadge: !isSilent,
          presentSound: playSound && soundResource.isNotEmpty,
          presentBanner: !isSilent,
          sound: playSound && soundResource.isNotEmpty
            ? soundResource
              : null,
        );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: notificationDetails,
     androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }

  Future<void> cancelAllNotification() async {
    await _notificationsPlugin.cancelAll();
  }
}
