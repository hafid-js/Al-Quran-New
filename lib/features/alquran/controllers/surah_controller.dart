import 'dart:convert';

import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/data/local/ayat_cache.dart';
import 'package:alquran_new/features/alquran/data/local/datasource/surah_local_datasource.dart';
import 'package:alquran_new/features/alquran/data/local/surah_cache.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_all_surah.dart';
import 'package:alquran_new/features/alquran/models/detail_surah_model.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class SurahController extends GetxController {
  final GetAllSurah _getAllSurah = Get.find();
  final SurahLocalDatasource local = SurahLocalDatasource();

  var isLoading = false.obs;
    var isAudioLoading = false.obs;
  var surahList = <Surah>[].obs;
  var filteredSurah = <Surah>[].obs;
  var activeCategory = "Surah".obs;
  final player = AudioPlayer();

  final surahAudioStates = <int, RxString>{};
  var activeSurahNomor = Rxn<int>();

 int get _currentIndex {
  return surahList.indexWhere((e) => e.nomor == activeSurahNomor.value);
}
  

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

    final cache = await local.getSurah();

    if (cache.isNotEmpty) {
      surahList.value = cache.map((e) {
        final ayatList = HiveService.ayatBox.values
            .where((a) => a.surahNomor == e.nomor)
            .toList()
          ..sort((a, b) => a.nomorAyat.compareTo(b.nomorAyat));

        return Surah(
          nomor: e.nomor,
          namaLatin: e.namaLatin,
          nama: e.nama,
          deskripsi: e.deskripsi,
          jumlahAyat: e.jumlahAyat,
          tempatTurun: TempatTurun.values.firstWhere(
            (t) => t.name == e.tempatTurun,
          ),
          arti: e.arti,
          audioFull: {"01": e.audioUrl},
          ayat: ayatList.map((a) {
            return Ayat(
              nomorAyat: a.nomorAyat,
              teksArab: a.teksArab,
              teksLatin: a.teksLatin,
              teksIndonesia: a.teksIndonesia,
              audio: Map<String, String>.from(
                jsonDecode(a.audioJson),
              ),
            );
          }).toList(),
        );
      }).toList();

      filteredSurah.value = surahList;
      return;
    }

    final result = await _getAllSurah.call();

    if (result is Success<List<Surah>>) {
      surahList.value = result.data;
      filteredSurah.value = result.data;

      final hasAyat = result.data.any((e) => e.ayat.isNotEmpty);

      if (hasAyat) {
        await HiveService.ayatBox.clear();
      }
      await HiveService.surahBox.clear();

      for (final e in result.data) {
        final surah = SurahCache()
          ..nomor = e.nomor
          ..namaLatin = e.namaLatin
          ..nama = e.nama
          ..deskripsi = e.deskripsi
          ..jumlahAyat = e.jumlahAyat
          ..tempatTurun = e.tempatTurun.name
          ..arti = e.arti
          ..audioUrl = e.audioFull.values.first;

        await HiveService.surahBox.add(surah);

        if (hasAyat) {
          for (final a in e.ayat) {
            final ayat = AyatCache()
              ..nomorAyat = a.nomorAyat
              ..teksArab = a.teksArab
              ..teksLatin = a.teksLatin
              ..teksIndonesia = a.teksIndonesia
              ..audioJson = jsonEncode(a.audio)
              ..surahNomor = e.nomor;

            await HiveService.ayatBox.add(ayat);
          }
        }
      }

    }
  } finally {
    isLoading.value = false;
  }
}

  Future<void> refreshSurah() async {
    await HiveService.surahBox.clear();

    await fetchSurah();
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

Future<void> playAudio(Surah surah) async {
  final url = surah.audioFull.values.firstOrNull ?? "";
  if (url.isEmpty) return;

  try {

    final previous = activeSurahNomor.value;

    activeSurahNomor.value = surah.nomor;

    _setSurahAudioState(surah.nomor, "loading");

    player.stop();

    await player.setUrl(url);

    _setSurahAudioState(surah.nomor, "playing");

    await player.play();

    if (previous != null && previous != surah.nomor) {
      _setSurahAudioState(previous, "stop");
    }

  } on PlayerInterruptedException {
// biarin
  } catch (e) {
    _setSurahAudioState(surah.nomor, "stop");

    Get.defaultDialog(
      title: "Terjadi Kesalahan",
      middleText: e.toString(),
    );
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

  Future<void> playNext() async {
  if (surahList.isEmpty) return;

  final currentIndex = _currentIndex;
  if (currentIndex == -1 || currentIndex + 1 >= surahList.length) return;

  final nextSurah = surahList[currentIndex + 1];
  await playAudio(nextSurah);
}

Future<void> playPrevious() async {
  if (surahList.isEmpty) return;

  final currentIndex = _currentIndex;
  if (currentIndex <= 0) return;

  final prevSurah = surahList[currentIndex - 1];
  await playAudio(prevSurah);
}

  

    String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2,'0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2,'0');

    return "$minutes:$seconds";
  }
  

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
