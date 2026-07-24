import 'dart:ui';

import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/widgets/loading.dart';
import 'package:alquran_new/development/settings_slider.dart';
import 'package:alquran_new/development/settings_switch.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/features/surat/controllers/detail_surah_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailSurahScreen extends StatefulWidget {
  const DetailSurahScreen({super.key});

  @override
  State<DetailSurahScreen> createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<DetailSurahController>();
  final SettingsController setting = Get.find<SettingsController>();
  final ItemScrollController itemScrollController = ItemScrollController();

  late int nomor;
  late int targetAyat;
  late AnimationController _animationController;
  late Animation<double> _rotation;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map;
    nomor = args["surah"];
    targetAyat = args["ayat"] ?? 0;

    controller.fetchDetailSurah(nomor);
    controller.fetchTafsirAyat(nomor);

    void scrollOnReady(dynamic _) {
      if (targetAyat <= 0) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 300), () {
          itemScrollController.scrollTo(
            index: targetAyat + 1,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOutCubic,
            alignment: 0.2,
          );
        });
      });
    }

    ever(controller.detailSurah, scrollOnReady);

    if (controller.detailSurah.value != null) {
      scrollOnReady(null);
    }

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

  @override
  Widget build(BuildContext context) {
    final selectedIndex = setting.fontSelected.value;
    final fontFamily = fontArabs[selectedIndex]["title"];
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Obx(() {
          final data = controller.detailSurah.value;
          return Text(
            data?.namaLatin ?? "Quran",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: Colors.black),
          );
        }),
        centerTitle: true,
        actions: [
          Icon(Iconsax.book_1, color: Colors.black),
          SizedBox(width: 15),

          GestureDetector(
            onTap: () async {
              _toggle();

              await WoltModalSheet.show(
  // modalDecorator: (child) {
  //   return BackdropFilter(
  //     filter: ImageFilter.blur(
  //       sigmaX: 3,
  //       sigmaY: 3,
  //     ),
  //     child: child,
  //   );
  // },
                context: context,
                pageListBuilder: (context) => [
                  SliverWoltModalSheetPage(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    hasTopBarLayer: false,
                    mainContentSliversBuilder: (context) => [
                      SliverToBoxAdapter(
                        child: StatefulBuilder(
                          builder: (context, modalSetState) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Pengaturan",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: HexColor.fromHex("#256980"),
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SettingsSwitchTile(
                                    title: "Terjemah",
                                    value: controller.terjemah.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        controller.terjemah.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 5),

                                  SettingsSwitchTile(
                                    title: "Latin",
                                    value: controller.latin.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        controller.latin.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 5),

                                  SettingsSwitchTile(
                                    title: "Font Arab Tebal",
                                    value: controller.arabBold.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        controller.arabBold.value = v;
                                      });
                                    },
                                  ),

                                  const SizedBox(height: 18),
                                  SettingsSlider(
                                    label: "Ukuran Teks Arab",
                                    value: controller.ukuranTeksArab.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        controller.ukuranTeksArab.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  SettingsSlider(
                                    label: "Ukuran Teks latin & Terjemah",
                                    value: controller.ukuranLatinTerjemah.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        controller.ukuranLatinTerjemah.value =
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
                  _isRotated ? Iconsax.setting_45 : Iconsax.setting_4,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.all(16),
      ), 
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
  child: Image.asset(
    'assets/animations/bar_loader.gif',
    width: 120,
    height: 120,
  ),
);
        }

        final data = controller.detailSurah.value;

        if (data == null) {
          return Center(child: Text("Data kosong"));
        }

        return ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          itemCount: data.ayat.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#256980"),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "Surah:",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text.rich(
                                    TextSpan(
                                      text: data.namaLatin,
                                      style: TextStyle(
                                        color: HexColor.fromHex("#D39D52"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "Arti:",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text.rich(
                                    TextSpan(
                                      text: data.arti,
                                      style: TextStyle(
                                        color: HexColor.fromHex("#D39D52"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "Jumlah Ayat:",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text.rich(
                                    TextSpan(
                                      text: data.jumlahAyat.toString(),
                                      style: TextStyle(
                                        color: HexColor.fromHex("#D39D52"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "Tempat Turun:",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text.rich(
                                    TextSpan(
                                      text: data.tempatTurun,
                                      style: TextStyle(
                                        color: HexColor.fromHex("#D39D52"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -15,
                      right: -5,
                      child: SvgPicture.asset(
                        width: 140,
                        height: 140,
                        "assets/svg_arab_kaligrafi/Surah_${data.nomor}_of_114.svg",
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (index == 1) {
              if (data.namaLatin == "Al-Fatihah") {
                return SizedBox.shrink();
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    children: [
                      Container(
                        height: 55,
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Positioned(
                        top: -30,
                        right: 90,
                        child: Image.asset(
                          "assets/images/bismillah.png",
                          height: 90,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              }
            }

            final ayat = data.ayat[index - 2];

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${ayat.nomorAyat}",
                      style: TextStyle(
                        color: HexColor.fromHex("#D39D52"),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(() {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ayat.teksArab,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: controller.ukuranTeksArab.value,
                            fontFamily: fontFamily,
                            fontWeight: controller.arabBold.value
                                ? FontWeight.w600
                                : null,
                            height: 2.5,
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 30),
                    Obx(() {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ayat.teksLatin,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: controller.ukuranLatinTerjemah.value,
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 5),
                    Obx(() {
                      return Text(
                        ayat.teksIndonesia,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: controller.ukuranLatinTerjemah.value,
                        ),
                      );
                    }),
                    Divider(
                      thickness: 1,
                      color: const Color.fromARGB(81, 158, 158, 158),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(37, 158, 158, 158),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Iconsax.copy,
                              color: HexColor.fromHex("#504F52"),
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(37, 158, 158, 158),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Iconsax.save_2,
                              color: HexColor.fromHex("#504F52"),
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(37, 158, 158, 158),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Iconsax.play_circle,
                              color: HexColor.fromHex("#504F52"),
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(37, 158, 158, 158),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Iconsax.export_2,
                              color: HexColor.fromHex("#504F52"),
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(37, 158, 158, 158),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Iconsax.info_circle,
                              color: HexColor.fromHex("#504F52"),
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
