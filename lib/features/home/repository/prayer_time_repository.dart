import 'dart:convert';

import 'package:alquran_new/features/home/models/prayer_time.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PrayerTimeRepository {
  final String baseUrl;

  PrayerTimeRepository({
    this.baseUrl = 'https://equran.id/api/v2/shalat'
  });

  Future<Map<String, dynamic>> fetchPrayerTimes({
  required String province,
  required String city,
}) async {
  final url = Uri.parse(baseUrl);

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "provinsi": province,
      "kabkota": city,
      "bulan_nama": DateFormat.MMMM('id').format(DateTime.now()), // nama bulan sekarang
      "tahun": DateTime.now().year,
    }),
  );

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    final data = decoded['data'];

    // ambil seluruh jadwal bulan ini
    final List<PrayerTime> schedules = (data['jadwal'] as List)
        .map((e) => PrayerTime.fromJson(e))
        .toList();

    // filter hanya jadwal hari ini
    final String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
   final List<PrayerTime> todaySchedule = schedules
    .where((p) => p.tanggalLengkap == todayStr)
    .toList();

    return {
      'province': data['provinsi'],
      'city': data['kabkota'],
      'schedules': todaySchedule,
    };
  } else {
    throw Exception('Failed fetch prayer times: ${response.statusCode}');
  }
}
}

// class PrayerTimeRepository {
//   final String baseUrl;

//   PrayerTimeRepository({
//     this.baseUrl = 'https://equran.id/api/v2/shalat'
//   });

//   Future<Map<String, dynamic>> fetchPrayerTimes({
//   required String province,
//   required String city,
// }) async {
//   final url = Uri.parse(baseUrl);

//   final response = await http.post(
//     url,
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({
//       "provinsi": province,
//       "kabkota": city,
//       "bulan_nama": DateFormat.MMMM('id').format(DateTime.now()), // nama bulan sekarang
//       "tahun": DateTime.now().year,
//     }),
//   );

//   if (response.statusCode == 200) {
//     final decoded = jsonDecode(response.body);
//     final data = decoded['data'];

//     // ambil seluruh jadwal bulan ini
//     final List<PrayerTime> schedules = (data['jadwal'] as List)
//         .map((e) => PrayerTime.fromJson(e))
//         .toList();

//     // filter hanya jadwal hari ini
//     final String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
//    final List<PrayerTime> todaySchedule = schedules
//     .where((p) => p.tanggalLengkap == todayStr)
//     .toList();
    

//     return {
//       'province': data['provinsi'],
//       'city': data['kabkota'],
//       'schedules': todaySchedule,
//     };
//   } else {
//     throw Exception('Failed fetch prayer times: ${response.statusCode}');
//   }
// }
// }