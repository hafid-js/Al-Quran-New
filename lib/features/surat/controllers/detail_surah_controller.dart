import 'dart:convert';

import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/data/local/ayat_cache.dart';
import 'package:alquran_new/features/alquran/data/local/datasource/surah_local_datasource.dart';
import 'package:alquran_new/features/alquran/data/local/datasource/tafsir_local_datasource.dart';
import 'package:alquran_new/features/alquran/data/local/tafsir_cache.dart';
import 'package:alquran_new/features/alquran/domain/entities/ayat.dart';
import 'package:alquran_new/features/alquran/domain/entities/detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/entities/tafsir.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_tafsir.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:alquran_new/features/alquran/data/local/surah_cache.dart';

class DetailSurahController extends GetxController {
  final GetDetailSurah _getDetailSurah = Get.find();
  final GetTafsir _getTafsir = Get.find();
  final net = Get.find<NetworkController>();
    final SurahLocalDatasource local = SurahLocalDatasource();
    final TafsirLocalDataSource tafsirLocal = TafsirLocalDataSource();

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
  await debugPrintSurahByNomor(nomor);
  try {
    isLoading.value = true;

    final cache = await local.getByNomor(nomor);

    if (cache != null) {
      final ayatList = HiveService.ayatBox.values
          .where((a) => a.surahNomor == nomor)
          .toList();
      if (ayatList.isNotEmpty) {
        _displayFromCache(cache);
        return;
      }

      if (!net.isConnected.value) {
        Get.snackbar(
          "Tidak Ada Koneksi",
          "Ayat surat ini belum tersimpan. Periksa koneksi internet.",
          snackPosition: SnackPosition.BOTTOM,
        );
        detailSurah.value = DetailSurah(
          nomor: cache.nomor,
          nama: cache.nama,
          namaLatin: cache.namaLatin,
          jumlahAyat: cache.jumlahAyat,
          tempatTurun: cache.tempatTurun,
          arti: cache.arti,
          deskripsi: cache.deskripsi,
          audioFull: {"01": cache.audioUrl},
          ayat: [],
        );
        return;
      }
    }

    if (cache == null) {
      if (!net.isConnected.value) {
        detailSurah.value = null;
        Get.snackbar(
          "Data tidak ada",
          "Surah ini belum ada di cache",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    final result = await _getDetailSurah.call(nomor);

    if (result is Success<DetailSurah>) {
      final data = result.data;

      await _saveDetailSurahToCache(data);

      final updatedCache = await local.getByNomor(nomor);
      if (updatedCache != null) {
        final ayatList = HiveService.ayatBox.values
            .where((a) => a.surahNomor == nomor)
            .toList();
        if (ayatList.isNotEmpty) {
          _displayFromCache(updatedCache);
          return;
        }
      }

      detailSurah.value = data;
    } else if (result is Failure && cache == null) {
      Get.snackbar(
        "Gagal memuat",
        (result as Failure).message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e, s) {
    Get.snackbar(
      "Terjadi Kesalahan",
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );
  } finally {
    isLoading.value = false;
  }
}

Future<void> _saveDetailSurahToCache(DetailSurah data) async {
  final existing = HiveService.surahBox.values
      .where((s) => s.nomor == data.nomor)
      .toList();

  late final SurahCache surah;
  if (existing.isNotEmpty) {
    surah = existing.first;
    surah
      ..nomor = data.nomor
      ..namaLatin = data.namaLatin
      ..nama = data.nama
      ..deskripsi = data.deskripsi
      ..jumlahAyat = data.jumlahAyat
      ..tempatTurun = data.tempatTurun
      ..arti = data.arti
      ..audioUrl = data.audioFull.values.isNotEmpty
          ? data.audioFull.values.first
          : '';
    await surah.save();
  } else {
    surah = SurahCache()
      ..nomor = data.nomor
      ..namaLatin = data.namaLatin
      ..nama = data.nama
      ..deskripsi = data.deskripsi
      ..jumlahAyat = data.jumlahAyat
      ..tempatTurun = data.tempatTurun
      ..arti = data.arti
      ..audioUrl = data.audioFull.values.isNotEmpty
          ? data.audioFull.values.first
          : '';
    await HiveService.surahBox.add(surah);
  }

  final ayatToDelete = HiveService.ayatBox.values
      .where((a) => a.surahNomor == data.nomor)
      .map((a) => a.key as int)
      .toList();
  for (final key in ayatToDelete) {
    await HiveService.ayatBox.delete(key);
  }

  for (final a in data.ayat) {
    final ayat = AyatCache()
      ..nomorAyat = a.nomorAyat
      ..teksArab = a.teksArab
      ..teksLatin = a.teksLatin
      ..teksIndonesia = a.teksIndonesia
      ..audioJson = jsonEncode(a.audio)
      ..surahNomor = data.nomor;

    await HiveService.ayatBox.add(ayat);
  }
}

void _displayFromCache(SurahCache cache) {
  final sortedAyat = HiveService.ayatBox.values
      .where((a) => a.surahNomor == cache.nomor)
      .toList()
    ..sort((a, b) => a.nomorAyat.compareTo(b.nomorAyat));

  final ayatList = sortedAyat.map((e) {
    Map<String, String> audioMap = {};

    if (e.audioJson.isNotEmpty) {
      try {
        audioMap = Map<String, String>.from(jsonDecode(e.audioJson));
      } catch (_) {
        audioMap = {};
      }
    }

    return Ayat(
      nomorAyat: e.nomorAyat,
      teksArab: e.teksArab,
      teksLatin: e.teksLatin,
      teksIndonesia: e.teksIndonesia,
      audio: audioMap,
    );
  }).toList();

  detailSurah.value = DetailSurah(
    nomor: cache.nomor,
    nama: cache.nama,
    namaLatin: cache.namaLatin,
    jumlahAyat: cache.jumlahAyat,
    tempatTurun: cache.tempatTurun,
    arti: cache.arti,
    deskripsi: cache.deskripsi,
    audioFull: {"01": cache.audioUrl},
    ayat: ayatList,
  );

}

Future<void> debugPrintSurahByNomor(int nomor) async {

  // await clearAllCache();

  final data = HiveService.surahBox.values
      .where((s) => s.nomor == nomor)
      .toList();

  if (data.isEmpty) {
    return;
  }
}

Future<void> clearAllCache() async {
  await HiveService.surahBox.clear();
  await HiveService.ayatBox.clear();
}

  Future<void> fetchTafsirAyat(int nomor) async {
    try {
      tafsirLoading[nomor] = true;

      final cache = await tafsirLocal.getBySurah(nomor);
      if(cache.isNotEmpty) {
        tafsirList.assignAll(
          cache.map((e) => TafsirAyat(ayat: e.nomorAyat, teks: e.tafsir)).toList()
        );
      }

      if(!net.isConnected.value) return;

      final result = await _getTafsir.call(nomor);
      if(result is Success<List<TafsirAyat>>) {
        tafsirList.assignAll(result.data);

        final cacheData = result.data.map((e) {
          return TafsirCache()
          ..nomorSurah = nomor
          ..nomorAyat = e.ayat
          ..tafsir = e.teks;
        }).toList();
              await tafsirLocal.saveTafsir(cacheData);
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
