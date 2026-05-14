import 'package:alquran_new/core/db/isar_service.dart';
import 'package:alquran_new/features/bookmark/models/bookmark_model.dart';
import 'package:alquran_new/features/surat/screens/detail_surat_screen.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class BookmarkController extends GetxController {
  var bookmarks = <BookmarkModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    load();
  }

  void load() async {
    final data = await IsarService.isar.bookmarkModels.where().findAll();
    bookmarks.assignAll(data);
  }

  void toggle(int surah, String nama, int ayat) async {
    final db = IsarService.isar;

    final existing = await db.bookmarkModels
        .filter()
        .surahNumberEqualTo(surah)
        .and()
        .ayatNumberEqualTo(ayat)
        .findFirst();

    if (existing == null) {
      await db.writeTxn(() async {
        await db.bookmarkModels.put(
          BookmarkModel()
            ..surahNumber = surah
            ..surahName = nama
            ..ayatNumber = ayat,
        );
      });
    } else {
      await db.writeTxn(() async {
        await db.bookmarkModels.delete(existing.id);
      });
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
  );
}
}
