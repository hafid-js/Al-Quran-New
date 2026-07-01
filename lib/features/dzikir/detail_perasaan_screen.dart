import 'package:alquran_new/core/ui/loading.dart';
import 'package:alquran_new/features/dzikir/controllers/doa_perasaan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Obx(() {
      _syncCardKeys();
      if (controller.isLoading.value) {
        return Loading();
      }

      if (controller.data.isEmpty || controller.error.isNotEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_off_rounded,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  controller.error.value,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: controller.fetchData,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Coba Lagi"),
                ),
              ],
            ),
          ),
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
                                                  Text(
                                                    "Ukuran Teks Arab",
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.titleSmall,
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          modalSetState(() {
                                                            if (controller
                                                                    .ukuranTeksArab
                                                                    .value >
                                                                10)
                                                              controller
                                                                  .ukuranTeksArab
                                                                  .value--;
                                                          });
                                                        },
                                                        icon: const Icon(
                                                          Icons.remove_rounded,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Slider(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          value: controller
                                                              .ukuranTeksArab
                                                              .value,
                                                          max: 30,
                                                          divisions: 30,
                                                          label: controller
                                                              .ukuranTeksArab
                                                              .value
                                                              .round()
                                                              .toString(),
                                                          onChanged: (value) {
                                                            modalSetState(() {
                                                              controller
                                                                      .ukuranTeksArab
                                                                      .value =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              modalSetState(() {
                                                                if (controller
                                                                        .ukuranTeksArab
                                                                        .value <
                                                                    30)
                                                                  controller
                                                                      .ukuranTeksArab
                                                                      .value++;
                                                              });
                                                            },
                                                            icon: const Icon(
                                                              Icons.add_rounded,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${controller.ukuranTeksArab.value.toInt()}pt",
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    "Ukuran Teks latin & Terjemah",
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.titleSmall,
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          modalSetState(() {
                                                            if (controller
                                                                    .ukuranLatinTerjemah
                                                                    .value >
                                                                10)
                                                              controller
                                                                  .ukuranLatinTerjemah
                                                                  .value--;
                                                          });
                                                        },
                                                        icon: const Icon(
                                                          Icons.remove_rounded,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Slider(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          value: controller
                                                              .ukuranLatinTerjemah
                                                              .value,
                                                          max: 30,
                                                          divisions: 30,
                                                          label: controller
                                                              .ukuranLatinTerjemah
                                                              .value
                                                              .round()
                                                              .toString(),
                                                          onChanged: (value) {
                                                            modalSetState(() {
                                                              controller
                                                                      .ukuranLatinTerjemah
                                                                      .value =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              modalSetState(() {
                                                                if (controller
                                                                        .ukuranLatinTerjemah
                                                                        .value <
                                                                    30)
                                                                  controller
                                                                      .ukuranLatinTerjemah
                                                                      .value++;
                                                              });
                                                            },
                                                            icon: const Icon(
                                                              Icons.add_rounded,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${controller.ukuranLatinTerjemah.value.toInt()}pt",
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Tampilan Latin",
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.titleSmall,
                                                      ),
                                                      Switch(
                                                        value: controller
                                                            .latin
                                                            .value,
                                                        activeThumbColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        onChanged:
                                                            (bool value) {
                                                              modalSetState(() {
                                                                controller
                                                                        .latin
                                                                        .value =
                                                                    value;
                                                              });
                                                            },
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Tampilan Terjemah",
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.titleSmall,
                                                      ),
                                                      Switch(
                                                        value: controller
                                                            .terjemah
                                                            .value,
                                                        activeThumbColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        onChanged: (bool value) {
                                                          modalSetState(() {
                                                            controller
                                                                    .terjemah
                                                                    .value =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Getar Saat Tap",
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.titleSmall,
                                                      ),
                                                      Switch(
                                                        value: controller
                                                            .getar
                                                            .value,
                                                        activeThumbColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        onChanged:
                                                            (bool value) {
                                                              modalSetState(() {
                                                                controller
                                                                        .getar
                                                                        .value =
                                                                    value;
                                                              });
                                                            },
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Tampilkan Tasbih Scroll",
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.titleSmall,
                                                      ),
                                                      Switch(
                                                        value: controller
                                                            .tasbih
                                                            .value,
                                                        activeThumbColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        onChanged:
                                                            (bool value) {
                                                              modalSetState(() {
                                                                controller
                                                                        .tasbih
                                                                        .value =
                                                                    value;
                                                              });
                                                            },
                                                      ),
                                                    ],
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
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: i < controller.data.length - 1 ? 10 : 0,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary.withAlpha(80),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Data Ke-${item.nomor}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(fontSize: 11),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.copy_rounded),
                                        onPressed: () async {
                                          final copyText =
                                              '''
$item['arab']
$item['latin]
$item['arti]

💡 Faedah/Konteks: $item['keterangan']

📚 Sumber:
$item['sumber']
''';

                                          await Clipboard.setData(
                                            ClipboardData(text: copyText),
                                          );

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 5,
                                              ),
                                              duration: const Duration(
                                                seconds: 1,
                                              ),
                                              backgroundColor: Theme.of(
                                                context,
                                              ).cardColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              content: Text(
                                                'Berhasil Disalin',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.share_rounded),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 18),
                                  child: Text(
                                    item.arab,
                                    softWrap: true,
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontFamily: 'Uthmanic',
                                          height: 2,
                                          fontSize:
                                              controller.ukuranTeksArab.value,
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                item.latin,
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(
                                      fontSize:
                                          controller.ukuranLatinTerjemah.value,
                                      fontFamily: "Uthmanic",
                                    ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                item.arti,
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      fontSize:
                                          controller.ukuranLatinTerjemah.value,
                                      fontFamily: "Uthmanic",
                                    ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: double.infinity,

                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      width: 3,
                                      color: Colors.amber,
                                    ),
                                  ),

                                  color: Colors.amber.withAlpha(10),

                                  borderRadius: BorderRadius.circular(12),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(16),

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "💡Faedah/Konteks: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: controller
                                                        .ukuranLatinTerjemah
                                                        .value,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: item.keterangan,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontSize: controller
                                                        .ukuranLatinTerjemah
                                                        .value,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(height: 10),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "📚 Sumber: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: controller
                                                        .ukuranLatinTerjemah
                                                        .value,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: item.sumber,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontSize: controller
                                                        .ukuranLatinTerjemah
                                                        .value,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ]),
          ),
        ],
      );
    });
  }
}
