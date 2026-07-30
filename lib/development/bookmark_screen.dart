import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/bookmark/controllers/bookmark_controller.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BookmarkScreenNew extends StatefulWidget {
  const BookmarkScreenNew({super.key});

  @override
  State<BookmarkScreenNew> createState() => _BookmarkScreenNewState();
}

class _BookmarkScreenNewState extends State<BookmarkScreenNew> {
  final BookmarkController bookmarkController = Get.find<BookmarkController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Bookmark",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (bookmarkController.bookmarks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.save_2,
                  size: 64,
                  color: HexColor.fromHex("#DBB893"),
                ),
                SizedBox(height: 16),
                Text(
                  "Belum ada bookmark",
                  style: TextStyle(
                    color: HexColor.fromHex("#1E4355"),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Ayat yang kamu simpan akan muncul di sini.",
                  style: TextStyle(
                    color: HexColor.fromHex("#676767"),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: bookmarkController.bookmarks.length,
          itemBuilder: (context, index) {
            final bm = bookmarkController.bookmarks[index];
            final fontIndex = settingsController.fontSelected.value;
            final fontFamily = fontArabs[fontIndex]["title"];

            return GestureDetector(
              onTap: () => bookmarkController.openBookmark(bm),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#DBB893").withAlpha(30),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    "${bm.surahNumber}",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#1E4355"),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/icon/octagram.png",
                                    height: 35,
                                    width: 35,
                                    color: HexColor.fromHex("#DBB893"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    bm.surahName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: HexColor.fromHex("#1E4355"),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Ayat ${bm.ayatNumber}",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#676767"),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        bm.arabName,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 20,
                          color: HexColor.fromHex("#1E4355"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
