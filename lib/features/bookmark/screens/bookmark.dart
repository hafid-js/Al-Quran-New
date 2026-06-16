import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/alquran/screens/alquran_screen.dart';
import 'package:alquran_new/features/bookmark/controllers/bookmark_controller.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});


  @override
  Widget build(BuildContext context) {
    BookmarkController controller = Get.put(BookmarkController());
      final SettingsController setting = Get.find<SettingsController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_circle_left_rounded),
          color: Theme.of(context).iconTheme.color,
        ),

        titleSpacing: 5,

        title: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:Theme.of(context).colorScheme.surface,
              ),
              child: Icon(
                Icons.bookmarks_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Bookmark",
                   style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),

      body: Obx(() {
          final selectedIndex = setting.fontSelected.value;
                        final fontFamily = fontArabs[selectedIndex]["title"];

        if (controller.bookmarks.isEmpty) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bookmark Kosong",
         style: Theme.of(context).textTheme.titleMedium
        ),

        const SizedBox(height: 10),

       
       Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Text(
            "Ayat yang kamu simpan akan muncul di sini.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: HexColor.fromHex("#8BA4B4"),
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
        onTap: () => Get.to(() => AlQuranScreen()),
        child:  
       
        Column(
          children: [
            Icon(
          Icons.add_circle_outline_rounded,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Text(
          "Tambah",
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
          ],)
        )
      ],
    ),
  );
}
        return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [

            Expanded(child: ListView.builder(
              itemCount: controller.bookmarks.length,
              itemBuilder: (context, index) {
                final bm = controller.bookmarks[index];

                return Padding(padding: EdgeInsets.only(bottom: 10), child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
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
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        bm.surahNumber.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  bm.surahName,
                  style: Theme.of(context).textTheme.titleSmall
                ),
                subtitle: Wrap(
                  spacing: 5,
                  runSpacing: 4,
                  children: [
                    Text(
                      "Ayat ${bm.ayatNumber}",
                      style: Theme.of(context).textTheme.labelMedium
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      bm.arabName,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
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
      );
      })
    );
  }
}
