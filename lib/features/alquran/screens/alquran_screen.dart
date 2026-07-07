import 'package:alquran_new/binding/surah_binding.dart';
import 'package:alquran_new/core/widgets/loading.dart';
import 'package:alquran_new/core/widgets/search_bar.dart';
import 'package:alquran_new/core/constants/shadow_extension.dart';
import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';

import 'package:alquran_new/features/pemutar_audio/widgets/player_bar.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/features/surat/screens/detail_surat_screen.dart';
import 'package:alquran_new/features/alquran/widgets/category_filter.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OctagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    double cut = 20;

    Path path = Path();
    path.moveTo(cut, 0);
    path.lineTo(w - cut, 0);
    path.lineTo(w, cut);
    path.lineTo(w, h - cut);
    path.lineTo(w - cut, h);
    path.lineTo(cut, h);
    path.lineTo(0, h - cut);
    path.lineTo(0, cut);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AlQuranScreen extends StatefulWidget {
  const AlQuranScreen({super.key});

  @override
  State<AlQuranScreen> createState() => _AlQuranScreenState();
}

class _AlQuranScreenState extends State<AlQuranScreen> {
  final SurahController controller = Get.put(
    SurahController(),
    permanent: true,
  );
  final List<String> categories = ["Surah", "Mekah", "Madinah"];
  final SettingsController setting = Get.find<SettingsController>();


  @override
  Widget build(BuildContext context) {
    final scale = Responsive.scale(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,

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
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Icon(
                Icons.menu_book_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Al-Quran", style: Theme.of(context).textTheme.titleLarge),

                Obx(() {
                  if (controller.isLoading.value) {
                    return const SizedBox(height: 10);
                  }
                  return Text(
                    "${controller.surahList.length} Surah",
                    style: Theme.of(context).textTheme.labelSmall,
                  );
                }),
              ],
            ),
          ],
        ),
      ),

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.padding(context),
                vertical: 15,
              ),
              child: Column(
                children: [
                  AppSearchBar(
                    onChanged: controller.search,
                    hintText: "Cari Surat...",
                  ),

                  SizedBox(height: 10 * scale),

                  Obx(() {
                    return CategoryFilter(
                      categories: categories,
                      activeCategory: controller.activeCategory.value,
                      onCategorySelected: (category) {
                        controller.filter(category);
                      },
                    );
                  }),

                  SizedBox(height: 15 * scale),

                  Expanded(
                    child: Obx(() {
                      return ListView.builder(
                        itemCount: controller.filteredSurah.length,
                        itemBuilder: (context, index) {
                          final surah = controller.filteredSurah[index];
                          final selectedIndex = setting.fontSelected.value;
                          final fontFamily = fontArabs[selectedIndex]["title"];

                          return Column(
                            children: [
                              InkWell(
                                onTap: () => Get.to(
                                  () => DetailSuratScreen(),
                                  binding: SurahBinding(),
                                  arguments: {
                                    "surah": surah.nomor,
                                    "ayat": null,
                                  },
                                ),
                                child: Container(
                                  height: 90 * scale,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                      16 * scale,
                                    ),
                                    boxShadow: context.shadow.small,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10 * scale,
                                      vertical: 10 * scale,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Text(
                                                  surah.nomor.toString(),
                                                  style: TextStyle(
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                                    fontSize: 14 * scale,
                                                  ),
                                                ),
                                                Icon(
                                                    Icons.brightness_5_sharp,
                                                    size: 45 * scale,
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.surface,
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 12 * scale),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  surah.namaLatin,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                          fontSize: 16 * scale,
                                                      ),
                                                ),
                                                SizedBox(height: 3),
                                                Row(
                                                  children: [
                                                    Text(
                                                  "${surah.jumlahAyat} Ayat",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall
                                                      ?.copyWith(
                                                          fontSize: 12 * scale,
                                                      ),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: surah.tempatTurun.name == "Mekah" ? Theme.of(context).colorScheme.primary.withAlpha(120) : Colors.blue.withAlpha(120)
                                                  ),
                                                  child: Text(
                                                  surah.tempatTurun.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                          fontSize: 8 * scale,
                                                      ),
                                                ),
                                                )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),

                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              surah.nama,
                                              style: TextStyle(
                                                fontFamily: fontFamily,
                                                fontSize: 20 * scale,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                            ),
                                            Text(
                                              surah.arti,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    fontSize: 12,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10 * scale,
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (!controller.isLoading.value) {
                return const SizedBox();
              }

              return const Positioned.fill(child: Loading());
            }),

            const Positioned(bottom: 0, left: 0, right: 0, child: PlayerBar()),
          ],
        ),
      ),
    );
  }
}
