import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/lokasi/data/location_cache.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService {
  static Future<List<String>> getProvinces() async {
    final client = Get.find<DioClient>();
    final result = await client.get('/shalat/provinsi');

    return result.when(
      success: (response) {
        final data = response.data['data'];
        if (data == null || data is! List) {
          throw const FormatException('Invalid response format');
        }
        return data.map((e) => e.toString()).toList();
      },
      failure: (message, statusCode) {
        throw Exception(message);
      },
    );
  }

  static Future<List<String>> getCities(String province) async {
    final client = Get.find<DioClient>();
    final result = await client.post('/shalat/kabkota', data: {
      'provinsi': province,
    });

    return result.when(
      success: (response) {
        final data = response.data['data'];
        if (data == null || data is! List) {
          throw const FormatException('Invalid response format');
        }
        return data.map((e) => e.toString()).toList();
      },
      failure: (message, statusCode) {
        throw Exception(message);
      },
    );
  }

    static Future<void> saveLocation(String province, String city) async {
    final data = LocationCache()
    ..province = province
    ..city = city
    ..updatedAt = DateTime.now();

    await HiveService.locationBox.clear();
    await HiveService.locationBox.add(data);
  }

  static Future<LocationCache?> getLocation() async {
    return HiveService.locationBox.values.firstOrNull;
  }


  static Future<Position> getCurrentPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception("GPS tidak aktif");
  }

  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception("Permission GPS ditolak permanen");
  }

  final position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  if (position.accuracy > 0 && position.accuracy > 500) {
    throw Exception(
      "Akurasi GPS rendah (${position.accuracy.toStringAsFixed(0)}m). "
      "Coba di luar ruangan.",
    );
  }

  return position;
}

static Future<Map<String, String?>> getAddressFromPosition(
  Position pos,
) async {
  final placemarks = await placemarkFromCoordinates(
    pos.latitude,
    pos.longitude,
  );

  if (placemarks.isEmpty) {
    throw Exception("Tidak bisa membaca lokasi");
  }

  final place = placemarks.first;

  return {
    "province": place.administrativeArea,
    "city": place.locality ?? place.subAdministrativeArea,
  };
}

static Future<LocationCache> detectAndSaveLocation() async {
  // 1. GPS
  final position = await getCurrentPosition();

  // 2. Reverse geocode
  final address = await getAddressFromPosition(position);

final detectedProvince =
    normalizeProvince(address["province"] ?? "");
final detectedCity =
    normalizeCity(address["city"] ?? "");

  // 3. Ambil list dari API
  final provinces = await getProvinces();

  final matchedProvince = _match(detectedProvince, provinces);

  if (matchedProvince == null) {
    throw Exception("Provinsi tidak ditemukan di sistem");
  }

  final cities = await getCities(matchedProvince);

  String matchedCity =
      _match(detectedCity ?? "", cities) ??
      cities.firstWhere(
        (c) => !c.toLowerCase().startsWith("kab"),
        orElse: () => cities.first,
      );

  // Heuristic: jika DKI Jakarta tapi geocode balikin Kepulauan Seribu
  // override ke Kota Jakarta (GPS sering meleset ke area administrasi itu)
  if (matchedProvince == "DKI Jakarta" && matchedCity != "Kota Jakarta") {
    final kota = cities.where((c) => c == "Kota Jakarta");
    if (kota.isNotEmpty) matchedCity = "Kota Jakarta";
  }

  // 4. Save ke Hive
  final cache = LocationCache()
    ..province = matchedProvince
    ..city = matchedCity
    ..updatedAt = DateTime.now();

  await HiveService.locationBox.clear();
  await HiveService.locationBox.add(cache);

  return cache;
}

static String normalizeProvince(String province) {
  final aliases = {
    "daerah khusus ibukota jakarta": "DKI Jakarta",
    "daerah istimewa yogyakarta": "D.I. Yogyakarta",
    "bangka belitung islands": "Kepulauan Bangka Belitung",
    "riau islands": "Kepulauan Riau",
  };

  return aliases[province.toLowerCase()] ?? province;
}

static String normalizeCity(String city) {
  final lower = city.toLowerCase();

  if (lower.contains("jakarta")) {
    return "Kota Jakarta";
  }

  return city;
}

static String? _match(String input, List<String> list) {
  final normalizedInput = input
      .toLowerCase()
      .replaceAll("kabupaten", "")
      .replaceAll("kab.", "")
      .replaceAll("kota", "")
      .trim();

  for (final item in list) {
    final normalizedItem = item
        .toLowerCase()
        .replaceAll("kabupaten", "")
        .replaceAll("kab.", "")
        .replaceAll("kota", "")
        .trim();

    if (normalizedItem == normalizedInput ||
        normalizedItem.contains(normalizedInput) ||
        normalizedInput.contains(normalizedItem)) {
      return item;
    }
  }

  return null;
}
}
