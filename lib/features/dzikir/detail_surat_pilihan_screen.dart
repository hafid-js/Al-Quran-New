import 'package:alquran_new/core/ui/loading.dart';
import 'package:alquran_new/features/dzikir/controllers/matsurat_controller.dart';
import 'package:alquran_new/features/dzikir/widgets/surat_pilihan_card.dart';
import 'package:alquran_new/features/surat/controllers/detail_surah_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailSuratPilihanScreen extends StatefulWidget {
  final String type;
  const DetailSuratPilihanScreen({super.key, this.type = 'pagi_sugro'});

  @override
  State<DetailSuratPilihanScreen> createState() =>
      _DetailSuratPilihanScreenState();
}

class _DetailSuratPilihanScreenState extends State<DetailSuratPilihanScreen> {
  final controller = Get.find<DetailSurahController>();
  List<GlobalKey> _cardKeys = [];

  late int nomor;
  late int targetAyat;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map;

    nomor = args["surah"];
    targetAyat = args["ayat"] ?? 0;

    controller.fetchDetailSurah(nomor);
    controller.fetchTafsirAyat(nomor);
  }

  @override
  void dispose() {
    Get.delete<MatsuratController>();
    super.dispose();
  }

  void _syncCardKeys(int ayatLength) {
    if (_cardKeys.length != ayatLength) {
      _cardKeys = List.generate(ayatLength, (_) => GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loading();
        }
        final data = controller.detailSurah.value;
        if (data == null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text("Detail Surah"),
            ),
            body: const Center(child: Text("Data kosong")),
          );
        }
        _syncCardKeys(data.ayat.length);
        if (controller.isLoading.value) {
          return Loading();
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
                            Column(
                              children: [
                                Text(
                                  controller.detailSurah.value!.namaLatin,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text("Gulir untuk mebaca seluruh dzikir"),
                              ],
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
                                                padding: const EdgeInsets.all(
                                                  16,
                                                ),
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
                                                                  FontWeight
                                                                      .bold,
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
                                                            Icons
                                                                .remove_rounded,
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
                                                                Icons
                                                                    .add_rounded,
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
                                                            Icons
                                                                .remove_rounded,
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
                                                                Icons
                                                                    .add_rounded,
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
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                        ),
                                                        Switch(
                                                          value: controller
                                                              .latin
                                                              .value,
                                                          activeThumbColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          onChanged: (bool value) {
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
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
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
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                        ),
                                                        Switch(
                                                          value: controller
                                                              .getar
                                                              .value,
                                                          activeThumbColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          onChanged: (bool value) {
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
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                        ),
                                                        Switch(
                                                          value: controller
                                                              .tasbih
                                                              .value,
                                                          activeThumbColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          onChanged: (bool value) {
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
                      const SizedBox(height: 10),
                      ...List.generate(data.ayat.length, (i) {
                        final ayat = data.ayat[i];

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: i < data.ayat.length - 1 ? 10 : 0,
                          ),
                          child: SuratPilihanCard(
                            ayat: ayat,
                            key: _cardKeys.isNotEmpty ? _cardKeys[i] : null,
                            nomorAyat: ayat.nomorAyat,
                            ukuranTeksArab: controller.ukuranTeksArab.value,
                            ukuranTeksLatinTerjemah:
                                controller.ukuranLatinTerjemah.value,
                            nama: data.nama,
                            teksArab: ayat.teksArab,
                            teksLatin: ayat.teksLatin,
                            teksIndonesia: ayat.teksIndonesia,
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
      }),
    );
  }
}
