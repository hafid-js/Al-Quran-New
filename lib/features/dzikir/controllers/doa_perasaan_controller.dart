import 'dart:convert';
import 'dart:io';

import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/features/dzikir/models/doa_perasaan_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DoaPerasaanController extends GetxController {
  final String type;

  DoaPerasaanController({required this.type});

  var data = <DoaPerasaanModel>[].obs;
  final isLoading = true.obs;
  final error = RxString('');
  final hitungList = <int>[].obs;
  final currentIndex = 0.obs;

  final ukuranTeksArab = 18.0.obs;
  final ukuranLatinTerjemah = 14.0.obs;
  final latin = true.obs;
  final terjemah = true.obs;
  final getar = true.obs;
  final tasbih = true.obs;

  String get title {
    switch (type) {
      case 'marah':
        return 'Doa Saat Marah';
      case 'cemas_gelisah':
        return 'Doa Saat Cemas/Gelisah';
      case 'bosan':
        return 'Doa Saat Bosan';
      case 'percaya_diri':
        return 'Doa Saat Percaya Diri';
      case 'bingung':
        return 'Doa Saat Bingung';
      case 'puas_tenang':
        return 'Doa Saat Puas/Tenang';
      case 'depresi_sedih_mendalam':
        return 'Doa Saat Depresi/Sedih Mendalam';
      case 'ragu_ragu':
        return 'Doa Saat Ragu-Ragu';
      case 'bersyukur':
        return 'Doa Saat Bersyukur';
      case 'serakah_tamak':
        return 'Doa Saat Serakah/Tamak';
      default:
        return 'Doa Perasaan';
    }
  }

  String get _url {
    switch (type) {
      case 'marah':
        return ApiEndpoints.doaSaatMarah;
      case 'cemas_gelisah':
        return ApiEndpoints.doaSaatGelisah;
      case 'bosan':
        return ApiEndpoints.doaSaatBosan;
      case 'percaya_diri':
        return ApiEndpoints.doaSaatPercayaDiri;
      case 'bingung':
        return ApiEndpoints.doaSaatBingung;
      case 'puas_tenang':
        return ApiEndpoints.doaSaatPuasTenang;
      case 'depresi_sedih_mendalam':
        return ApiEndpoints.doaSaatDepresi;
      case 'ragu_ragu':
        return ApiEndpoints.doaSaatRagu;
      case 'bersyukur':
        return ApiEndpoints.doaSaatBersyukur;
      case 'serakah_tamak':
        return ApiEndpoints.doaSaatSerakah;
      default:
        return ApiEndpoints.doaSaatMarah;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      error.value = '';
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        print("STATUS: ${response.statusCode}");
print("BODY: ${response.body}");
       final List<dynamic> jsonList = json.decode(response.body);
        data.value = jsonList.map((e) => DoaPerasaanModel.fromJson(e)).toList();
        hitungList.value = List.filled(data.length, 0);
        currentIndex.value = 0;
      } else {
        error.value = 'Gagal memuat data (${response.statusCode})';
      }
    } catch (e) {
      if (e is SocketException || e is HttpException) {
        error.value = 'Periksa Koneksi Jaringan Anda';
      } else if (e is FormatException) {
        error.value = 'Data yang diterima tidak valid';
      } else {
        error.value = 'Terjadi kesalahan: $e';
      }
    } finally {
      isLoading.value = false;
    }
  }
}
