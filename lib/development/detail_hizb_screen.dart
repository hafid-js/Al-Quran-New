import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/hizb_controller.dart';
import 'package:alquran_new/development/settings_slider.dart';
import 'package:alquran_new/development/settings_switch.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/features/surat/controllers/detail_surah_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailHizbScreen extends StatefulWidget {
  const DetailHizbScreen({super.key});

  @override
  State<DetailHizbScreen> createState() => _DetailHizbScreenState();
}

class _DetailHizbScreenState extends State<DetailHizbScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(HizbController(), permanent: false);
  final ItemScrollController itemScrollController = ItemScrollController();
  final SettingsController setting = Get.find<SettingsController>();
  final fontController = Get.find<DetailSurahController>();

  late int hizbNumber;
  late AnimationController _animationController;
  late Animation<double> _rotation;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map;
    hizbNumber = args["hizb"];

    controller.fetchHizb(hizbNumber);

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
    if (controller.hizbAyatList.isNotEmpty) {
      controller.stopAudio(controller.hizbAyatList.first);
    }
    Get.delete<HizbController>();
    super.dispose();
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
        title: Text(
          "Hizb $hizbNumber",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),
        ),
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
                                    value: fontController.terjemah.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        fontController.terjemah.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 5),

                                  SettingsSwitchTile(
                                    title: "Latin",
                                    value: fontController.latin.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        fontController.latin.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 5),

                                  SettingsSwitchTile(
                                    title: "Font Arab Tebal",
                                    value: fontController.arabBold.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        fontController.arabBold.value = v;
                                      });
                                    },
                                  ),

                                  const SizedBox(height: 18),
                                  SettingsSlider(
                                    label: "Ukuran Teks Arab",
                                    value: fontController.ukuranTeksArab.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        fontController.ukuranTeksArab.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  SettingsSlider(
                                    label: "Ukuran Teks latin & Terjemah",
                                    value: fontController
                                        .ukuranLatinTerjemah
                                        .value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        fontController
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
          return Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(
                'assets/animations/bar_loader.gif',
                height: 100,
              ),
            ),
          );
        }

        final ayatList = controller.hizbAyatList;

        if (ayatList.isEmpty) {
          return Center(
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    top: -100,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/animations/empty.json',
                          width: 180,
                          height: 180,
                        ),
                        Text(
                          "Data Tidak Ditemukan",
                          style: TextStyle(color: HexColor.fromHex("#246177")),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final firstSurah = ayatList.first.surahNamaLatin;
        final lastSurah = ayatList.last.surahNamaLatin;

        return ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          itemCount: ayatList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Container(
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
                                  text: "Hizb:",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text.rich(
                                TextSpan(
                                  text: "$hizbNumber",
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
                                  text: "Dari:",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text.rich(
                                TextSpan(
                                  text: firstSurah,
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
                                  text: "Sampai:",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text.rich(
                                TextSpan(
                                  text: lastSurah,
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
                                  text: "${ayatList.length}",
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
              );
            }

            final ayat = ayatList[index - 1];

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${ayat.numberInSurah}",
                          style: TextStyle(
                            color: HexColor.fromHex("#D39D52"),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${ayat.surahNamaLatin}",
                          style: TextStyle(
                            color: HexColor.fromHex("#D39D52"),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Obx(() {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ayat.teksArab,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontController.ukuranTeksArab.value,
                            fontFamily: fontFamily,
                            fontWeight: fontController.arabBold.value
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
                            fontSize: fontController.ukuranLatinTerjemah.value,
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 10),
                    Obx(() {
                      return Text(
                        ayat.teksIndonesia,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontController.ukuranLatinTerjemah.value,
                        ),
                      );
                    }),
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
