import 'dart:async';
import 'package:alquran_new/features/kiblat/services/qibla_calculator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class KiblatController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var qiblaDirection = 0.0.obs;
  var qiblaDistance = 0.0.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  StreamSubscription? _positionSubscription;

  @override
  void onInit() {
    super.onInit();
    startLocation();
  }

  @override
  void onClose() {
    _positionSubscription?.cancel();
    super.onClose();
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  void startLocation() {
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      _positionSubscription?.cancel();

      final perm = await Geolocator.checkPermission();
      if (perm != LocationPermission.whileInUse &&
          perm != LocationPermission.always) {
        errorMessage.value = 'Izin lokasi belum diberikan';
        isLoading.value = false;
        return;
      }

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        errorMessage.value = 'GPS belum aktif';
        isLoading.value = false;
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      _updateLocation(position);

      if (isLoading.value) isLoading.value = false;

      _positionSubscription =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 100,
            ),
          ).listen((Position position) {
            _updateLocation(position);
          });
    } catch (e) {
      errorMessage.value =
          'Gagal mendapatkan lokasi. Periksa izin lokasi dan koneksi.';
      isLoading.value = false;
    }
  }

  void _updateLocation(Position position) {
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    qiblaDirection.value =
        QiblaCalculator.calculateDirection(position.latitude, position.longitude);
    qiblaDistance.value =
        QiblaCalculator.calculateDistance(position.latitude, position.longitude);
  }

  String get qiblaDirectionName =>
      QiblaCalculator.getDirectionName(qiblaDirection.value);

  String get qiblaDistanceText {
    final d = qiblaDistance.value;
    if (d >= 1000) {
      return '${(d / 1000).toStringAsFixed(1)} rb km';
    }
    return '${d.toStringAsFixed(0)} km';
  }
}
