import 'dart:convert';

import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/core/db/isar_service.dart';
import 'package:alquran_new/features/lokasi/data/location_cache.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';

class LocationService {
  static Future<List<String>> getProvinces() async {
    final res = await http.get(Uri.parse(ApiEndpoints.provinsiUrl));

    if (res.statusCode != 200) {
      throw Exception("Failed request: ${res.statusCode}");
    }

    final json = jsonDecode(res.body);
    final data = json['data'];

    if (data == null || data is! List) {
      throw Exception("Invalid response format");
    }

    return data.map((e) => e.toString()).toList();
  }

  static Future<List<String>> getCities(String province) async {
    final res = await http.post(
      Uri.parse(ApiEndpoints.kabkotaUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"provinsi": province}),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed request: ${res.statusCode}");
    }

    final json = jsonDecode(res.body);
    final data = json['data'];

    if (data == null || data is! List) {
      throw Exception("Invalid response format");
    }

    return data.map((e) => e.toString()).toList();
  }

    static Future<void> saveLocation(String province, String city) async {
    final data = LocationCache()
    ..province = province
    ..city = city
    ..updatedAt = DateTime.now();

    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.locationCaches.clear();
      await IsarService.isar.locationCaches.put(data);
    });
  }

  static Future<LocationCache?> getLocation() async {
    return await IsarService.isar.locationCaches.where().findFirst();
  }
}
