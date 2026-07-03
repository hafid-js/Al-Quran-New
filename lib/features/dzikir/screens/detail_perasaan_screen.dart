import 'package:alquran_new/core/widgets/error_view.dart';
import 'package:alquran_new/core/widgets/loading.dart';
import 'package:alquran_new/core/widgets/settings_slider.dart';
import 'package:alquran_new/core/widgets/settings_switch.dart';
import 'package:alquran_new/features/dzikir/controllers/doa_perasaan_controller.dart';
import 'package:alquran_new/features/dzikir/widgets/detail_perasaan_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailPerasaanScreen extends StatefulWidget {
  final String type;
  const DetailPerasaanScreen({super.key, required this.type});

  @override
  State<DetailPerasaanScreen> createState() => _DetailPerasaanScreenState();
}

class _DetailPerasaanScreenState extends State<DetailPerasaanScreen> {
  late final DoaPerasaanController controller;
  List<GlobalKey> _cardKeys = [];

  @override
  void initState() {
    super.initState();
    controller = Get.put(DoaPerasaanController(type: widget.type));
  }

  @override
  void dispose() {
    Get.delete<DetailPerasaanScreen>();
    super.dispose();
  }

  void _syncCardKeys() {
    if (_cardKeys.length != controller.data.length) {
      _cardKeys = List.generate(controller.data.length, (_) => GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Obx(() {
      _syncCardKeys();
      if (controller.isLoading.value) {
        return Loading();
      }

      if (controller.data.isEmpty || controller.error.isNotEmpty) {
        return ErrorView(
          message: controller.error.value,
          onRetry: controller.fetchData,
        );
      }

      return CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            backgroundColor: Colors.transparent,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(
                  right: 16,
                  left: 16,
                  bottom: 16,
                  top: 80,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(Icons.arrow_back_ios),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  controller.title,
                                  style: Theme.of(context).textTheme.titleSmall,

                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Gulir untuk membaca seluruh dzikir",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              WoltModalSheet.show(
                                context: context,
                                pageListBuilder: (modalSheetContext) => [
                                  SliverWoltModalSheetPage(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).cardColor,
                                    hasTopBarLayer: false,
                                    mainContentSliversBuilder: (context) => [
                                      SliverToBoxAdapter(
                                        child: StatefulBuilder(
                                          builder: (context, modalSetState) {
                                            return Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "Pengaturan",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  SettingsSlider(
                                                    label: "Ukuran Teks Arab",
                                                    value: controller
                                                        .ukuranTeksArab.value,
                                                    onChanged: (value) {
                                                      modalSetState(() {
                                                        controller
                                                            .ukuranTeksArab
                                                            .value = value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 20),
                                                  SettingsSlider(
                                                    label:
                                                        "Ukuran Teks latin & Terjemah",
                                                    value: controller
                                                        .ukuranLatinTerjemah
                                                        .value,
                                                    onChanged: (value) {
                                                      modalSetState(() {
                                                        controller
                                                            .ukuranLatinTerjemah
                                                            .value = value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 5),
                                                      SettingsSwitchTile(
                                                        title: "Font Arab Bold",
                                                        value: controller
                                                            .arabBold
                                                            .value,
                                                        onChanged: (value) {
                                                          modalSetState(() {
                                                            controller
                                                                    .arabBold
                                                                    .value =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                  const SizedBox(height: 5),
                                                  SettingsSwitchTile(
                                                    title: "Tampilan Latin",
                                                    value:
                                                        controller.latin.value,
                                                    onChanged: (value) {
                                                      modalSetState(() {
                                                        controller.latin.value =
                                                            value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 5),
                                                  SettingsSwitchTile(
                                                    title: "Tampilan Terjemah",
                                                    value: controller
                                                        .terjemah.value,
                                                    onChanged: (value) {
                                                      modalSetState(() {
                                                        controller.terjemah
                                                            .value = value;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                            child: const Icon(Icons.settings),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ...List.generate(controller.data.length, (i) {
                      final item = controller.data[i];
                      return DetailPerasaanCard(
                        item: item,
                        controller: controller,
                        index: i,
                        itemCount: controller.data.length,
                        ukuranTeksArab: controller.ukuranTeksArab.value,
                        isBold: controller.arabBold.value,
                        ukuranTeksLatinTerjemah: controller.ukuranLatinTerjemah.value,
                      );
                    }),
                  ],
                ),
              ),
            ]),
          ),
        ],
      );
    }),
    );
  }
}
