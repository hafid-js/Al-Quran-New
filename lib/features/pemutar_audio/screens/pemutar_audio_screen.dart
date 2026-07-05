import 'dart:ui' as ui;

import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/widgets/loading.dart';
import 'package:alquran_new/core/constants/app_colors.dart';

import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/features/pemutar_audio/widgets/player_bar.dart';
import 'package:alquran_new/features/pengaturan/controllers/qari_mapper.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';

class PemutarAudioScreen extends StatefulWidget {
  const PemutarAudioScreen({super.key});

  @override
  State<PemutarAudioScreen> createState() => _PemutarAudioScreenState();
}

final SettingsController setting = Get.find<SettingsController>();
final Map<String, String> qariImages = {
  "01": "assets/images/qari/Abdullah-Al-Juhany.webp",
  "02": "assets/images/qari/Abdul-Muhsin-Al-Qasim.webp",
  "03": "assets/images/qari/Abdurrahman-as-Sudais.webp",
  "04": "assets/images/qari/Ibrahim-Al-Dossari.webp",
  "05": "assets/images/qari/Misyari-Rasyid-Al-Afasi.webp",
  "06": "assets/images/qari/Yasser-Al-Dosari.webp",
};

final List<Map<String, dynamic>> qoris = [
  {"title": "Abdullah Al-Juhany"},
  {"title": "Abdul Muhsin Al Qasim"},
  {"title": "Abdurrahman as-Sudais"},
  {"title": "Ibraim Al-Dossari"},
  {"title": "Misyari Rasyid Al-Afsi"},
  {"title": "Yaser Al-Dosari"},
];

