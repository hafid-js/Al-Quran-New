import 'dart:io';

import 'package:flutter/services.dart';

class AdzanSchedulerService {
  static const _channel = MethodChannel('com.hafidtech.alquran/adzan');
  static const _navigateChannel = MethodChannel('com.hafidtech.alquran/navigate');

  static bool get _isAndroid => Platform.isAndroid;

  static Future<void> scheduleAlarm({
    required int prayerId,
    required DateTime dateTime,
    required int notificationMode,
    required String soundType,
  }) async {
    if (!_isAndroid) return;
    try {
      await _channel.invokeMethod('scheduleAlarm', {
        'prayerId': prayerId,
        'timestampMillis': dateTime.millisecondsSinceEpoch,
        'notificationMode': notificationMode,
        'soundType': soundType,
      });
    } on MissingPluginException {
      // ignore on iOS
    }
  }

  static Future<void> cancelAlarm(int prayerId) async {
    if (!_isAndroid) return;
    try {
      await _channel.invokeMethod('cancelAlarm', {'prayerId': prayerId});
    } on MissingPluginException {
      // ignore on iOS
    }
  }

  static Future<void> cancelAllAlarms() async {
    if (!_isAndroid) return;
    try {
      await _channel.invokeMethod('cancelAllAlarms');
    } on MissingPluginException {
      // ignore on iOS
    }
  }

  static Future<void> stopAdzan() async {
    if (!_isAndroid) return;
    try {
      await _channel.invokeMethod('stopAdzan');
    } on MissingPluginException {
      // ignore on iOS
    }
  }

  static Future<void> playAdzan() async {
    if (!_isAndroid) return;
    try {
      await _channel.invokeMethod('playAdzan');
    } on MissingPluginException {
      // ignore on iOS
    }
  }

  static Future<bool> isAdzanPlaying() async {
    if (!_isAndroid) return false;
    try {
      final result = await _channel.invokeMethod<bool>('isAdzanPlaying');
      return result ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<bool> checkNavigateIntent() async {
    if (!_isAndroid) return false;
    try {
      final result = await _navigateChannel.invokeMethod<bool>('checkNavigateIntent');
      return result ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<void> consumeNavigateIntent() async {
    if (!_isAndroid) return;
    try {
      await _navigateChannel.invokeMethod('consumeNavigateIntent');
    } on MissingPluginException {
      // ignore
    }
  }
}
