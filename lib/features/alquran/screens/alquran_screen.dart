import 'package:alquran_new/core/ui/loading.dart';
import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:alquran_new/features/surat/screens/detail_surat_screen.dart';
import 'package:alquran_new/features/alquran/widgets/category_filter.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
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
  final SurahController controller = Get.put(SurahController());
  final List<String> categories = ["Surah", "Mekah", "Madinah"];

  @override
  Widget build(BuildContext context) {
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
                Icons.menu_book_rounded,
                size: 20,
                color: HexColor.fromHex("#2dc8b9"),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Al-Quran",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Obx(() {
                  if (controller.isLoading.value) {
                    return const SizedBox(height: 10);
                  }
                  return Text(
                    "${controller.surahList.length} Surah",
                    style: TextStyle(
                      color: HexColor.fromHex("#7c97a6"),
                      fontSize: 14,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          /// ================= MAIN CONTENT =================
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: HexColor.fromHex("#132e3a"),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: HexColor.fromHex("#7c97a6"),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                "Cari Surat...",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: HexColor.fromHex("#7c97a6"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Obx(() {
                  return CategoryFilter(
                    categories: categories,
                    activeCategory: controller.activeCategory.value,
                    onCategorySelected: (category) {
                      controller.filter(category);
                    },
                  );
                }),

                const SizedBox(height: 15),

                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: controller.filteredSurah.length,
                      itemBuilder: (context, index) {
                        final surah =
                            controller.filteredSurah[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () => Get.to(() => DetailSuratScreen(), arguments: {
  "surah": surah.nomor,
  "ayat": null,
}),
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  color:
                                      HexColor.fromHex("#132e3a"),
                                  borderRadius:
                                      BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment:
                                                Alignment.center,
                                            children: [
                                              Text(
                                                surah.nomor
                                                    .toString(),
                                                style: TextStyle(
                                                  color: HexColor.fromHex(
                                                      "#28ab9e"),
                                                  fontSize: 11,
                                                ),
                                              ),
                                              Icon(
                                                Icons.brightness_5_sharp,
                                                size: 45,
                                                color: HexColor.fromHex(
                                                        "#28ab9e")
                                                    .withAlpha(90),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                            children: [
                                              Text(
                                                surah.namaLatin,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                "${surah.jumlahAyat} Ayat",
                                                style: TextStyle(
                                                  color: HexColor.fromHex(
                                                      "#5a7b8a"),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            surah.nama,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  HexColor.fromHex(
                                                      "#28ab9e"),
                                            ),
                                          ),
                                          Text(
                                            surah.arti,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  HexColor.fromHex(
                                                      "#5a7b8a"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),

          /// ================= FULL SCREEN LOADING OVERLAY =================
          Obx(() {
            if (!controller.isLoading.value) {
              return const SizedBox();
            }

            return const Positioned.fill(
  child: Loading(),
);
          }),
        ],
      ),
    );
  }
}



