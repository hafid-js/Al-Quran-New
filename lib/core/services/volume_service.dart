import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class VolumeService {
  static const _channel = MethodChannel('com.hafidtech.alquran/volume');

  static Future<void> setMediaVolume(double fraction) async {
    try {
      await _channel.invokeMethod('setMediaVolume', {'fraction': fraction});
    } catch (e) {
      debugPrint('VolumeService error: $e');
    }
  }
}
