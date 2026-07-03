
import 'package:flutter/foundation.dart';
import 'package:alquran_new/features/lokasi/services/location_service.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var provinces = <String>[].obs;
  var cities = <String>[].obs;

  var selectedProvince = RxnString();
  var selectedCity = RxnString();

  var isLoadingProvince = false.obs;
  var isLoadingCity = false.obs;

  var isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedLocation();
    fetchProvinces();
  }

  Future<void> fetchProvinces() async {
    isLoadingProvince.value = true;

    try {
      provinces.value = await LocationService.getProvinces();
    } catch (e) {
      debugPrint('fetchProvinces error: $e');
    } finally {
      isLoadingProvince.value = false;
    }
  }

  Future<void> fetchCities(String province) async {
    isLoadingCity.value = true;

    try {
      final data = await LocationService.getCities(province);
      cities.value = data;
    } catch (e) {
      debugPrint('fetchCities error: $e');
      cities.clear();
    } finally {
      isLoadingCity.value = false;
    }
  }

  void selectProvince(String value) {
    selectedProvince.value = value;
    selectedCity.value = null;
    cities.clear();
    fetchCities(value);
  }

  void selectCity(String value) {
    selectedCity.value = value;
  }

  Future<void> loadSavedLocation() async {
  final location = await LocationService.getLocation();

  if (location != null) {
    selectedProvince.value = location.province;
    await fetchCities(location.province);
    selectedCity.value = location.city;
  }
  }

}
