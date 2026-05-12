import 'dart:async';
import 'dart:math';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class KiblatController extends GetxController {
  var heading = 0.0.obs;
  var qiblaDirection = 0.0.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = true.obs;
  var errorMessage = RxnString();
  var compassAvailable = true.obs;

  static const double kaabaLat = 21.4225;
  static const double kaabaLon = 39.8262;

  StreamSubscription? _compassSubscription;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await _requestLocation();
    _initCompass();
  }

  Future<void> _requestLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        errorMessage.value = "Lokasi tidak aktif. Aktifkan GPS untuk akurasi arah kiblat.";
        isLoading.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          errorMessage.value = "Izin lokasi ditolak.";
          isLoading.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        errorMessage.value = "Izin lokasi ditolak permanen. Aktifkan dari pengaturan.";
        isLoading.value = false;
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;
      calculateQibla();
      isLoading.value = false;
    } catch (e) {
      errorMessage.value = "Gagal mendapatkan lokasi: $e";
      isLoading.value = false;
    }
  }

  void _initCompass() {
    try {
      _compassSubscription = FlutterCompass.events?.listen((event) {
        if (event.heading != null) {
          heading.value = event.heading!;
          if (compassAvailable.value == false) {
            compassAvailable.value = true;
          }
        }
      });

      if (_compassSubscription == null) {
        compassAvailable.value = false;
      }
    } catch (e) {
      compassAvailable.value = false;
    }
  }

  void calculateQibla() {
    qiblaDirection.value = _calculateBearing(
      latitude.value,
      longitude.value,
      kaabaLat,
      kaabaLon,
    );
  }

  double _calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    double radLat1 = lat1 * pi / 180;
    double radLon1 = lon1 * pi / 180;
    double radLat2 = lat2 * pi / 180;
    double radLon2 = lon2 * pi / 180;

    double dLon = radLon2 - radLon1;

    double x = sin(dLon) * cos(radLat2);
    double y = cos(radLat1) * sin(radLat2) - sin(radLat1) * cos(radLat2) * cos(dLon);

    double bearing = atan2(x, y) * 180 / pi;
    return (bearing + 360) % 360;
  }

  double get qiblaOffset {
    double offset = qiblaDirection.value - heading.value;
    return (offset + 360) % 360;
  }

  void refreshLocation() {
    isLoading.value = true;
    errorMessage.value = null;
    _requestLocation();
  }

  @override
  void onClose() {
    _compassSubscription?.cancel();
    super.onClose();
  }
}
