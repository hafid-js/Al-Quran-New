import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:alquran_new/core/widgets/error_view.dart';
import 'package:alquran_new/core/widgets/loading.dart';
import 'package:alquran_new/core/widgets/settings_slider.dart';
import 'package:alquran_new/core/widgets/settings_switch.dart';
import 'package:alquran_new/features/dzikir/controllers/matsurat_controller.dart';
import 'package:alquran_new/features/dzikir/widgets/dzikir_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailMatsuratScreen extends StatefulWidget {
  final String type;
  const DetailMatsuratScreen({super.key, required this.type});

  @override
  State<DetailMatsuratScreen> createState() => _DetailMatsuratScreenState();
}

class _DetailMatsuratScreenState extends State<DetailMatsuratScreen>
    with SingleTickerProviderStateMixin {
  late final MatsuratController controller;
  List<GlobalKey> _cardKeys = [];
  late AnimationController _animationController;
  late Animation<double> _rotation;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    controller = Get.put(MatsuratController(type: widget.type));

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _rotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scale = Tween<double>(begin: 1, end: 1.25).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    Get.delete<MatsuratController>();
    _animationController.dispose();
    super.dispose();
  }

  void _syncCardKeys() {
    if (_cardKeys.length != controller.data.length) {
      _cardKeys = List.generate(controller.data.length, (_) => GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
      final isLandscape =
    MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      extendBody: true,
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
              surfaceTintColor: Colors.transparent,
         expandedHeight: Responsive.boxSize(
  context,
  phone: isLandscape
    ? 150
    : 130,
) * (MediaQuery.of(context).size.height > 600 ? 1 : 1),
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
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text("Gulir untuk mebaca seluruh dzikir"),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                _animationController.forward();
                                await WoltModalSheet.show(
                                  context: context,
                                  pageListBuilder: (context) => [
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
                                                    SettingsSlider(
                                                      label: "Ukuran Teks Arab",
                                                      value: controller
                                                          .ukuranTeksArab
                                                          .value,
                                                      onChanged: (value) {
                                                        modalSetState(() {
                                                          controller
                                                                  .ukuranTeksArab
                                                                  .value =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(height: 5),
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
                                                                  .value =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(height: 5),
                                                    SettingsSwitchTile(
                                                      title: "Tampilan Latin",
                                                      value: controller
                                                          .latin
                                                          .value,
                                                      onChanged: (value) {
                                                        modalSetState(() {
                                                          controller
                                                                  .latin
                                                                  .value =
                                                              value;
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
                                                      title:
                                                          "Tampilan Terjemah",
                                                      value: controller
                                                          .terjemah
                                                          .value,
                                                      onChanged: (value) {
                                                        modalSetState(() {
                                                          controller
                                                                  .terjemah
                                                                  .value =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(height: 5),
                                                    SettingsSwitchTile(
                                                      title: "Getar Saat Tap",
                                                      value: controller
                                                          .getar
                                                          .value,
                                                      onChanged: (value) {
                                                        modalSetState(() {
                                                          controller
                                                                  .getar
                                                                  .value =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(height: 5),
                                                    SettingsSwitchTile(
                                                      title:
                                                          "Tampilkan Tasbih Scroll",
                                                      value: controller
                                                          .tasbih
                                                          .value,
                                                      onChanged: (value) {
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
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                                if (mounted) {
                                  await _animationController.reverse();
                                }
                              },
                              child: RotationTransition(
                                turns: _rotation,
                                child: ScaleTransition(
                                  scale: _scale,
                                  child: Icon(
                                    Icons.settings_rounded,
                                    color: Colors.white,
                                    size: Responsive.iconSize(
                                      context,
                                      phone: 22,
                                    ),
                                  ),
                                ),
                              ),
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
                          child: DzikirCard(
                            key: _cardKeys.isNotEmpty ? _cardKeys[i] : null,
                            ukuranTeksArab: controller.ukuranTeksArab.value,
                            ukuranTeksLatinTerjemah:
                                controller.ukuranLatinTerjemah.value,
                            showLatin: controller.latin.value,
                            showTerjemah: controller.terjemah.value,
                            dibaca: item["dibaca"],
                            title: item["title"],
                            hitung: controller.hitungList.isNotEmpty
                                ? controller.hitungList[i]
                                : 0,
                            jumlah: item["jumlah"],
                            arab: item["arab"],
                            isBold: controller.arabBold.value,
                            latin: item["latin"],
                            arti: item["arti"],
                            onIncrement: () =>
                                controller.onCardTap(i, _cardKeys),
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
        () => controller.tasbih.value
            ? SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () => controller.onTasbihTap(_cardKeys),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        border: BoxBorder.all(
                          width: 1.5,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(100),
                        ),
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: CircularPercentIndicator(
                        animateFromLastPercent: true,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(20),
                        backgroundWidth: 9,
                        radius: 45,
                        lineWidth: 4,
                        percent:
                            controller.hitungList.isNotEmpty &&
                                controller.currentIndex.value <
                                    controller.data.length
                            ? (controller.hitungList[controller
                                          .currentIndex
                                          .value] /
                                      (controller.data[controller
                                              .currentIndex
                                              .value]["jumlah"]
                                          as int))
                                  .clamp(0.0, 1.0)
                            : 0.0,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Theme.of(context).colorScheme.primary,
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
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
