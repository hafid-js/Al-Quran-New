import 'dart:async';
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
      errorMessage.value = 'Izin lokasi ditolak permanen. Ketuk "Buka Pengaturan" untuk mengaktifkan.';
      isLoading.value = false;
      return;
    }

    hasPermission.value = true;
    _startCompass();

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
      _positionSubscription = Geolocator.getPositionStream(
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

  void _startCompass() {
    _headingSubscription?.cancel();
    _sensorTimeout?.cancel();

    _hasCompassData = false;
    errorMessage.value = '';

    final stream = FlutterCompass.events;
    if (stream == null) {
      errorMessage.value = 'Kompas tidak tersedia di perangkat ini';
      isLoading.value = false;
      return;
    }

    _headingSubscription = stream.listen(
      (CompassEvent event) {
        final h = event.heading;
        if (h == null || h < 0) return;
        _hasCompassData = true;
        heading.value = h;
      },
      onError: (Object e) {
        errorMessage.value = 'Sensor kompas tidak tersedia di perangkat ini';
      },
    );

    _sensorTimeout = Timer(const Duration(seconds: 10), () {
      if (!_hasCompassData) {
        if (errorMessage.value.isEmpty) {
          errorMessage.value =
              'Kompas tidak merespon. Coba kalibrasi dengan menggerakkan perangkat membentuk angka 8.';
        }
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
