import 'dart:convert';

import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MatsuratController extends GetxController {
  final String type;

  MatsuratController({required this.type});

  final data = <Map<String, dynamic>>[].obs;
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
    fetchData();
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
      } else {
        error.value = 'Gagal memuat data (${response.statusCode})';
      }
    } catch (e) {
      error.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void onTasbihTap(List<GlobalKey> cardKeys) {
    if (currentIndex.value >= data.length) return;
    final jumlah = data[currentIndex.value]["jumlah"] as int;
    if (hitungList[currentIndex.value] < jumlah) {
      hitungList[currentIndex.value]++;
      if (hitungList[currentIndex.value] >= jumlah &&
          currentIndex.value < data.length - 1) {
        final nextIndex = currentIndex.value + 1;
        currentIndex.value = nextIndex;
        scrollToCard(nextIndex, cardKeys);
      }
    }
  }

  void onCardTap(int index, List<GlobalKey> cardKeys) {
    if (index != currentIndex.value) return;
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
