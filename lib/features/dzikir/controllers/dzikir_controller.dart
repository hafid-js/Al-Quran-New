import 'dart:convert';
import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/dzikir/models/dzikir_item.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DzikirController extends GetxController {
  final DioClient _client = Get.find();

  var dzikirList = <DzikirItem>[].obs;
  var isLoading = true.obs;
  var errorMessage = RxString('');

  @override
  void onInit() {
    super.onInit();
    fetchDzikir();
  }

  Future<void> fetchDzikir() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _client.get(
        ApiEndpoints.dzikir,
        customBaseUrl: ApiEndpoints.dzikirBaseUrl,
        responseType: ResponseType.plain,
      );

      result.when(
        success: (response) {
          final List<dynamic> data =
              json.decode(response.data as String) as List<dynamic>;
          dzikirList.value = data
              .map((e) =>
                  DzikirItem.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        failure: (message, statusCode) {
          errorMessage.value = message;
        },
      );
    } on FormatException {
      errorMessage.value = 'Data yang diterima tidak valid';
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
