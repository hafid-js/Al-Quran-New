import 'dart:async';
import 'package:alquran_new/features/kiblat/services/device_sensor_checker.dart';
import 'package:alquran_new/features/kiblat/services/qibla_calculator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

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
  var isDeniedForever = false.obs;
  var compassAvailable = true.obs;
  var hasHeadingData = false.obs;
  var deviceHasCompassSensor = true.obs;

  StreamSubscription? _headingSubscription;
  StreamSubscription? _positionSubscription;
  Timer? _sensorTimeout;
  bool _hasCompassData = false;

  @override
  void onClose() {
    _headingSubscription?.cancel();
    _positionSubscription?.cancel();
    _sensorTimeout?.cancel();
    super.onClose();
  }

  Future<void> requestPermissionsAndLocate() async {
    isLoading.value = true;
    errorMessage.value = '';
    isDeniedForever.value = false;

    final hasSensor = await DeviceSensorChecker.hasMagnetometer();

    if (!hasSensor || FlutterCompass.events == null) {
      deviceHasCompassSensor.value = false;
      compassAvailable.value = false;
      isLoading.value = false;
      return;
    }

    deviceHasCompassSensor.value = true;

    final locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationEnabled) {
      errorMessage.value = 'Aktifkan lokasi di pengaturan untuk fitur kiblat';
      isLoading.value = false;
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        errorMessage.value = 'Izin lokasi diperlukan untuk fitur kiblat';
        isLoading.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isDeniedForever.value = true;
      errorMessage.value =
          'Izin lokasi ditolak permanen. Ketuk "Buka Pengaturan" untuk mengaktifkan.';
      isLoading.value = false;
      return;
    }

    hasPermission.value = true;
    await _startCompass();

    try {
      await getCurrentLocation().timeout(const Duration(seconds: 20));
    } on TimeoutException {
      errorMessage.value = 'Gagal mendapatkan lokasi: waktu habis';
      isLoading.value = false;
    }
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  Future<void> getCurrentLocation() async {
    try {
      _positionSubscription?.cancel();
      _positionSubscription =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 100,
            ),
          ).listen((Position position) {
            latitude.value = position.latitude;
            longitude.value = position.longitude;
            calculateQibla();
            if (isLoading.value) isLoading.value = false;
          });

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      calculateQibla();
      if (isLoading.value) isLoading.value = false;
    } catch (e) {
      errorMessage.value = 'Gagal mendapatkan lokasi: ${e.toString()}';
      isLoading.value = false;
    }
  }

  Future<void> _startCompass() async {
    _headingSubscription?.cancel();
    _sensorTimeout?.cancel();

    _hasCompassData = false;
    hasHeadingData.value = false;
    errorMessage.value = '';
    compassAvailable.value = true;

    final hasSensor = await DeviceSensorChecker.hasMagnetometer();
    if (!hasSensor) {
      compassAvailable.value = false;
      isLoading.value = false;
      return;
    }

    final stream = FlutterCompass.events;
    if (stream == null) {
      compassAvailable.value = false;
      isLoading.value = false;
      return;
    }

    _headingSubscription = stream.listen((CompassEvent event) {
      final h = event.heading;

      // print('Heading: $h');

      if (h == null || h < 0) {
        hasHeadingData.value = false;
        return;
      }
      _hasCompassData = true;
      hasHeadingData.value = true;
      heading.value = h;
    });

    _sensorTimeout = Timer(const Duration(seconds: 15), () {
      final noData = !_hasCompassData;
      final staleData = hasHeadingData.value == false;

      if (noData || staleData) {
        if (compassAvailable.value && errorMessage.value.isEmpty) {
          errorMessage.value =
              'Kompas tidak merespon. Gerakkan HP membentuk angka 8 dan jauhkan dari magnet.';
        }

        hasHeadingData.value = false;
        isLoading.value = false;
      }
    });
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
