import 'package:alquran_new/binding/bookmark_binding.dart';
import 'package:alquran_new/development/core/db/hive_service.dart';
import 'package:alquran_new/development/bookmark/models/bookmark_model.dart';
import 'package:alquran_new/development/bookmark/screens/detail_surat_screen.dart';
import 'package:alquran_new/development/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class BookmarkController extends GetxController {
  var bookmarks = <BookmarkModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    load();
  }

  void load() async {
    final data = DevHiveService.bookmarkBox.values.toList();
    bookmarks.assignAll(data);
  }

  void vibrate() async {
  if (await Vibration.hasVibrator() ?? false) {
    Vibration.vibrate(duration: 200);
  }
}


  void toggle(int surah, String arab, String nama, int ayat) async {
    final existing = DevHiveService.bookmarkBox.values
        .where((b) => b.surahNumber == surah && b.ayatNumber == ayat)
        .toList();

    if (existing.isEmpty) {
      await DevHiveService.bookmarkBox.add(
        BookmarkModel()
          ..surahNumber = surah
          ..surahName = nama
          ..arabName = arab
          ..ayatNumber = ayat,
      );
        vibrate();

      Get.snackbar(
        "Bookmark Ditambahkan",
        "$nama ayat $ayat disimpan",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
    } else {
      await existing.first.delete();
        vibrate();

      Get.snackbar(
        "Bookmark Dihapus",
        "$nama ayat $ayat dihapus",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

    }
    load();
  }

  bool isBookmarked(int surah, int ayat) {
    return bookmarks.any((e) => e.surahNumber == surah && e.ayatNumber == ayat);
  }

 void openBookmark(BookmarkModel bm) {
  Get.to(
    () => DetailSuratScreen(),
    arguments: {
      "surah": bm.surahNumber,
      "ayat": bm.ayatNumber,
    },
    binding: BookmarkBinding()
  );
}
}
