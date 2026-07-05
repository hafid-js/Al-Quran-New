import 'package:alquran_new/core/widgets/error_view.dart';
import 'package:alquran_new/core/widgets/search_bar.dart';
import 'package:alquran_new/features/dzikir/controllers/dzikir_controller.dart';
import 'package:alquran_new/features/dzikir/screens/dzikir_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';

class DzikirScreen extends StatefulWidget {
  const DzikirScreen({super.key});

  @override
  State<DzikirScreen> createState() => _DzikirScreenState();
}

class _DzikirScreenState extends State<DzikirScreen> {
  final controller = Get.put(DzikirController());
  var searchQuery = ''.obs;

  List<String> get categories {
    final set = <String>{};
    for (final e in controller.dzikirList) {
      set.add(e.kategori);
    }
    return set.toList()..sort();
  }

  List<String> get filteredCategories {
    if (searchQuery.value.isEmpty) return categories;
    final q = searchQuery.value.toLowerCase();
    return categories.where((c) {
      final items = controller.dzikirList.where((e) => e.kategori == c);
      return c.toLowerCase().contains(q) ||
          items.any(
            (e) =>
                e.judul.toLowerCase().contains(q) ||
                e.arti.toLowerCase().contains(q),
          );
    }).toList();
  }

  int itemCount(String category) {
    return controller.dzikirList.where((e) => e.kategori == category).length;
  }

  void _resetAllDzikirCounts() {
    final box = GetStorage();
    final keys = box.getKeys().toList();
    for (final key in keys) {
      if (key.startsWith('dzikir_count_')) {
        box.remove(key);
      }
    }
    Get.snackbar(
      'Berhasil',
      'Semua hitungan dzikir direset',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

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
              height: 36 * scale,
              width: 36 * scale,
              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10 * scale,
                    ),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Icon(
                Icons.mosque_rounded,
                size: 20 * scale,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Dzikir", style: Theme.of(context).textTheme.titleLarge),

                Obx(
                  () => Text(
                    "${controller.isLoading.value ? '-' : categories.length} Kategori",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Tooltip(
              message: 'Reset Hitungan Dzikir',
              child: GestureDetector(
                onTap: _resetAllDzikirCounts,
                child: Container(
                  height: 40 * scale,
                  width: 40 * scale,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  child: Icon(
                    Icons.rotate_left_outlined,
                    color: Theme.of(context).textTheme.labelLarge?.color,
                    size: 20 * scale,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return ErrorView(
            message: controller.errorMessage.value,
            onRetry: controller.fetchDzikir,
          );
        }

        return Padding(
           padding: EdgeInsets.symmetric(
             horizontal: Responsive.padding(context),
             vertical: 15,
           ),

          child: Column(
            children: [
              AppSearchBar(
                onChanged: (v) => searchQuery.value = v,
                hintText: "Cari Dzikir...",
              ),

              SizedBox(height: 15 * scale),

              Expanded(
                child: Obx(() {
                  final list = filteredCategories;

                  return ListView.builder(
                    itemCount: list.length,

                    itemBuilder: (context, index) {
                      final category = list[index];
                      final count = itemCount(category);

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 10 * scale,
                        ),

                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => DzikirListScreen(category: category),
                              transition: Transition.rightToLeft,
                            );
                          },

                          child: Container(
                            height: 80 * scale,

                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(
                                16 * scale,
                              ),
                            ),

                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.only(
                                      left: 10,
                                    ),

                                    leading: Container(
                                      height: 45 * scale,
                                      width: 45 * scale,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12 * scale,
                                        ),

                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                      ),

                                      child: Center(
                                        child: Icon(
                                          Icons.auto_awesome_mosaic_rounded,
                                          size: 20 * scale,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                    ),

                                    title: Text(
                                      category,

                                      style: TextStyle(
                                        fontSize: Theme.of(
                                          context,
                                        ).textTheme.labelMedium?.fontSize,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(
                                          context,
                                        ).textTheme.titleLarge?.color,
                                      ),

                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),

                                    subtitle: Text(
                                      "$count Dzikir",

                                      style: TextStyle(
                                        fontSize: Theme.of(
                                          context,
                                        ).textTheme.labelSmall?.fontSize,

                                        color: Theme.of(
                                          context,
                                        ).textTheme.labelSmall?.color,
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.labelSmall?.color,
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
              ),
            ],
          ),
        );
      }),
    );
  }
}
