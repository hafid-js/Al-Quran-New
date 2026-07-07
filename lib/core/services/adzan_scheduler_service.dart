import 'dart:io';

import 'package:flutter/services.dart';

class AdzanSchedulerService {
  static const _channel = MethodChannel('com.hafidtech.alquran/adzan');

  static bool get _isAndroid => Platform.isAndroid;

  static Future<void> scheduleAlarm({
    required int prayerId,
    required DateTime dateTime,
  }) async {
    if (!_isAndroid) return;
    try {
      await _channel.invokeMethod('scheduleAlarm', {
        'prayerId': prayerId,
        'timestampMillis': dateTime.millisecondsSinceEpoch,
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

  static Future<bool> isAdzanPlaying() async {
    if (!_isAndroid) return false;
    try {
      final result = await _channel.invokeMethod<bool>('isAdzanPlaying');
      return result ?? false;
    } on MissingPluginException {
      return false;
    }
  }
}
