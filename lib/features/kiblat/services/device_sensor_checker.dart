import 'package:flutter/services.dart';

class DeviceSensorChecker {
  static const _channel = MethodChannel('com.hafidtech.alquran/sensors');

  static Future<bool> hasMagnetometer() async {
    try {
      return await _channel.invokeMethod('hasMagnetometer') ?? true;
    } catch (_) {
      return true;
    }
  }
}
