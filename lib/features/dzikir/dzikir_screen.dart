import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/dzikir/controllers/dzikir_controller.dart';
import 'package:alquran_new/features/dzikir/screens/dzikir_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          items.any((e) =>
              e.judul.toLowerCase().contains(q) ||
              e.arti.toLowerCase().contains(q));
    }).toList();
  }

  int itemCount(String category) {
    return controller.dzikirList.where((e) => e.kategori == category).length;
  }

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
                Icons.mosque_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Dzikir", style: Theme.of(context).textTheme.titleLarge),

                Obx(() => Text(
                  "${controller.isLoading.value ? '-' : categories.length} Kategori",
                  style: Theme.of(context).textTheme.labelSmall,
                )),
              ],
            ),
          ],
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_rounded, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: controller.fetchDzikir,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Coba Lagi"),
                  ),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),

          child: Column(
            children: [
              Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).cardColor,
                ),

                child: Align(
                  alignment: Alignment.centerLeft,

                  child: TextField(
                    onChanged: (v) => searchQuery.value = v,
                    style: const TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: HexColor.fromHex("#7c97a6"),
                      ),

                      hintText: "Cari Dzikir...",

                      hintStyle: TextStyle(
                        color: HexColor.fromHex("#7c97a6"),
                        fontSize: 14,
                      ),

                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Expanded(
                child: Obx(() {
                  final list = filteredCategories;

                  return ListView.builder(
                    itemCount: list.length,

                    itemBuilder: (context, index) {
                      final category = list[index];
                      final count = itemCount(category);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),

                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => DzikirListScreen(category: category),
                              transition: Transition.rightToLeft,
                            );
                          },

                          child: Container(
                            height: 80,

                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16),
                            ),

                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    contentPadding:
                                        const EdgeInsets.only(left: 16),

                                    leading: Container(
                                      height: 45,
                                      width: 45,

                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12),

                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),

                                      child: Center(
                                        child: Icon(
                                          Icons.auto_awesome_mosaic_rounded,
                                          size: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),

                                    title: Text(
                                      category,

                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.fontSize,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.color,
                                      ),

                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),

                                    subtitle: Text(
                                      "$count Dzikir",

                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.fontSize,

                                        color: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.color,
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    color: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.color,
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
