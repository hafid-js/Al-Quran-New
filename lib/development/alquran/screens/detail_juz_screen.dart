import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/alquran/controllers/juz_controller.dart';
import 'package:alquran_new/development/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
import 'package:alquran_new/development/shared/widgets/common_empty_widget.dart';
import 'package:alquran_new/development/shared/widgets/shimmer_detail_surah.dart';
import 'package:alquran_new/development/shared/widgets/settings_slider.dart';
import 'package:alquran_new/development/shared/widgets/settings_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailJuzScreen extends StatefulWidget {
  const DetailJuzScreen({super.key});

  @override
  State<DetailJuzScreen> createState() => _DetailJuzScreenState();
}

class _DetailJuzScreenState extends State<DetailJuzScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(JuzController(), permanent: false);
    final SettingsController setting = Get.find<SettingsController>();
  final ItemScrollController itemScrollController = ItemScrollController();
  late AnimationController _animationController;
  late Animation<double> _rotation;
  late Animation<double> _scale;

  late int juzNumber;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map;
    juzNumber = args["juz"];
    controller.fetchJuz(juzNumber);

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
    setState(() => _isRotated = !_isRotated);
    if (_isRotated) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (controller.juzAyatList.isNotEmpty) {
      controller.stopAudio(controller.juzAyatList.first);
    }
    Get.delete<JuzController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
       final selectedIndex = setting.fontSelected.value;
    final fontFamily = fontArabs[selectedIndex]["title"];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar(
        title: "Juz $juzNumber",
        titleColor: isDark
            ? Theme.of(context).textTheme.titleSmall!.color
            : Theme.of(context).textTheme.titleMedium!.color,
        backgroundColor: isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.white,
        surfaceTintColor: isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.white,
        backIconColor: isDark
            ? Theme.of(context).textTheme.titleSmall!.color
            : Theme.of(context).textTheme.titleMedium!.color,
        actions: [
          Icon(
            Iconsax.book_1,
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
          SizedBox(width: 15),
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
                                            color: isDark
                                                ? AppColors.textPrimaryDark
                                                : AppColors.primary,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SettingsSwitchTile(
                                    title: "Terjemah",
                                    value: setting.terjemah.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        setting.terjemah.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 5),

                                  SettingsSwitchTile(
                                    title: "Latin",
                                    value: setting.latin.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        setting.latin.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 5),

                                  SettingsSwitchTile(
                                    title: "Font Arab Tebal",
                                    value: setting.arabBold.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        setting.arabBold.value = v;
                                      });
                                    },
                                  ),

                                  const SizedBox(height: 18),
                                  SettingsSlider(
                                    label: "Ukuran Teks Arab",
                                    value: setting.ukuranTeksArab.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        setting.ukuranTeksArab.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  SettingsSlider(
                                    label: "Ukuran Teks latin & Terjemah",
                                    value: setting
                                        .ukuranLatinTerjemah
                                        .value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        setting
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
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.all(16),
      ),
      body: Obx(() {
        final data = controller.juzAyatList;
        if (controller.isLoading.value && data.isEmpty) {
          return const ShimmerDetailSurah();
        }

        if (data.isEmpty) {
          return CommonEmptyWidget(
            refresh: () async {
              await controller.fetchJuz(juzNumber);
            },
          );
        }
        final lastSurah = data.last.surahNamaLatin;
        final firstSurah = data.first.surahNamaLatin;

        return RefreshIndicator(
          backgroundColor: isDark ? Theme.of(context).cardColor : AppColors.primary,
          color: AppColors.secondary,
          onRefresh: () async {
            await controller.fetchJuz(juzNumber, forceRefresh: true);
          },
          child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Theme.of(context).cardColor
                          : AppColors.primary,
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
                                    text: "Juz:",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text.rich(
                                  TextSpan(
                                    text: "$juzNumber",
                                    style: TextStyle(
                                      color: AppColors.secondary,
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
                                      color: AppColors.secondary,
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
                                      color: AppColors.secondary,
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
                                    text: "${data.length}",
                                    style: TextStyle(
                                      color: AppColors.secondary,
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

              final ayat = data[index - 1];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
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
                              color: AppColors.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${ayat.surahNamaLatin}",
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Obx(() {
                        return  Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  ayat.teksArab,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: isDark
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textPrimaryLight,
                                    fontSize: setting.ukuranTeksArab.value,
                                    fontFamily: fontFamily,
                                    fontWeight: setting.arabBold.value
                                        ? FontWeight.w600
                                        : null,
                                    height: 2.5,
                                  ),
                                ),
                              );
                      }),

                      Obx(() {
                        if (!setting.latin.value &&
                            !setting.terjemah.value)
                          return SizedBox.shrink();
                        return SizedBox(height: 30);
                      }),
                      Obx(() {
                        if (!setting.latin.value)
                          return SizedBox.shrink();
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            ayat.teksLatin,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.secondary
                                  : Colors.black,
                              fontSize:
                                  setting.ukuranLatinTerjemah.value,
                            ),
                          ),
                        );
                      }),
                      Obx(() {
                        if (!setting.terjemah.value)
                          return SizedBox.shrink();
                        return SizedBox(height: 10);
                      }),
                      Obx(() {
                        if (!setting.terjemah.value)
                          return SizedBox.shrink();
                        return Text(
                          ayat.teksIndonesia,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.titleSmall!.color,
                            fontSize: setting.ukuranLatinTerjemah.value,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
