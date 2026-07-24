import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/juz_ayat.dart';
import 'package:alquran_new/development/juz_cache_datasource.dart';
import 'package:alquran_new/development/juz_range.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_detail_surah.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class JuzController extends GetxController {
  final GetDetailSurah _getDetailSurah = Get.find();
  final net = Get.find<NetworkController>();
  final _cacheDatasource = JuzCacheDatasource();

  var isLoading = false.obs;
  var juzAyatList = <JuzAyat>[].obs;

  final player = AudioPlayer();
  var activeAyatNomor = Rxn<int>();
  final ayatAudioStates = <int, RxString>{};

  String getAyatAudioState(int nomor) {
    return ayatAudioStates.putIfAbsent(nomor, () => "stop".obs).value;
  }

  void _setAyatAudioState(int nomor, String state) {
    ayatAudioStates.putIfAbsent(nomor, () => "stop".obs).value = state;
  }

  Future<void> fetchJuz(int juzNumber) async {
    isLoading.value = true;
    juzAyatList.clear();

    final cached = await _cacheDatasource.getJuz(juzNumber);
    if (cached != null && cached.isNotEmpty) {
      juzAyatList.value = cached;
      isLoading.value = false;
      return;
    }

    if (!net.isConnected.value) {
      Get.snackbar(
        "Tidak Ada Koneksi",
        "Periksa koneksi internet untuk memuat data juz.",
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      return;
    }

    final range = juzRanges[juzNumber - 1];
    final result = <JuzAyat>[];

    final surahNumbers = <int>{};
    for (int i = range.startSurah; i <= range.endSurah; i++) {
      surahNumbers.add(i);
    }

    for (final nomor in surahNumbers) {
      final res = await _getDetailSurah.call(nomor);

      res.when(
        success: (surah) {
          int startAyah = 1;
          int endAyah = surah.jumlahAyat;

          if (nomor == range.startSurah) {
            startAyah = range.startAyah;
          }
          if (nomor == range.endSurah) {
            endAyah = range.endAyah;
          }

          for (final ayat in surah.ayat) {
            if (ayat.nomorAyat >= startAyah && ayat.nomorAyat <= endAyah) {
              result.add(
                JuzAyat(
                  numberInSurah: ayat.nomorAyat,
                  teksArab: ayat.teksArab,
                  teksLatin: ayat.teksLatin,
                  teksIndonesia: ayat.teksIndonesia,
                  surahNomor: surah.nomor,
                  surahNamaLatin: surah.namaLatin,
                  surahArti: surah.arti,
                  surahTempatTurun: _parseTempatTurun(surah.tempatTurun),
                  surahJumlahAyat: surah.jumlahAyat,
                  audio: ayat.audio,
                ),
              );
            }
          }
        },
        failure: (message, statusCode) {
          Get.snackbar(
            "Gagal Memuat",
            "Surat $nomor: $message",
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
    }

    juzAyatList.value = result;
    isLoading.value = false;

    if (result.isNotEmpty) {
      await _cacheDatasource.saveJuz(juzNumber, result);
    }
  }

  TempatTurun _parseTempatTurun(String value) {
    if (value.toLowerCase() == 'madinah') return TempatTurun.Madinah;
    return TempatTurun.Mekah;
  }

  Future<void> playAudio(JuzAyat ayat) async {
    if (ayat.audio.isEmpty) return;

    try {
      if (activeAyatNomor.value != null) {
        _setAyatAudioState(activeAyatNomor.value!, "stop");
      }

      final url = ayat.audio.values.first;
      if (url.isEmpty) return;

      activeAyatNomor.value = ayat.numberInSurah;

      await player.stop();
      await player.setUrl(url);

      _setAyatAudioState(ayat.numberInSurah, "playing");
      await player.play();
    } catch (e) {
      _setAyatAudioState(ayat.numberInSurah, "stop");
      activeAyatNomor.value = null;
    }
  }

  Future<void> pauseAudio(JuzAyat ayat) async {
    try {
      if (player.playing) {
        await player.pause();
        _setAyatAudioState(ayat.numberInSurah, "pause");
      }
    } catch (_) {}
  }

  Future<void> stopAudio(JuzAyat ayat) async {
    try {
      await player.stop();
      _setAyatAudioState(ayat.numberInSurah, "stop");
    } catch (_) {}
  }

  Future<void> resumeAudio(JuzAyat ayat) async {
    try {
      if (!player.playing) {
        _setAyatAudioState(ayat.numberInSurah, "playing");
        await player.play();
      }
    } catch (_) {}
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
