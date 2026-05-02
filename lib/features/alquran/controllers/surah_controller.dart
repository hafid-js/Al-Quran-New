import 'package:alquran_new/features/alquran/models/surah_model.dart';
import 'package:alquran_new/features/alquran/services/surah_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class SurahController extends GetxController {
  final SurahService _service = SurahService();

  var isLoading = false.obs;
  var surahList = <Surah>[].obs;
  var filteredSurah = <Surah>[].obs;
  var activeCategory = "Surah".obs;
  final player = AudioPlayer();

  var activeSurah = Rxn<Surah>();
  var playerState = "stopped".obs; // playing | pause | stopped

  @override
  void onInit() {
    super.onInit();
    fetchSurah();
  }

  Future<void> fetchSurah() async {
    try {
      isLoading.value = true;

      final result = await _service.getAllSurah();

      surahList.value = result;
      filteredSurah.value = result;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filter(String category) {
    activeCategory.value = category;

    if (category == "Surah") {
      filteredSurah.value = surahList;
    } else {
      filteredSurah.value = surahList
          .where(
            (e) => e.tempatTurun.name.toLowerCase() == category.toLowerCase(),
          )
          .toList();
    }
  }

  void playAudio(Surah surah) async {
    if (surah.audioFull.values.isEmpty || surah.audioFull.values.first.isEmpty)
      return;

    try {
      if (activeSurah.value != surah) {
        await player.stop();
      }
      activeSurah.value = surah;

      await player.stop();
      await player.setUrl(surah.audioFull.values.first);

      surah.kondisiAudio.value = "playing";

      await player.play();
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  void pauseAudio(Surah surah) async {
    try {
      if (player.playing) {
        await player.pause();
        surah.kondisiAudio.value = "pause";
      }
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  void stopAudio(Surah surah) async {
    try {
      await player.stop();
      surah.kondisiAudio.value = "stop";
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  void resumeAudio(Surah surah) async {
    try {
      if (!player.playing) {
        surah.kondisiAudio.value = "playing";
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
