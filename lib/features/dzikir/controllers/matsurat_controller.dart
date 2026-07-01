import 'dart:convert';
import 'dart:io';

import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/core/services/ukuran_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vibration/vibration.dart';

class MatsuratController extends GetxController {
  final String type;

  MatsuratController({required this.type});

  final _ukuran = Get.find<UkuranController>();
  final _box = GetStorage();
  String get _cacheKey => 'dzikir_matsurat_$type';

  final data = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;
  final error = RxString('');
  final hitungList = <int>[].obs;
  final currentIndex = 0.obs;

  RxDouble get ukuranTeksArab => _ukuran.ukuranTeksArab;
  RxDouble get ukuranLatinTerjemah => _ukuran.ukuranLatinTerjemah;
  RxBool get latin => _ukuran.latin;
  RxBool get terjemah => _ukuran.terjemah;
  RxBool get getar => _ukuran.getar;
  RxBool get tasbih => _ukuran.tasbih;

  String get title {
    switch (type) {
      case 'pagi_sugro':
        return 'Dzikir Pagi Sugro';
      case 'petang_sugro':
        return 'Dzikir Petang Sugro';
      case 'pagi_kubro':
        return 'Dzikir Pagi Kubro';
      case 'petang_kubro':
        return 'Dzikir Petang Kubro';
      default:
        return 'Dzikir';
    }
  }

  String get _url {
    switch (type) {
      case 'pagi_sugro':
        return ApiEndpoints.dzikirPagiSugro;
      case 'petang_sugro':
        return ApiEndpoints.dzikirPetangSugro;
      case 'pagi_kubro':
        return ApiEndpoints.dzikirPagiKubro;
      case 'petang_kubro':
        return ApiEndpoints.dzikirPetangKubro;
      default:
        return ApiEndpoints.dzikirPagiSugro;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadCache();
    fetchData();
  }

  void _loadCache() {
    final cached = _box.read<String>(_cacheKey);
    if (cached != null && cached.isNotEmpty) {
      final List<dynamic> jsonList = json.decode(cached);
      data.value = jsonList.cast<Map<String, dynamic>>();
      hitungList.value = List.filled(data.length, 0);
      currentIndex.value = 0;
      isLoading.value = false;
    }
  }

  void _saveCache() {
    _box.write(_cacheKey, json.encode(data));
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      error.value = '';
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        data.value = jsonList.cast<Map<String, dynamic>>();
        hitungList.value = List.filled(data.length, 0);
        currentIndex.value = 0;
        _saveCache();
      } else if (data.isEmpty) {
        error.value = 'Gagal memuat data (${response.statusCode})';
      }
    } catch (e) {
      if (data.isEmpty) {
        if (e is SocketException || e is HttpException) {
          error.value = 'Periksa Koneksi Jaringan Anda';
        } else if (e is FormatException) {
          error.value = 'Data yang diterima tidak valid';
        } else {
          error.value = 'Terjadi kesalahan: $e';
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  void onTasbihTap(List<GlobalKey> cardKeys) {
    if (currentIndex.value >= data.length) return;
    final jumlah = data[currentIndex.value]["jumlah"] as int;
    if (hitungList[currentIndex.value] < jumlah) {
      _vibrate();
      hitungList[currentIndex.value]++;
      if (hitungList[currentIndex.value] >= jumlah &&
          currentIndex.value < data.length - 1) {
        final nextIndex = currentIndex.value + 1;
        currentIndex.value = nextIndex;
        scrollToCard(nextIndex, cardKeys);
      }
    }
  }

  Future<void> _vibrate() async {
    if (getar.value && (await Vibration.hasVibrator() == true)) {
      Vibration.vibrate(duration: 100);
    }
  }

  void onCardTap(int index, List<GlobalKey> cardKeys) {
    if (index != currentIndex.value) return;
    _vibrate();
    onTasbihTap(cardKeys);
  }

  void scrollToCard(int index, List<GlobalKey> cardKeys) {
    if (index >= cardKeys.length) return;
    final context = cardKeys[index].currentContext;
    if (context != null) {
      final cardBox = context.findRenderObject() as RenderBox;
      final scrollableState = Scrollable.of(context);
      final viewport = scrollableState.context.findRenderObject() as RenderBox;
      final cardInViewport = cardBox.localToGlobal(
        Offset.zero,
        ancestor: viewport,
      );
      final appBarHeight =
          MediaQuery.of(context).padding.top + kToolbarHeight + 16;
      final targetOffset =
          scrollableState.position.pixels + cardInViewport.dy - appBarHeight;
      scrollableState.position.animateTo(
        targetOffset.clamp(
          scrollableState.position.minScrollExtent,
          scrollableState.position.maxScrollExtent,
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubic,
      );
    }
  }
}
