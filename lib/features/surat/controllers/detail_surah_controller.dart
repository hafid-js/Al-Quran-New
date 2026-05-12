import 'dart:convert';

import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/features/alquran/models/detail_surah_model.dart';
import 'package:alquran_new/features/alquran/models/surah_model.dart';
import 'package:alquran_new/features/alquran/models/tafsir_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  var isLoading = false.obs;
  var detailSurah = Rxn<DetailSurah>();
  var tafsirList = <TafsirAyat>[].obs;
  var tafsirLoading = <int, bool>{}.obs;
  final player = AudioPlayer();
  Ayat? lastAyat;
  Surah? lastSurah;

  final net = Get.find<NetworkController>();


  Future<void> fetchDetailSurah(int nomor) async {
    isLoading.value = true;

    const maxRetry = 10;
    int retry = 0;


    try {
      while (!net.isConnected.value) {
        await Future.delayed(const Duration(seconds: 1));
      }

      while (retry < maxRetry) {
        try {
          final url = Uri.parse(ApiEndpoints.detailSurah(nomor));
          final res = await http.get(url).timeout(const Duration(seconds: 10));

          if (res.statusCode == 200) {
            final jsonData = json.decode(res.body);
            detailSurah.value = DetailSurah.fromJson(jsonData["data"]);
            return;
          }
        } catch (e) {
          print("Retry detail surah: $e");
        }

        retry++;
        await Future.delayed(const Duration(seconds: 2));
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTafsirAyat(int nomor) async {
    tafsirLoading[nomor] = true;

    const maxRetry = 10;
    int retry = 0;

    try {
      while (!net.isConnected.value) {
        await Future.delayed(const Duration(seconds: 1));
      }

      while (retry < maxRetry) {
        try {
          final url = Uri.parse(ApiEndpoints.tafsirAyat(nomor));
          final res = await http.get(url).timeout(const Duration(seconds: 10));

          if (res.statusCode == 200) {
            final jsonData = json.decode(res.body);
            final List tafsir = (jsonData["data"]["tafsir"] as List?) ?? [];

            tafsirList.assignAll(
              tafsir.map<TafsirAyat>((e) => TafsirAyat.fromJson(e)).toList(),
            );

            return;
          }
        } catch (e) {
          print("Retry tafsir: $e");
        }

        retry++;
        await Future.delayed(const Duration(seconds: 2));
      }
    } finally {
      tafsirLoading[nomor] = false;
    }
  }

  void playAudio(Ayat ayat) async {
    if (ayat.audio.values.isEmpty || ayat.audio.values.first.isEmpty) return;

    try {
      if (lastAyat != null) {
        lastAyat!.kondisiAudio.value = "stop";
      }

      lastAyat = ayat;

      await player.stop();
      await player.setUrl(ayat.audio.values.first);

      ayat.kondisiAudio.value = "playing";

      await player.play();
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }
  

  void pauseAudio(Ayat ayat) async {
    try {
      if (player.playing) {
        await player.pause();
        ayat.kondisiAudio.value = "pause";
      }
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  void stopAudio(Ayat ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio.value = "stop";
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }


  void resumeAudio(Ayat ayat) async {
    try {
      if (!player.playing) {
        ayat.kondisiAudio.value = "playing";
        await player.play();
      }
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
