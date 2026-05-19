import 'dart:async';
import 'dart:math';
import 'package:alquran_new/features/kiblat/services/qibla_calculator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class KiblatController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var heading = 0.0.obs;
  var qiblaDirection = 0.0.obs;
  var qiblaDistance = 0.0.obs;
  var isLoading = true.obs;
  var hasPermission = false.obs;
  var errorMessage = ''.obs;
  var locationName = ''.obs;

  StreamSubscription? _headingSubscription;
  StreamSubscription? _positionSubscription;

  @override
  void onClose() {
    _headingSubscription?.cancel();
    _positionSubscription?.cancel();
    super.onClose();
  }

  Future<void> requestPermissionsAndLocate() async {
    isLoading.value = true;
    errorMessage.value = '';

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requested = await Geolocator.requestPermission();
      if (requested == LocationPermission.denied) {
        errorMessage.value = 'Izin lokasi diperlukan untuk fitur kiblat';
        isLoading.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      errorMessage.value = 'Izin lokasi ditolak permanen. Aktifkan di pengaturan.';
      isLoading.value = false;
      return;
    }

    hasPermission.value = true;
    await getCurrentLocation();
    startCompass();
  }

  Future<void> getCurrentLocation() async {
    try {
      _positionSubscription?.cancel();
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
      ).listen((Position position) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
        calculateQibla();
        isLoading.value = false;
      });

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      calculateQibla();
      isLoading.value = false;
    } catch (e) {
      errorMessage.value = 'Gagal mendapatkan lokasi: ${e.toString()}';
      isLoading.value = false;
    }
  }

  void startCompass() {
    try {
      _headingSubscription?.cancel();
      _headingSubscription = magnetometerEventStream(
        samplingPeriod: const Duration(milliseconds: 100),
      ).listen(
        (MagnetometerEvent event) {
          double h = atan2(event.y, event.x) * 180 / pi;
          if (h < 0) h += 360;
          heading.value = h;
        },
        onError: (Object e) {
          errorMessage.value = 'Kompass tidak tersedia di perangkat ini';
        },
      );
    } catch (e) {
      errorMessage.value = 'Kompass tidak tersedia di perangkat ini';
    }
  }

  void calculateQibla() {
    qiblaDirection.value = QiblaCalculator.calculateDirection(
      latitude.value,
      longitude.value,
    );
    qiblaDistance.value = QiblaCalculator.calculateDistance(
      latitude.value,
      longitude.value,
    );
  }

  double get qiblaAngleFromHeading =>
      (qiblaDirection.value - heading.value + 360) % 360;

  String get qiblaDirectionName =>
      QiblaCalculator.getDirectionName(qiblaDirection.value);

  String get headingDirectionName =>
      QiblaCalculator.getDirectionName(heading.value);

  String get qiblaDistanceText {
    final d = qiblaDistance.value;
    if (d >= 1000) {
      return '${(d / 1000).toStringAsFixed(1)} rb km';
    }
    return '${d.toStringAsFixed(0)} km';
  }
}
