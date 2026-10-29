import 'package:alquran_new/development/home/controllers/prayer_time_controller.dart';
import 'package:alquran_new/development/masjid_terdekat/domain/entities/masjid.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

final List<Map<String, dynamic>> fontArabs = [
  {"title": "Amiri Quran"},
  {"title": "LPMQ Isep Misbah"},
  {"title": "Spectral"},
  {"title": "Uthmanic"},
];

String formatRupiah(int nominal) {
  final s = nominal.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    buffer.write(s[i]);
    final remaining = s.length - i - 1;
    if (remaining > 0 && remaining % 3 == 0) buffer.write('.');
  }
  return 'Rp $buffer';
}

Map<String, dynamic> calculateIqamahStatus(
  Masjid masjid,
  Position userPos,
  PrayerTimeController controller,
) {
  final double distanceInMeters = Geolocator.distanceBetween(
    userPos.latitude,
    userPos.longitude,
    masjid.latitude,
    masjid.longitude,
  );

  final int etaMinutes = ((distanceInMeters / 400) + 2).ceil();

  final DateTime now = DateTime.now();
  final DateTime arrivalTime = now.add(Duration(minutes: etaMinutes));

  final prayer = controller.todayPrayer.value;

  Map<String, dynamic> unavailable(String message) {
    return {
      'available': false,
      'message': message,
      'prayerName': '-',
      'etaMinutes': etaMinutes,
      'distanceKm': (distanceInMeters / 1000).toStringAsFixed(1),
      'isLate': false,
      'diffMinutes': 0,
      'arrivalTime': _formatTime(arrivalTime),
      'iqamahTime': '--:--',
      'adhanTime': '--:--',
      'shouldShowWarning': false,
    };
  }

  if (prayer == null) {
    return unavailable('Jadwal salat belum tersedia.');
  }

  DateTime? parsePrayerTime(String value) {
    final match = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(value.trim());

    if (match == null) return null;

    final hour = int.tryParse(match.group(1)!);
    final minute = int.tryParse(match.group(2)!);

    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59) {
      return null;
    }

    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  final Map<String, String> prayerTimeStrings = {
    'Subuh': controller.getEffectiveTime('Subuh', prayer.subuh),
    'Dzuhur': controller.getEffectiveTime('Dzuhur', prayer.dzuhur),
    'Ashar': controller.getEffectiveTime('Ashar', prayer.ashar),
    'Maghrib': controller.getEffectiveTime('Maghrib', prayer.maghrib),
    'Isya': controller.getEffectiveTime('Isya', prayer.isya),
  };

  final List<MapEntry<String, DateTime>> schedule = [];

  for (final entry in prayerTimeStrings.entries) {
    final time = parsePrayerTime(entry.value);

    if (time == null) {
      return unavailable('Format jadwal ${entry.key} tidak valid.');
    }

    schedule.add(MapEntry(entry.key, time));
  }

  schedule.sort((a, b) => a.value.compareTo(b.value));

  const int iqamahBufferMinutes = 10;
  const int warningBeforeAdhanMinutes = 20;

  DateTime iqamahOf(DateTime adhan) =>
      adhan.add(const Duration(minutes: iqamahBufferMinutes));

  // Pilih salat yang iqamah-nya belum lewat. Ini membuat salat saat ini tetap
  // muncul ketika adzan sudah berkumandang tetapi iqamah belum tiba.
  MapEntry<String, DateTime>? target;
  String targetSuffix = '';

  for (final entry in schedule) {
    if (iqamahOf(entry.value).isAfter(now)) {
      target = entry;
      break;
    }
  }

  if (target == null) {
    final subuhToday = schedule.firstWhere((entry) => entry.key == 'Subuh');
    final tomorrow = now.add(const Duration(days: 1));

    target = MapEntry(
      'Subuh',
      DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        subuhToday.value.hour,
        subuhToday.value.minute,
      ),
    );
    targetSuffix = ' (Besok)';
  }

  final String prayerName = '${target.key}$targetSuffix';
  final DateTime adhanTime = target.value;
  final DateTime iqamahTime = iqamahOf(adhanTime);

  final DateTime warningStart = adhanTime.subtract(
    const Duration(minutes: warningBeforeAdhanMinutes),
  );

  final bool shouldShowWarning = !now.isBefore(warningStart);

  final bool isLate = arrivalTime.isAfter(iqamahTime);
  final Duration diff = arrivalTime.difference(iqamahTime);
  final int diffMinutes = diff.isNegative
      ? diff.inMinutes.abs()
      : (diff.inSeconds / 60).ceil();

  return {
    'available': true,
    'message': '',
    'prayerName': prayerName,
    'etaMinutes': etaMinutes,
    'distanceKm': (distanceInMeters / 1000).toStringAsFixed(1),
    'isLate': isLate,
    'diffMinutes': diffMinutes,
    'arrivalTime': _formatTime(arrivalTime),
    'adhanTime': _formatTime(adhanTime),
    'iqamahTime': _formatTime(iqamahTime),
    'shouldShowWarning': shouldShowWarning,
  };
}

String _formatTime(DateTime time) {
  return '${time.hour.toString().padLeft(2, '0')}:'
      '${time.minute.toString().padLeft(2, '0')}';
}
