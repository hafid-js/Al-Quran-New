import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/ui/loading.dart';
import 'package:alquran_new/core/utils/constants/shadow_extension.dart';
import 'package:alquran_new/features/doa/controllers/doa_controller.dart';
import 'package:alquran_new/features/doa/widgets/category_filter.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  final DoaController controller = Get.put(DoaController());
  final SettingsController setting = Get.find<SettingsController>();

  String? activeCategory;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Doa", style: Theme.of(context).textTheme.titleLarge),

                Obx(() {
                  if (controller.isLoading.value) {
                    return const SizedBox(height: 10);
                  }

                  return Text(
                    "${controller.doaList.length} Doa",
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

                        child: Align(
                          alignment: Alignment.centerLeft,

                          child: TextField(
                            onChanged: controller.search,
                            style: const TextStyle(color: Colors.white),

                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.search,
                                color: HexColor.fromHex("#7c97a6"),
                              ),

                              hintText: "Cari Doa...",

                              hintStyle: TextStyle(
                                color: HexColor.fromHex("#7c97a6"),
                                fontSize: 14,
                              ),

                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Obx(() {
                  final categories =
                      controller.doaList.map((e) => e.grup).toSet().toList()
                        ..sort();

                  return CategoryFilter(
                    categories: categories,
                    activeCategory: controller.activeCategory.value,
                    onCategorySelected: (category) {
                      controller.filter(category, null);
                    },
                  );
                }),

                const SizedBox(height: 10),

                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: controller.filteredDoa.length,

                      itemBuilder: (context, index) {
                        final doa = controller.filteredDoa[index];
                        final selectedIndex = setting.fontSelected.value;
                        final fontFamily = fontArabs[selectedIndex]["title"];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                WoltModalSheet.show(
                                  context: context,

                                  pageListBuilder: (bottomSheetContext) => [
                                    SliverWoltModalSheetPage(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).cardColor,

                                      hasTopBarLayer: false,

                                      mainContentSliversBuilder: (context) => [
                                        SliverToBoxAdapter(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 20,
                                              left: 20,
                                              top: 25,
                                            ),

                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,

                                              children: [
                                                Text(
                                                  doa.nama,

                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.titleMedium,
                                                ),

                                                const SizedBox(height: 5),

                                                Text(
                                                  doa.grup,

                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.labelSmall,
                                                ),

                                                const SizedBox(height: 20),

                                                Container(
                                                  width: double.infinity,

                                                  decoration: BoxDecoration(
                                                    color: isDark
                                                        ? HexColor.fromHex(
                                                            "#0b1d26",
                                                          )
                                                        : Theme.of(
                                                            context,
                                                          ).colorScheme.surface,
                                                    boxShadow:
                                                        context.shadow.small,

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),

                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          16,
                                                        ),

                                                    child: Text(
                                                      doa.ar,

                                                      style: TextStyle(
                                                        fontFamily: fontFamily,
                                                        fontSize: 27,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.color,
                                                        height: 2,
                                                      ),

                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 20),

                                                Text(
                                                  doa.tr,

                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                                  ),
                                                ),

                                                const SizedBox(height: 20),

                                                Text(
                                                  doa.idn,

                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.labelMedium,
                                                ),

                                                const SizedBox(height: 20),

                                                Container(
                                                  width: double.infinity,

                                                  decoration: BoxDecoration(
                                                    border: const Border(
                                                      left: BorderSide(
                                                        width: 3,
                                                        color: Colors.amber,
                                                      ),
                                                    ),

                                                    color: Colors.amber
                                                        .withAlpha(10),

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),

                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          16,
                                                        ),

                                                    child: Text(
                                                      doa.tentang,

                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.labelMedium,

                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 20),
                                                Wrap(
                                                  spacing: 6,
                                                  runSpacing: 6,
                                                  children: doa.tag.map((tag) {
                                                    return Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                            vertical: 6,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withAlpha(30),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        tag,
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.labelMedium,
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                                const SizedBox(height: 20),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },

                              child: Container(
                                height: 80,

                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  boxShadow: context.shadow.small,
                                  borderRadius: BorderRadius.circular(16),
                                ),

                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.only(
                                          left: 16,
                                        ),

                                        leading: Container(
                                          height: 45,
                                          width: 45,

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),

                                            color: Theme.of(
                                              context,
                                            ).colorScheme.surface,
                                            boxShadow: context.shadow.small,
                                          ),

                                          child: Center(
                                            child: Text(
                                              doa.id.toString(),

                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.fontSize,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                        ),

                                        title: Text(
                                          doa.nama,

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
                                          doa.grup,

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
                                  ],
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

          Obx(() {
            if (!controller.isLoading.value) {
              return const SizedBox.shrink();
            }

            return const Positioned.fill(child: Loading());
          }),
        ],
      ),
    );
  }
}
