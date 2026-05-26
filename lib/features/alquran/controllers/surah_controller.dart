import 'dart:convert';

import 'package:alquran_new/core/db/isar_service.dart';
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
   final isar = IsarService.isar;

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

    final cache = await local.getSurah();

    if (cache.isNotEmpty) {
      for (final s in cache) {
        await s.ayat.load();
      }

      surahList.value = cache.map((e) {
        final ayatList = e.ayat.toList()
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

      await isar.writeTxn(() async {
        if (hasAyat) {
          await isar.ayatCaches.clear();
        }
        await isar.surahCaches.clear();

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

          await isar.surahCaches.put(surah);

          if (hasAyat) {
            for (final a in e.ayat) {
              final ayat = AyatCache()
                ..nomorAyat = a.nomorAyat
                ..teksArab = a.teksArab
                ..teksLatin = a.teksLatin
                ..teksIndonesia = a.teksIndonesia
                ..audioJson = jsonEncode(a.audio)
                ..surah.value = surah;

              await isar.ayatCaches.put(ayat);
            }
          }
        }
      });

    }
  } finally {
    isLoading.value = false;
  }
}

  Future<void> refreshSurah() async {
    await local.isar.writeTxn(() async {
      await local.isar.surahCaches.clear();
    });

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
