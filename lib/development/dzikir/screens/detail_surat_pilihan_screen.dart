import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:alquran_new/development/shared/widgets/common_empty_widget.dart';
import 'package:alquran_new/development/shared/widgets/settings_slider.dart';
import 'package:alquran_new/development/shared/widgets/shimmer_detail_surah.dart';
import 'package:alquran_new/development/shared/widgets/settings_switch.dart';
import 'package:alquran_new/development/dzikir/widgets/surat_pilihan_card.dart';
import 'package:alquran_new/development/alquran/controllers/detail_surah_controller.dart';
import 'package:alquran_new/development/shared/widgets/shimmer_dzikir_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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

  bool _isRotated = false;

  void _toggle() {
    setState(() {
      _isRotated = !_isRotated;
    });

    if (_isRotated) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const ShimmerDzikirGrid();
        }
        final data = controller.detailSurah.value;
        if (data == null) {
          return CommonEmptyWidget(
            refresh: () => controller.fetchDetailSurah(nomor),
          );
        }
        _syncCardKeys(data.ayat.length);

        return RefreshIndicator(
          backgroundColor: isDark ? Theme.of(context).cardColor : AppColors.primary,
          color: AppColors.secondary,
          onRefresh: () =>
              controller.fetchDetailSurah(nomor, forceRefresh: true),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: false,
                floating: true,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                expandedHeight:
                    Responsive.boxSize(
                      context,
                      phone: isLandscape ? 150 : 130,
                    ) *
                    (MediaQuery.of(context).size.height > 600 ? 1 : 1),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                      left: 10,
                      bottom: 16,
                      top: 60,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 12,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: isDark
                                              ? null
                                              : AppColors.textPrimaryLight,
                                        ),
                                  ),
                                  Text(
                                    "Gulir untuk mebaca seluruh dzikir",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  _toggle();

                                  await WoltModalSheet.show(
                                    context: context,
                                    pageListBuilder: (context) => [
                                      SliverWoltModalSheetPage(
                                        backgroundColor: isDark
                                            ? Theme.of(context).cardColor
                                            : Colors.white,
                                        surfaceTintColor: isDark
                                            ? Theme.of(context).cardColor
                                            : Colors.white,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          "Pengaturan",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: isDark
                                                                    ? AppColors
                                                                          .textPrimaryDark
                                                                    : AppColors
                                                                          .primary,
                                                              ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      SettingsSwitchTile(
                                                        title: "Terjemah",
                                                        value: controller
                                                            .terjemah
                                                            .value,
                                                        onChanged: (v) {
                                                          modalSetState(() {
                                                            controller
                                                                    .terjemah
                                                                    .value =
                                                                v;
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(height: 5),

                                                      SettingsSwitchTile(
                                                        title: "Latin",
                                                        value: controller
                                                            .latin
                                                            .value,
                                                        onChanged: (v) {
                                                          modalSetState(() {
                                                            controller
                                                                    .latin
                                                                    .value =
                                                                v;
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(height: 5),

                                                      SettingsSwitchTile(
                                                        title:
                                                            "Font Arab Tebal",
                                                        value: controller
                                                            .arabBold
                                                            .value,
                                                        onChanged: (v) {
                                                          modalSetState(() {
                                                            controller
                                                                    .arabBold
                                                                    .value =
                                                                v;
                                                          });
                                                        },
                                                      ),

                                                      const SizedBox(
                                                        height: 18,
                                                      ),
                                                      SettingsSlider(
                                                        label:
                                                            "Ukuran Teks Arab",
                                                        value: controller
                                                            .ukuranTeksArab
                                                            .value,
                                                        onChanged: (v) {
                                                          modalSetState(() {
                                                            controller
                                                                    .ukuranTeksArab
                                                                    .value =
                                                                v;
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        height: 14,
                                                      ),
                                                      SettingsSlider(
                                                        label:
                                                            "Ukuran Teks latin & Terjemah",
                                                        value: controller
                                                            .ukuranLatinTerjemah
                                                            .value,
                                                        onChanged: (v) {
                                                          modalSetState(() {
                                                            controller
                                                                    .ukuranLatinTerjemah
                                                                    .value =
                                                                v;
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
                                    _toggle();
                                  }
                                },
                                child: RotationTransition(
                                  turns: _rotation,
                                  child: ScaleTransition(
                                    scale: _scale,
                                    child: Icon(
                                      _isRotated
                                          ? Iconsax.setting_45
                                          : Iconsax.setting_4,
                                      color: isDark
                                          ? AppColors.textPrimaryDark
                                          : AppColors.textPrimaryLight,
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
          ),
        );
      }),
    );
  }
}
