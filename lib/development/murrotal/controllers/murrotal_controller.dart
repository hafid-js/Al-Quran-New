import 'package:alquran_new/development/murrotal/widgets/common.dart';
import 'package:alquran_new/development/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/development/alquran/domain/entities/surah.dart';
import 'package:alquran_new/development/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MurrotalController extends GetxController with WidgetsBindingObserver {
  SurahController get surahController => Get.find<SurahController>();
  SettingsController get settingsController => Get.find<SettingsController>();

  static const List<Map<String, String>> qariData = [
    {"title": "Abdullah Al-Juhany", "image": "assets/images/qari/Abdullah-Al-Juhany.webp", "banner": "assets/images/qari/banners/Abdullah-Al-Juhany.png", "deskripsi": "Abdullah Awad Al Juhany adalah seorang qari, hafiz Al-Qur'an, dan imam berkebangsaan Arab Saudi. Ia merupakan lulusan Universitas Islam Madinah dan meraih gelar doktor dalam bidang syariah. Sejak tahun 2008, ia dikenal sebagai salah satu imam tetap Masjidil Haram dengan bacaan yang tartil, merdu, dan penuh kekhusyukan."},
    {"title": "Abdul Muhsin Al Qasim", "image": "assets/images/qari/Abdul-Muhsin-Al-Qasim.webp", "banner": "assets/images/qari/banners/Abdul-Muhsin-Al-Qasim.png", "deskripsi": "Abdul Muhsin Al Qasim adalah seorang qari, hafiz Al-Qur'an, ulama, dan imam berkebangsaan Arab Saudi. Ia menempuh pendidikan di Universitas Islam Madinah dan dikenal sebagai salah satu imam tetap Masjid Nabawi. Dengan bacaan yang tenang, tartil, dan penuh kekhusyukan, tilawahnya menjadi rujukan bagi umat Islam di berbagai negara."},
    {"title": "Abdurrahman as-Sudais", "image": "assets/images/qari/Abdurrahman-as-Sudais.webp", "banner": "assets/images/qari/banners/Abdurrahman-as-Sudais.png", "deskripsi": "Abdurrahman As-Sudais adalah seorang qari, hafiz Al-Qur'an, ulama, dan imam berkebangsaan Arab Saudi. Ia meraih gelar doktor dari Universitas Umm Al-Qura dan menjadi salah satu imam tetap Masjidil Haram sejak tahun 1984. Tilawahnya dikenal luas karena suara yang khas, bacaan yang tartil, dan penuh penghayatan."},
    {"title": "Ibrahim Al-Dossari", "image": "assets/images/qari/Ibrahim-Al-Dossari.webp", "banner": "assets/images/qari/banners/Ibrahim-Al-Dossari.png", "deskripsi": "Ibrahim Al-Dossari adalah seorang qari, hafiz Al-Qur'an, dan imam berkebangsaan Arab Saudi. Ia merupakan lulusan Universitas Imam Muhammad bin Saud dan dikenal sebagai salah satu imam di Masjidil Haram. Bacaan Al-Qur'annya yang tenang, tartil, dan penuh kekhusyukan menjadikannya dikenal luas oleh kaum muslimin di berbagai negara."},
    {"title": "Misyari Rasyid Al-Afsi", "image": "assets/images/qari/Misyari-Rasyid-Al-Afasi.webp", "banner": "assets/images/qari/banners/Mishary-Rasyid-Al-Afasi.png", "deskripsi": "Mishary Rashid Alafasy adalah seorang qari, hafiz Al-Qur'an, imam, dan penyanyi nasyid berkebangsaan Kuwait. Ia merupakan lulusan Universitas Islam Madinah pada bidang Al-Qur'an dan tafsir. Berkat suara yang merdu, bacaan yang khusyuk, dan penguasaan tajwid yang baik, ia dikenal sebagai salah satu qari paling populer di dunia serta telah merekam seluruh Al-Qur'an."},
    {"title": "Yaser Al-Dossari", "image": "assets/images/qari/Yasser-Al-Dosari.webp", "banner": "assets/images/qari/banners/Yasser-Al-Dosari.png", "deskripsi": "Yasser Al-Dossari adalah seorang qari, hafiz Al-Qur'an, khatib, dan imam berkebangsaan Arab Saudi. Ia meraih gelar doktor dari Universitas Imam Muhammad bin Saud dan menjadi salah satu imam tetap Masjidil Haram sejak tahun 2020. Dengan suara yang merdu, bacaan yang tartil, dan penuh penghayatan, tilawahnya dikenal luas oleh umat Islam di berbagai belahan dunia."},
  ];

  final player = AudioPlayer(maxSkipsOnError: 3);
  final isMurrotalPlaying = false.obs;
  final murrotalSurahName = ''.obs;
  final murrotalSurahNomor = 0.obs;
  final murrotalQariIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    player.currentIndexStream.listen((index) {
      _syncFromPlayerIndex(index);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      stopMurrotal();
    }
  }

  void _syncFromPlayerIndex(int? index) {
    if (index == null) return;
    final sequence = player.sequence;
    if (index >= sequence.length) return;
    final source = sequence[index];
    final metadata = source.tag as AudioMetadata;
    final surah = surahController.surahList
        .where((s) => s.namaLatin == metadata.album)
        .firstOrNull;
    if (surah != null) {
      murrotalSurahNomor.value = surah.nomor;
      murrotalSurahName.value = surah.namaLatin;
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }

  List<Surah> get surahList => surahController.surahList;

  int get qariSelected => settingsController.qariSelected.value;

  Surah? getSurahByIndex(int index) {
    if (index < surahController.surahList.length) {
      return surahController.surahList[index];
    }
    return null;
  }

  String getCurrentQariName() {
    return qariData[qariSelected]["title"] ?? "";
  }

  String getCurrentQariImage() {
    return qariData[qariSelected]["image"] ?? "";
  }

  String getCurrentQariBanner() {
    return qariData[qariSelected]["banner"] ?? qariData[qariSelected]["image"] ?? "";
  }

  Future<void> changeQari(int index) async {
    await settingsController.changeQari(index);
  }

  Future<void> playSurah(Surah surah) async {
    await surahController.playAudio(surah);
  }

  String getSurahNumberLabel(int nomor) {
    return nomor.toString().padLeft(3, '0');
  }

  void setMurrotalAudio(int qariIndex, Surah surah) {
    murrotalQariIndex.value = qariIndex;
    murrotalSurahNomor.value = surah.nomor;
    murrotalSurahName.value = surah.namaLatin;
    isMurrotalPlaying.value = true;
  }

  void clearMurrotalAudio() {
    isMurrotalPlaying.value = false;
    murrotalSurahName.value = '';
    murrotalSurahNomor.value = 0;
  }

  Future<void> pauseMurrotal() async {
    if (player.playing) {
      await player.pause();
      isMurrotalPlaying.value = false;
    }
  }

  Future<void> resumeMurrotal() async {
    if (!player.playing) {
      await player.play();
      isMurrotalPlaying.value = true;
    }
  }

  Future<void> stopMurrotal() async {
    await player.stop();
    clearMurrotalAudio();
  }

  String formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }
}
