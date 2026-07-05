import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:alquran_new/core/widgets/loading.dart';
import 'package:alquran_new/core/widgets/settings_slider.dart';
import 'package:alquran_new/core/widgets/settings_switch.dart';
import 'package:alquran_new/features/dzikir/widgets/surat_pilihan_card.dart';
import 'package:alquran_new/features/surat/controllers/detail_surah_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailSuratPilihanScreen extends StatefulWidget {
  const DetailSuratPilihanScreen({super.key});

  @override
  State<DetailSuratPilihanScreen> createState() =>
      _DetailSuratPilihanScreenState();
}

class _DetailSuratPilihanScreenState extends State<DetailSuratPilihanScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<DetailSurahController>();
  List<GlobalKey> _cardKeys = [];
  late AnimationController _animationController;
  late Animation<double> _rotation;
  late Animation<double> _scale;

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
    _animationController.dispose();
    super.dispose();
  }

  void _syncCardKeys(int ayatLength) {
    if (_cardKeys.length != ayatLength) {
      _cardKeys = List.generate(ayatLength, (_) => GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
    MediaQuery.of(context).orientation == Orientation.landscape;
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
                    right: 10,
                    left: 10,
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
                              onTap: () async {
                                _animationController.forward();
                                await WoltModalSheet.show(
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
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
                            isBold: controller.arabBold.value,
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
