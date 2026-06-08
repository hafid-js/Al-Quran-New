import 'package:alquran_new/core/ui/loading.dart';
import 'package:alquran_new/core/utils/constants/app_colors.dart';
import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/features/pemutar_audio/widgets/player_bar.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PemutarAudioScreen extends StatefulWidget {
  const PemutarAudioScreen({super.key});

  @override
  State<PemutarAudioScreen> createState() => _PemutarAudioScreenState();
}

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
    final SurahController controller = Get.put(SurahController(), permanent: true);
    final settingController = Get.find<SettingsController>();

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withAlpha(160),
                      Theme.of(context).colorScheme.primary.withAlpha(190),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.arrow_circle_left_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),

                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.headset_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Pemutar Audio",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Pembukaan",
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 370),
                        child: Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(() {
                                    final selectedIndex =
                                        settingController.qariSelected.value;
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
                                          settingController.qariSelected.value;
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
                                  if (controller.player.processingState != ProcessingState.idle) {
                                    Get.snackbar(
                                      "Audio Aktif",
                                      "Hentikan audio terlebih dahulu sebelum mengganti qari",
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
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
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    "Pilih Qari",
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.titleMedium,
                                                  ),
                                                ),
                                                SizedBox(height: 12),

                                                Column(
                                                  children: List.generate(qoris.length, (
                                                    index,
                                                  ) {
                                                    final item = qoris[index];
                                                    final key = (index + 1)
                                                        .toString()
                                                        .padLeft(2, '0');

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
                                                              color: isSelected
                                                                  ? Theme.of(
                                                                          context,
                                                                        )
                                                                        .colorScheme
                                                                        .surface
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
                                                                    : Colors
                                                                          .transparent,
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
                                                                  width: 40,
                                                                  height: 40,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              title: Text(
                                                                item["title"],
                                                                style: TextStyle(
                                                                  fontSize: Theme.of(context)
                                                                      .textTheme
                                                                      .titleSmall
                                                                      ?.fontSize,
                                                                  color: isDark
                                                                      ? AppColors
                                                                            .light
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
                                                                      Icons
                                                                          .check_circle_rounded,
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),

              Expanded(
                child: Stack(
                  children: [
                    Obx(() {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.surahList.length,
                        itemBuilder: (context, index) {
                          final surah = controller.surahList[index];

                          return Obx(() {
                            final kondisi = controller.getSurahAudioState(
                              surah.nomor,
                            );
                            final activeSurahNomor =
                                controller.activeSurahNomor.value;

                            Widget buildPlaying() {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  right: 16,
                                  left: 16,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: BoxBorder.all(
                                          width: 0.5,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        leading: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          onTap: () {
                                            controller.playAudio(surah);
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(80),
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                                fontSize: 18,
                                                color: Theme.of(
                                                  context,
                                                ).textTheme.titleMedium?.color,
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Icon(
                                              Icons
                                                  .download_for_offline_outlined,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                              size: 22,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            Widget buildPause() {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  right: 16,
                                  left: 16,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: BoxBorder.all(
                                          width: 0.5,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        leading: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          onTap: () {
                                            controller.playAudio(surah);
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(80),
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                                fontSize: 18,
                                                color: Theme.of(
                                                  context,
                                                ).textTheme.titleMedium?.color,
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Icon(
                                              Icons
                                                  .download_for_offline_outlined,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                              size: 22,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            Widget buildDefault() {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  right: 16,
                                  left: 16,
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: () {
                                        controller.playAudio(surah);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          leading: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(40),
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                                padding: EdgeInsets.only(
                                                  top: 9,
                                                ),
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
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.color,
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              AnimatedRotation(
                                                turns: 1.75,
                                                duration: Duration(
                                                  milliseconds: 300,
                                                ),
                                                child: Icon(
                                                  Icons
                                                      .arrow_circle_left_rounded,
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            if (kondisi == "playing" &&
                                activeSurahNomor == surah.nomor) {
                              return buildPlaying();
                            }

                            if (kondisi == "pause" &&
                                activeSurahNomor == surah.nomor) {
                              return buildPause();
                            }

                            return buildDefault();
                          });
                        },
                      );
                    }),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: PlayerBar(),
                    ),
                  ],
                ),
              ),
            ],
          ),

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
