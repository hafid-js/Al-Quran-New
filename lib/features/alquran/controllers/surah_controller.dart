import 'dart:async';
import 'dart:convert';

import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/data/local/ayat_cache.dart';
import 'package:alquran_new/features/alquran/data/local/datasource/surah_local_datasource.dart';
import 'package:alquran_new/features/alquran/data/local/surah_cache.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_all_surah.dart';
import 'package:alquran_new/features/alquran/models/detail_surah_model.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class SurahController extends GetxController
    with WidgetsBindingObserver {
  late final GetAllSurah _getAllSurah;
  final SurahLocalDatasource local = SurahLocalDatasource();

  var isLoading = false.obs;
  var isAudioLoading = false.obs;

  var surahList = <Surah>[].obs;
  var filteredSurah = <Surah>[].obs;
  var activeCategory = "Surah".obs;
  var searchQuery = ''.obs;

  final player = AudioPlayer();

  final surahAudioStates = <int, RxString>{};
  var activeSurahNomor = Rxn<int>();

  StreamSubscription? _audioSub;
  bool _isAutoPlaying = false;
  int? _lastCompletedSurah;

  int get _currentIndex =>
      surahList.indexWhere((e) => e.nomor == activeSurahNomor.value);

  @override
  void onInit() {
    super.onInit();
    _getAllSurah = Get.find<GetAllSurah>();
    WidgetsBinding.instance.addObserver(this);
    _audioSub?.cancel();
    fetchSurah();
    _listenToAudio();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      player.stop();
    }
  }

  String getSurahAudioState(int nomor) {
    return surahAudioStates.putIfAbsent(nomor, () => "stop".obs).value;
  }

  void _setSurahAudioState(int nomor, String state) {
    surahAudioStates.putIfAbsent(nomor, () => "stop".obs).value = state;
  }

  void _listenToAudio() {
  _audioSub?.cancel();

  _audioSub = player.positionStream.listen((position) async {
    final duration = player.duration;
    if (duration == null || duration == Duration.zero) return;
    if (!player.playing) return;
    if (position < duration * 0.98) return;

    final currentSurah = activeSurahNomor.value;
    if (currentSurah == null) return;

    if (_lastCompletedSurah == currentSurah) return;
    if (_isAutoPlaying) return;

    _lastCompletedSurah = currentSurah;
    _isAutoPlaying = true;

    try {
      await playNext();
    } finally {
      _isAutoPlaying = false;
    }
  });
}
  Future<void> playNext() async {
  if (surahList.isEmpty) return;
  if (activeSurahNomor.value == null) return;

  final currentIndex = _currentIndex;

  if (currentIndex == -1 || currentIndex + 1 >= surahList.length) {
    await player.stop();

    activeSurahNomor.value = null;

    for (final s in surahList) {
      _setSurahAudioState(s.nomor, "stop");
    }

    Get.snackbar(
      "Selesai",
      "Sudah sampai surah terakhir",
      snackPosition: SnackPosition.BOTTOM,
    );

    return;
  }

  final nextSurah = surahList[currentIndex + 1];

  await playAudio(nextSurah);
}

  Future<void> playAudio(Surah surah) async {
    if (isAudioLoading.value) {
      await player.stop();
      isAudioLoading.value = false;
    }
    isAudioLoading.value = true;
    try {
      final network = Get.find<NetworkController>();
      if (!network.isConnected.value) {
        isAudioLoading.value = false;
        return;
      }

      _lastCompletedSurah = null;

      final setting = Get.find<SettingsController>();

      final qariKey = (setting.qariSelected.value + 1)
          .toString()
          .padLeft(2, '0');

      final url = surah.audioFull[qariKey] ?? "";
      if (url.isEmpty) {
        isAudioLoading.value = false;
        return;
      }

      final previous = activeSurahNomor.value;

      activeSurahNomor.value = surah.nomor;
      _setSurahAudioState(surah.nomor, "loading");

      await player.stop();
      await player.setUrl(url);

      _setSurahAudioState(surah.nomor, "playing");
      await player.play();

      if (previous != null && previous != surah.nomor) {
        _setSurahAudioState(previous, "stop");
      }
    } catch (_) {
      _setSurahAudioState(surah.nomor, "stop");
    } finally {
      isAudioLoading.value = false;
    }
  }

  Future<void> fetchSurah() async {
    try {
      isLoading.value = true;

      final cache = await local.getSurah();

      if (cache.isNotEmpty) {
        final settingController = Get.find<SettingsController>();

        final qariKey = (settingController.qariSelected.value + 1)
            .toString()
            .padLeft(2, '0');

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
            audioFull: {qariKey: e.audioUrl},
            ayat: ayatList.map((a) {
              return Ayat(
                nomorAyat: a.nomorAyat,
                teksArab: a.teksArab,
                teksLatin: a.teksLatin,
                teksIndonesia: a.teksIndonesia,
                audio: Map<String, String>.from(jsonDecode(a.audioJson)),
              );
            }).toList(),
          );
        }).toList();

        filteredSurah.value = surahList;
        return;
      }

      final net = Get.find<NetworkController>();
      if (!net.isConnected.value) {
        Get.snackbar(
          "Tidak Ada Koneksi",
          "Periksa koneksi internet untuk memuat daftar surah.",
          snackPosition: SnackPosition.BOTTOM,
        );
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
    _applyFilter();
  }

  Timer? _debounce;

  void search(String value) {
    searchQuery.value = value;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _applyFilter();
    });
  }

  void _applyFilter() {
    List<Surah> result = surahList;

    if (activeCategory.value != "Surah") {
      result = result
          .where((e) =>
              e.tempatTurun.name.toLowerCase() ==
              activeCategory.value.toLowerCase())
          .toList();
    }

    final query = searchQuery.value.toLowerCase().trim();
    if (query.isNotEmpty) {
      result = result
          .where((e) =>
              e.namaLatin.toLowerCase().contains(query) ||
              e.nama.toLowerCase().contains(query) ||
              e.arti.toLowerCase().contains(query))
          .toList();
    }

    filteredSurah.value = result;
  }

  Future<void> playPrevious() async {
    if (surahList.isEmpty) return;

    final currentIndex = _currentIndex;
    if (currentIndex <= 0) return;

    final prevSurah = surahList[currentIndex - 1];
    await playAudio(prevSurah);
  }

  void pauseAudio(Surah surah) async {
    if (player.playing) {
      await player.pause();
      _setSurahAudioState(surah.nomor, "pause");
    }
  }

  void stopAudio(Surah surah) async {
    await player.stop();
    _setSurahAudioState(surah.nomor, "stop");
    activeSurahNomor.value = null;
  }

  void resumeAudio(Surah surah) async {
    if (!player.playing) {
      _setSurahAudioState(surah.nomor, "playing");
      await player.play();
    }
  }

  String formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioSub?.cancel();
    player.stop();
    player.dispose();
    super.onClose();
  }
}