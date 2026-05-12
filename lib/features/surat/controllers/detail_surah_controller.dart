import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/domain/entities/ayat.dart';
import 'package:alquran_new/features/alquran/domain/entities/detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/entities/tafsir.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_tafsir.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  final GetDetailSurah _getDetailSurah = Get.find();
  final GetTafsir _getTafsir = Get.find();
  final net = Get.find<NetworkController>();

  var isLoading = false.obs;
  var detailSurah = Rxn<DetailSurah>();
  var tafsirList = <TafsirAyat>[].obs;
  var tafsirLoading = <int, bool>{}.obs;
  final player = AudioPlayer();

  final ayatAudioStates = <int, RxString>{};
  var activeAyatNomor = Rxn<int>();

  String getAyatAudioState(int nomorAyat) {
    return ayatAudioStates.putIfAbsent(nomorAyat, () => "stop".obs).value;
  }

  void _setAyatAudioState(int nomorAyat, String state) {
    ayatAudioStates.putIfAbsent(nomorAyat, () => "stop".obs).value = state;
  }

  Future<void> fetchDetailSurah(int nomor) async {
    isLoading.value = true;
    const maxRetry = 10;
    int retry = 0;

    try {
      while (!net.isConnected.value) {
        await Future.delayed(const Duration(seconds: 1));
      }

      while (retry < maxRetry) {
        final result = await _getDetailSurah.call(nomor);
        if (result is Success<DetailSurah>) {
          detailSurah.value = result.data;
          return;
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
        final result = await _getTafsir.call(nomor);
        if (result is Success<List<TafsirAyat>>) {
          tafsirList.assignAll(result.data);
          return;
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
      if (activeAyatNomor.value != null) {
        _setAyatAudioState(activeAyatNomor.value!, "stop");
      }

      activeAyatNomor.value = ayat.nomorAyat;

      await player.stop();
      await player.setUrl(ayat.audio.values.first);

      _setAyatAudioState(ayat.nomorAyat, "playing");
      await player.play();
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  void pauseAudio(Ayat ayat) async {
    try {
      if (player.playing) {
        await player.pause();
        _setAyatAudioState(ayat.nomorAyat, "pause");
      }
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  void stopAudio(Ayat ayat) async {
    try {
      await player.stop();
      _setAyatAudioState(ayat.nomorAyat, "stop");
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  void resumeAudio(Ayat ayat) async {
    try {
      if (!player.playing) {
        _setAyatAudioState(ayat.nomorAyat, "playing");
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
