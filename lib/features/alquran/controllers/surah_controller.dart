import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_all_surah.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class SurahController extends GetxController {
  final GetAllSurah _getAllSurah = Get.find();

  var isLoading = false.obs;
  var surahList = <Surah>[].obs;
  var filteredSurah = <Surah>[].obs;
  var activeCategory = "Surah".obs;
  final player = AudioPlayer();

  final surahAudioStates = <int, RxString>{};
  var activeSurahNomor = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    fetchSurah();
  }

  String getSurahAudioState(int nomor) {
    return surahAudioStates.putIfAbsent(nomor, () => "stop".obs).value;
  }

  void _setSurahAudioState(int nomor, String state) {
    surahAudioStates.putIfAbsent(nomor, () => "stop".obs).value = state;
  }

  Future<void> fetchSurah() async {
    try {
      isLoading.value = true;
      final result = await _getAllSurah.call();
      if (result is Success<List<Surah>>) {
        surahList.value = result.data;
        filteredSurah.value = result.data;
      } else if (result is Failure<List<Surah>>) {
        Get.snackbar('Error', result.message);
      }
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
          .where((e) => e.tempatTurun.name.toLowerCase() == category.toLowerCase())
          .toList();
    }
  }

  void playAudio(Surah surah) async {
    if (surah.audioFull.values.isEmpty || surah.audioFull.values.first.isEmpty) return;

    try {
      if (activeSurahNomor.value != null && activeSurahNomor.value != surah.nomor) {
        _setSurahAudioState(activeSurahNomor.value!, "stop");
      }

      activeSurahNomor.value = surah.nomor;

      await player.stop();
      await player.setUrl(surah.audioFull.values.first);

      _setSurahAudioState(surah.nomor, "playing");
      await player.play();
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  void pauseAudio(Surah surah) async {
    try {
      if (player.playing) {
        await player.pause();
        _setSurahAudioState(surah.nomor, "pause");
      }
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  void stopAudio(Surah surah) async {
    try {
      await player.stop();
      _setSurahAudioState(surah.nomor, "stop");
    } catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
    }
  }

  void resumeAudio(Surah surah) async {
    try {
      if (!player.playing) {
        _setSurahAudioState(surah.nomor, "playing");
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
