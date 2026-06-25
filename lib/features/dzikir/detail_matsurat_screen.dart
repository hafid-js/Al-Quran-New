import 'package:alquran_new/features/dzikir/controllers/matsurat_controller.dart';
import 'package:alquran_new/features/dzikir/widgets/dzikir_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailMatsuratScreen extends StatefulWidget {
  final String type;
  const DetailMatsuratScreen({super.key, this.type = 'pagi_sugro'});

  @override
  State<DetailMatsuratScreen> createState() => _DetailMatsuratScreenState();
}

class _DetailMatsuratScreenState extends State<DetailMatsuratScreen> {
  late final MatsuratController controller;
  List<GlobalKey> _cardKeys = [];

  @override
  void initState() {
    super.initState();
    controller = Get.put(MatsuratController(type: widget.type));
  }

  @override
  void dispose() {
    Get.delete<MatsuratController>();
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
        if (controller.isLoading.value || controller.error.value.isNotEmpty) {
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
                    child: Container(
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
                          Text(
                            controller.title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(width: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Center(
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.cloud_off_rounded,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                controller.error.value,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () {
                                  controller.fetchData();
                                },
                                icon: Icon(Icons.refresh),
                                label: Text("Coba Lagi"),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
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
                            Column(
                              children: [
                                Text(
                                  controller.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall,
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
                                                padding:
                                                    const EdgeInsets.all(16),
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            modalSetState(
                                                              () {
                                                                if (controller
                                                                        .ukuranTeksArab
                                                                        .value >
                                                                    10)
                                                                  controller
                                                                      .ukuranTeksArab
                                                                      .value--;
                                                              },
                                                            );
                                                          },
                                                          icon: const Icon(Icons
                                                              .remove_rounded),
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
                                                            onChanged:
                                                                (value) {
                                                              modalSetState(
                                                                () {
                                                                  controller
                                                                          .ukuranTeksArab
                                                                          .value =
                                                                      value;
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                modalSetState(
                                                                  () {
                                                                    if (controller
                                                                            .ukuranTeksArab
                                                                            .value <
                                                                        30)
                                                                      controller
                                                                          .ukuranTeksArab
                                                                          .value++;
                                                                  },
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                  Icons
                                                                      .add_rounded),
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            modalSetState(
                                                              () {
                                                                if (controller
                                                                        .ukuranLatinTerjemah
                                                                        .value >
                                                                    10)
                                                                  controller
                                                                      .ukuranLatinTerjemah
                                                                      .value--;
                                                              },
                                                            );
                                                          },
                                                          icon: const Icon(Icons
                                                              .remove_rounded),
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
                                                            onChanged:
                                                                (value) {
                                                              modalSetState(
                                                                () {
                                                                  controller
                                                                          .ukuranLatinTerjemah
                                                                          .value =
                                                                      value;
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                modalSetState(
                                                                  () {
                                                                    if (controller
                                                                            .ukuranLatinTerjemah
                                                                            .value <
                                                                        30)
                                                                      controller
                                                                          .ukuranLatinTerjemah
                                                                          .value++;
                                                                  },
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                  Icons
                                                                      .add_rounded),
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
                                                                  context)
                                                              .textTheme
                                                              .titleSmall,
                                                        ),
                                                        Switch(
                                                          value: controller
                                                              .latin.value,
                                                          activeThumbColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          onChanged:
                                                              (bool value) {
                                                            modalSetState(
                                                              () {
                                                                controller
                                                                        .latin
                                                                        .value =
                                                                    value;
                                                              },
                                                            );
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
                                                                  context)
                                                              .textTheme
                                                              .titleSmall,
                                                        ),
                                                        Switch(
                                                          value: controller
                                                              .terjemah.value,
                                                          activeThumbColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          onChanged:
                                                              (bool value) {
                                                            modalSetState(
                                                              () {
                                                                controller
                                                                        .terjemah
                                                                        .value =
                                                                    value;
                                                              },
                                                            );
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
                                                                  context)
                                                              .textTheme
                                                              .titleSmall,
                                                        ),
                                                        Switch(
                                                          value: controller
                                                              .getar.value,
                                                          activeThumbColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          onChanged:
                                                              (bool value) {
                                                            modalSetState(
                                                              () {
                                                                controller
                                                                        .getar
                                                                        .value =
                                                                    value;
                                                              },
                                                            );
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
                                                                  context)
                                                              .textTheme
                                                              .titleSmall,
                                                        ),
                                                        Switch(
                                                          value: controller
                                                              .tasbih.value,
                                                          activeThumbColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          onChanged:
                                                              (bool value) {
                                                            modalSetState(
                                                              () {
                                                                controller
                                                                        .tasbih
                                                                        .value =
                                                                    value;
                                                              },
                                                            );
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
                      ...List.generate(controller.data.length, (i) {
                        final item = controller.data[i];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: i < controller.data.length - 1 ? 10 : 0,
                          ),
                          child: DzikirCard(
                            key: _cardKeys.isNotEmpty ? _cardKeys[i] : null,
                            ukuranTeksArab: controller.ukuranTeksArab.value,
                            ukuranTeksLatinTerjemah:
                                controller.ukuranLatinTerjemah.value,
                            dibaca: item["dibaca"],
                            title: item["title"],
                            hitung: controller.hitungList.isNotEmpty
                                ? controller.hitungList[i]
                                : 0,
                            jumlah: item["jumlah"],
                            arab: item["arab"],
                            latin: item["latin"],
                            arti: item["arti"],
                            onIncrement: () => controller.onCardTap(
                              i,
                              _cardKeys,
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
      }),
      bottomNavigationBar: Obx(
        () => SafeArea(
          minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 25),
                decoration: BoxDecoration(
                  border: BoxBorder.all(
                    width: 1,
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withAlpha(100),
                  ),
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withAlpha(18),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child:
                          const Icon(Icons.play_arrow_rounded, size: 30),
                    ),
                    const SizedBox(width: 80),
                    const Icon(Icons.share_rounded),
                  ],
                ),
              ),
              Positioned(
                top: -40,
                child: GestureDetector(
                  onTap: () => controller.onTasbihTap(_cardKeys),
                  child: CircularPercentIndicator(
                    animateFromLastPercent: true,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primary
                        .withAlpha(20),
                    backgroundWidth: 9,
                    radius: 45,
                    lineWidth: 4,
                    percent: controller.hitungList.isNotEmpty &&
                            controller.currentIndex.value <
                                controller.data.length
                        ? (controller.hitungList[
                                    controller.currentIndex.value] /
                                (controller.data[
                                            controller.currentIndex
                                                .value]["jumlah"]
                                        as int))
                            .clamp(0.0, 1.0)
                        : 0.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor:
                        Theme.of(context).colorScheme.primary,
                    center: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 15,
                                left: 17,
                                child: Text(
                                  "${controller.hitungList.isNotEmpty && controller.currentIndex.value < controller.hitungList.length ? controller.hitungList[controller.currentIndex.value] : 0}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              Icon(
                                FlutterIslamicIcons.solidTasbih,
                                size: 48,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
