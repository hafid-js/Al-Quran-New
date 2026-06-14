import 'dart:async';
import 'package:alquran_new/features/kiblat/services/device_sensor_checker.dart';
import 'package:alquran_new/features/kiblat/services/qibla_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class KiblatController extends GetxController with WidgetsBindingObserver  {
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
void onInit() {
  super.onInit();
  WidgetsBinding.instance.addObserver(this);
}

  @override
void onClose() {
  WidgetsBinding.instance.removeObserver(this);

  _headingSubscription?.cancel();
  _positionSubscription?.cancel();
  _sensorTimeout?.cancel();

  super.onClose();
}
@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  if (state == AppLifecycleState.resumed) {
    _recheckLocation();
  }
}
Future<void> _recheckLocation() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  final permission = await Geolocator.checkPermission();

  if (serviceEnabled &&
      (permission == LocationPermission.whileInUse ||
       permission == LocationPermission.always)) {

    hasPermission.value = true;
    isDeniedForever.value = false;
    errorMessage.value = '';

    await getCurrentLocation();
  }
}
  Future<void> requestPermissionsAndLocate() async {
    isLoading.value = true;
    errorMessage.value = '';

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      errorMessage.value = 'GPS belum aktif';
      isLoading.value = false;
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission perm = await Geolocator.checkPermission();

    if (perm == LocationPermission.deniedForever) {
      isDeniedForever.value = true;
      isLoading.value = false;
      await _showDeniedForeverDialog();
      return;
    }

    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }

    if (perm == LocationPermission.denied || perm == LocationPermission.deniedForever) {
      if (perm == LocationPermission.deniedForever) {
        isDeniedForever.value = true;
      } else {
        errorMessage.value = 'Izin lokasi ditolak';
      }
      isLoading.value = false;
      return;
    }

    hasPermission.value = true;

    await _startCompass();
    await getCurrentLocation();

    isLoading.value = false;
  }

  Future<void> _showDeniedForeverDialog() async {
    await Get.dialog(
      AlertDialog(
        title: const Text('Izin Lokasi Dinonaktifkan'),
        content: const Text(
          'Akses lokasi diperlukan untuk menentukan arah kiblat. '
          'Izin lokasi telah ditolak permanen. '
          'Silakan buka pengaturan untuk mengaktifkannya.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Geolocator.openAppSettings();
            },
            child: const Text('Buka Pengaturan'),
          ),
        ],
      ),
    );
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
