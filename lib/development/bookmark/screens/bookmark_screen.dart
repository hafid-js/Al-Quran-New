import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/bookmark/controllers/bookmark_controller.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
import 'package:alquran_new/development/shared/widgets/octagram_badge.dart';
import 'package:alquran_new/development/pengaturan/controllers/settings_controller.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar(
        title: "Bookmark",
        backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
        surfaceTintColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
        backIconColor: isDark ? Colors.white : Colors.black,
        titleColor: isDark ? Colors.white : Colors.black,
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
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OctagramBadge(number: "${bm.surahNumber}", numberColor:  isDark ? AppColors.light : AppColors.dark,),
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
                                      color: isDark ? Colors.white : HexColor.fromHex("#1E4355"),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Ayat ${bm.ayatNumber}",
                                    style: TextStyle(
                                      color: isDark ? AppColors.secondary : HexColor.fromHex("#676767"),
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
                          color: isDark ? AppColors.secondary : HexColor.fromHex("#1E4355"),
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
