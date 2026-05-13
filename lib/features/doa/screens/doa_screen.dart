import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/ui/loading.dart';
import 'package:alquran_new/features/doa/controllers/doa_controller.dart';
import 'package:alquran_new/features/doa/widgets/category_filter.dart';
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

  String? activeCategory;

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
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Doa",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Obx(
                  () => Text(
                    "${controller.doaList.length} Doa",
                    style: TextStyle(
                      color: HexColor.fromHex("#7c97a6"),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
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
                      controller.doaList
                          .map((e) => e.grup)
                          .toSet()
                          .toList()
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

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                WoltModalSheet.show(
                                  context: context,

                                  pageListBuilder:
                                      (bottomSheetContext) => [
                                        SliverWoltModalSheetPage(
                                          backgroundColor:
                                              HexColor.fromHex("#132e3a"),

                                          hasTopBarLayer: false,

                                          mainContentSliversBuilder:
                                              (context) => [
                                                SliverToBoxAdapter(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          right: 20,
                                                          left: 20,
                                                          top: 25,
                                                        ),

                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,

                                                      children: [
                                                        Text(
                                                          doa.nama,

                                                          style:
                                                              const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                        ),

                                                        const SizedBox(
                                                          height: 5,
                                                        ),

                                                        Text(
                                                          doa.grup,

                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                HexColor.fromHex(
                                                                  "#7c97a6",
                                                                ),
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),

                                                        Container(
                                                          width:
                                                              double.infinity,

                                                          decoration:
                                                              BoxDecoration(
                                                                color:
                                                                    HexColor.fromHex(
                                                                      "#0c1d27",
                                                                    ),

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

                                                              style:
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        27,
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                    height: 2,
                                                                  ),

                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),

                                                        Text(
                                                          doa.tr,

                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                HexColor.fromHex(
                                                                  "#2dc8b9",
                                                                ),
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),

                                                        Text(
                                                          doa.idn,

                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                HexColor.fromHex(
                                                                  "#7c97a6",
                                                                ),
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),

                                                        Container(
                                                          width:
                                                              double.infinity,

                                                          decoration:
                                                              BoxDecoration(
                                                                border:
                                                                    const Border(
                                                                      left: BorderSide(
                                                                        width:
                                                                            3,
                                                                        color:
                                                                            Colors.amber,
                                                                      ),
                                                                    ),

                                                                color: Colors
                                                                    .amber
                                                                    .withAlpha(
                                                                      10,
                                                                    ),

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

                                                              style: TextStyle(
                                                                color:
                                                                    HexColor.fromHex(
                                                                      "#7c97a6",
                                                                    ),
                                                                height: 2,
                                                              ),

                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),

                                                        ActionChip(
                                                          label: Text(
                                                            "tidur",

                                                            style: TextStyle(
                                                              color:
                                                                  HexColor.fromHex(
                                                                    "#2dc8b9",
                                                                  ),
                                                            ),
                                                          ),

                                                          backgroundColor:
                                                              HexColor.fromHex(
                                                                "#17404a",
                                                              ),
                                                        ),
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
                                  color: HexColor.fromHex("#132e3a"),
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

                                            color: HexColor.fromHex("#17404a"),
                                          ),

                                          child: Center(
                                            child: Text(
                                              doa.id.toString(),

                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: HexColor.fromHex(
                                                  "#2dc8b9",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        title: Text(
                                          doa.nama,

                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),

                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),

                                        subtitle: Text(
                                          doa.grup,

                                          style: TextStyle(
                                            fontSize: 12,
                                            color: HexColor.fromHex("#7c97a6"),
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

            return const Positioned.fill(
              child: Loading(),
            );
          }),
        ],
      ),
    );
  }
}