class _PemutarAudioScreenState extends State<PemutarAudioScreen> {
  @override
  Widget build(BuildContext context) {
    final scale = Responsive.scale(context);
    final SurahController controller = Get.put(
      SurahController(),
      permanent: true,
    );
    final settingController = Get.find<SettingsController>();

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: false,
                floating: true,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                expandedHeight: Responsive.boxSize(
                  context,
                  phone: isLandscape ? 285 : 275,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(top: 50, right: 10, left: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(160),
                            Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(190),
                          ],
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10 * Responsive.scale(context),
                          left: 10 * Responsive.scale(context),
                          right: 8 * Responsive.scale(context),
                          bottom: 20 * Responsive.scale(context),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: BackdropFilter(
                                    filter: ui.ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: GestureDetector(
                                      onTap: () => Get.back(),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(30),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.arrow_circle_left_rounded,
                                          size: Responsive.iconSize(
                                            context,
                                            phone: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withAlpha(20),
                                  ),
                                ),
                                Icon(
                                  Icons.headset_rounded,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ],
                            ),
                            SizedBox(height: 12 * Responsive.scale(context)),
                            Text(
                              "Pemutar Audio",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 16 * Responsive.scale(context)),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 370),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(30),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.white.withAlpha(50),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Obx(() {
                                          final selectedIndex =
                                              settingController
                                                  .qariSelected
                                                  .value;
                                          final qariKey = (selectedIndex + 1)
                                              .toString()
                                              .padLeft(2, '0');

                                          return CircleAvatar(
                                            radius: 12,
                                            backgroundImage: AssetImage(
                                              qariImages[qariKey]!,
                                            ),
                                          );
                                        }),
                                        SizedBox(width: 8),

                                        Flexible(
                                          child: Obx(() {
                                            final selectedIndex =
                                                settingController
                                                    .qariSelected
                                                    .value;
                                            final qariName =
                                                qoris[selectedIndex]["title"];
                                            return Text(
                                              qariName,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      onTap: () {
                                        if (controller.player.processingState !=
                                            ProcessingState.idle) {
                                          Get.snackbar(
                                            "Audio Aktif",
                                            "Hentikan audio terlebih dahulu sebelum mengganti qari",
                                            snackPosition: SnackPosition.BOTTOM,
                                            duration: const Duration(
                                              seconds: 2,
                                            ),
                                          );
                                          return;
                                        }
                                        showBarModalBottomSheet(
                                          backgroundColor: Theme.of(
                                            context,
                                          ).scaffoldBackgroundColor,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SafeArea(
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          "Pilih Qari",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                        ),
                                                      ),
                                                      SizedBox(height: 12),

                                                      Column(
                                                        children: List.generate(qoris.length, (
                                                          index,
                                                        ) {
                                                          final item =
                                                              qoris[index];
                                                          final key =
                                                              (index + 1)
                                                                  .toString()
                                                                  .padLeft(
                                                                    2,
                                                                    '0',
                                                                  );

                                                          return Obx(() {
                                                            final isSelected =
                                                                settingController
                                                                    .qariSelected
                                                                    .value ==
                                                                index;

                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                    bottom: 10,
                                                                  ),
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      16,
                                                                    ),
                                                                onTap: () async {
                                                                  await settingController
                                                                      .changeQari(
                                                                        index,
                                                                      );
                                                                  Get.back();
                                                                },
                                                                child: AnimatedContainer(
                                                                  padding:
                                                                      EdgeInsets.all(
                                                                        5,
                                                                      ),
                                                                  duration:
                                                                      const Duration(
                                                                        milliseconds:
                                                                            250,
                                                                      ),
                                                                  decoration: BoxDecoration(
                                                                    color:
                                                                        isSelected
                                                                        ? Theme.of(
                                                                            context,
                                                                          ).colorScheme.surface
                                                                        : Theme.of(
                                                                            context,
                                                                          ).cardColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          16,
                                                                        ),
                                                                    border: Border.all(
                                                                      color:
                                                                          isSelected
                                                                          ? Theme.of(
                                                                              context,
                                                                            ).colorScheme.primary
                                                                          : Colors.transparent,
                                                                      width: 1,
                                                                    ),
                                                                  ),
                                                                  child: ListTile(
                                                                    contentPadding:
                                                                        const EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              16,
                                                                        ),
                                                                    leading: ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            8,
                                                                          ),
                                                                      child: Image.asset(
                                                                        qariImages[key]!,
                                                                        width:
                                                                            40,
                                                                        height:
                                                                            40,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    title: Text(
                                                                      item["title"],
                                                                      style: TextStyle(
                                                                        fontSize: Theme.of(
                                                                          context,
                                                                        ).textTheme.titleSmall?.fontSize,
                                                                        color:
                                                                            isDark
                                                                            ? AppColors.light
                                                                            : (isSelected
                                                                                  ? Theme.of(
                                                                                      context,
                                                                                    ).colorScheme.primary
                                                                                  : Theme.of(
                                                                                      context,
                                                                                    ).textTheme.titleLarge?.color),
                                                                      ),
                                                                    ),
                                                                    trailing:
                                                                        isSelected
                                                                        ? Icon(
                                                                            Icons.check_circle_rounded,
                                                                            color: Theme.of(
                                                                              context,
                                                                            ).colorScheme.primary,
                                                                          )
                                                                        : null,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                        }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.arrow_drop_down_circle_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(40),
                                    borderRadius: BorderRadius.circular(
                                      12 * scale,
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.supervised_user_circle_outlined,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5 * scale),
                                        Text(
                                          "${qariKeys.length} Qari",
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(
                                              context,
                                              phone: 14,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15 * scale),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(40),
                                    borderRadius: BorderRadius.circular(
                                      12 * scale,
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.feed_outlined,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5 * scale),
                                        Text(
                                          "${controller.surahList.length.toString()} Ayat",
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(
                                              context,
                                              phone: 14,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final surah = controller.surahList[index];

                  return Obx(() {
                    final kondisi = controller.getSurahAudioState(surah.nomor);
                    final activeSurahNomor = controller.activeSurahNomor.value;
                    final selectedIndex = setting.fontSelected.value;
                    final fontFamily = fontArabs[selectedIndex]["title"];

                    Widget buildActiveCardContent() {
                      return Padding(
                        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? null
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(15),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 3,
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    leading: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: () {
                                        controller.playAudio(surah);
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary.withAlpha(80),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Center(
                                          child: kondisi == "pause"
                                              ? Icon(
                                                  Icons
                                                      .play_circle_fill_rounded,
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                )
                                              : Icon(
                                                  Icons
                                                      .pause_circle_filled_outlined,
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      surah.namaLatin,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                    subtitle: Wrap(
                                      spacing: 3,
                                      runSpacing: 4,
                                      children: [
                                        Text(
                                          surah.arti,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).textTheme.labelSmall?.color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 9),
                                          child: Icon(
                                            Icons.circle,
                                            size: 3,
                                            color: Theme.of(
                                              context,
                                            ).textTheme.labelSmall?.color,
                                          ),
                                        ),
                                        Text(
                                          "${surah.jumlahAyat} Ayat",
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).textTheme.labelSmall?.color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          surah.nama,
                                          style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 18,
                                            color: Theme.of(
                                              context,
                                            ).textTheme.titleMedium?.color,
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    Widget buildDefault() {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              right: 10,
                              left: 10,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                controller.playAudio(surah);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? null
                                      : [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(12),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(width: 3),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      leading: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary.withAlpha(40),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Center(
                                          child: Obx(() {
                                            final state = controller
                                                .getSurahAudioState(
                                                  surah.nomor,
                                                );
                                            if (state == "loading") {
                                              return SizedBox(
                                                width: 18,
                                                height: 18,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                    ),
                                              );
                                            }
                                            return Text(
                                              surah.nomor.toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                      title: Text(
                                        surah.namaLatin,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall,
                                      ),
                                      subtitle: Wrap(
                                        spacing: 3,
                                        runSpacing: 4,
                                        children: [
                                          Text(
                                            surah.arti,
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).textTheme.labelSmall?.color,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 9),
                                            child: Icon(
                                              Icons.circle,
                                              size: 3,
                                              color: Theme.of(
                                                context,
                                              ).textTheme.labelSmall?.color,
                                            ),
                                          ),
                                          Text(
                                            "${surah.jumlahAyat} Ayat",
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).textTheme.labelSmall?.color,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            surah.nama,
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 18,
                                              color: Theme.of(
                                                context,
                                              ).textTheme.titleMedium?.color,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    if ((kondisi == "playing" || kondisi == "pause") &&
                        activeSurahNomor == surah.nomor) {
                      return buildActiveCardContent();
                    }

                    return buildDefault();
                  });
                }, childCount: controller.surahList.length),
              ),
            ],
          ),
          const Positioned(bottom: 0, left: 0, right: 0, child: PlayerBar()),
          Obx(() {
            if (!controller.isLoading.value) {
              return const SizedBox.shrink();
            }

            return const Positioned.fill(child: Loading());
          }),
        ],
      ),
    );
  }
}
