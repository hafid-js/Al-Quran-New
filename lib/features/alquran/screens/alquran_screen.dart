import 'package:alquran_new/binding/surah_binding.dart';
import 'package:alquran_new/core/ui/loading.dart';
import 'package:alquran_new/core/utils/constants/shadow_extension.dart';
import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
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

      body: Stack(
        children: [
          /// ================= MAIN CONTENT =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
                          color: Theme.of(context).cardColor,
                          boxShadow: context.shadow.small,
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
                        final surah = controller.filteredSurah[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () => Get.to(
                                () => DetailSuratScreen(),
                                binding: SurahBinding(),
                                arguments: {"surah": surah.nomor, "ayat": null},
                              ),
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: context.shadow.small,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
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
                                                  fontSize: TextTheme.of(
                                                    context,
                                                  ).labelSmall?.fontSize,
                                                ),
                                              ),
                                              Icon(
                                                Icons.brightness_5_sharp,
                                                size: 45,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.surface,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                surah.namaLatin,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleSmall,
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                "${surah.jumlahAyat} Ayat",
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.labelSmall,
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
                                              fontSize: Theme.of(
                                                context,
                                              ).textTheme.titleLarge?.fontSize,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                          ),
                                          Text(
                                            surah.arti,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelSmall,
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

            return const Positioned.fill(child: Loading());
          }),
        ],
      ),
    );
  }
}
