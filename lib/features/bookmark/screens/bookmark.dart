import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/bookmark/controllers/bookmark_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BookmarkController controller = Get.put(BookmarkController());
    return Scaffold(
      backgroundColor: HexColor.fromHex("#132e3a").withAlpha(120),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_circle_left_rounded),
          color: Colors.white,
        ),

        titleSpacing: 5,

        title: Row(
          children: [
            Container(
              height: 36,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor.fromHex("#17404a"),
              ),
              child: Icon(
                Icons.bookmarks_rounded,
                size: 20,
                color: HexColor.fromHex("#2dc8b9"),
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Bookmark",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [

            Expanded(child: ListView.builder(
              itemCount: controller.bookmarks.length,
              itemBuilder: (context, index) {
                final bm = controller.bookmarks[index];

                return Padding(padding: EdgeInsets.only(bottom: 10), child: Container(
              decoration: BoxDecoration(
                color: HexColor.fromHex("#132D3B"),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                onTap: () {
                  controller.openBookmark(bm);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                leading: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#163F4A"),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        bm.surahNumber.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: HexColor.fromHex("#2cc4b6"),
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  bm.surahName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                subtitle: Wrap(
                  spacing: 5,
                  runSpacing: 4,
                  children: [
                    Text(
                      "Ayat ${bm.ayatNumber}",
                      style: TextStyle(
                        fontSize: 14,
                        color: HexColor.fromHex("#5a7b8a"),
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      bm.surahName,
                      style: TextStyle(
                        fontSize: 20,
                        color: HexColor.fromHex("#28ab9e"),
                      ),
                    ),
                  ],
                ),
              ),
            ),);
              })
              
              ),
          ],
        ),
      ),
    );
  }
}
