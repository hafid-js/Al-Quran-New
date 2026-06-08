import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Map<String, String> qariImages = {
  "01": "assets/images/qari/Abdullah-Al-Juhany.webp",
  "02": "assets/images/qari/Abdul-Muhsin-Al-Qasim.webp",
  "03": "assets/images/qari/Abdurrahman-as-Sudais.webp",
  "04": "assets/images/qari/Ibrahim-Al-Dossari.webp",
  "05": "assets/images/qari/Misyari-Rasyid-Al-Afasi.webp",
  "06": "assets/images/qari/Yasser-Al-Dosari.webp",
};

class PlayerBar extends StatelessWidget {
  const PlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SurahController>();

    return Obx(() {
      final nomor = controller.activeSurahNomor.value;
      if (nomor == null) return const SizedBox.shrink();
      final surah = controller.surahList.firstWhere(
        (s) => s.nomor == nomor,
      );

      final qariKey =
          (Get.find<SettingsController>().qariSelected.value + 1)
              .toString()
              .padLeft(2, '0');

      return Container(
        padding: EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 16,
                right: 16,
              ),
              child: StreamBuilder<Duration>(
                stream: controller.player.positionStream,
                builder: (context, snapshot) {
                  final position =
                      snapshot.data ?? Duration.zero;

                  final duration =
                      controller.player.duration ??
                      Duration.zero;

                  final percent = duration.inMilliseconds == 0
                      ? 0.0
                      : position.inMilliseconds /
                            duration.inMilliseconds;

                  return GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      final box =
                          context.findRenderObject()
                              as RenderBox;
                      final local = box.globalToLocal(
                        details.globalPosition,
                      );

                      final width = box.size.width;
                      final dx = local.dx.clamp(0.0, width);

                      final duration =
                          controller.player.duration ??
                          Duration.zero;
                      final newPosition =
                          duration * (dx / width);

                      controller.player.seek(newPosition);
                    },
                    onTapDown: (details) {
                      final box =
                          context.findRenderObject()
                              as RenderBox;
                      final local = box.globalToLocal(
                        details.globalPosition,
                      );

                      final width = box.size.width;
                      final dx = local.dx.clamp(0.0, width);

                      final duration =
                          controller.player.duration ??
                          Duration.zero;
                      final newPosition =
                          duration * (dx / width);

                      controller.player.seek(newPosition);
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;

                        return StreamBuilder<Duration>(
                          stream: controller
                              .player
                              .positionStream,
                          builder: (context, snapshot) {
                            final position =
                                snapshot.data ??
                                Duration.zero;
                            final duration =
                                controller.player.duration ??
                                Duration.zero;

                            final percent =
                                duration.inMilliseconds == 0
                                ? 0.0
                                : position.inMilliseconds /
                                      duration.inMilliseconds;

                            final clamped = percent.clamp(
                              0.0,
                              1.0,
                            );
                            final knobX = width * clamped;

                            return Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  height: 4,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).disabledColor,
                                    borderRadius:
                                        BorderRadius.circular(
                                          10,
                                        ),
                                  ),
                                ),

                                Container(
                                  height: 6,
                                  width: knobX,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    borderRadius:
                                        BorderRadius.circular(
                                          10,
                                        ),
                                  ),
                                ),

                                Positioned(
                                  left: knobX - 6,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color:
                                              Colors.black26,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  qariImages[qariKey]!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                surah.namaLatin,

                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).textTheme.titleSmall?.color,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: StreamBuilder<Duration>(
                stream: controller.player.positionStream,
                builder: (context, snapshot) {
                  final position =
                      snapshot.data ?? Duration.zero;

                  final duration =
                      controller.player.duration ??
                      Duration.zero;

                  final text =
                      "${controller.formatDuration(position)} / "
                      "${controller.formatDuration(duration)}";

                  return Text(
                    text,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall,
                  );
                },
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => controller.playPrevious(),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex(
                          "#5a7b8a",
                        ).withAlpha(30),
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.skip_previous_rounded,
                          color: HexColor.fromHex("#8da6b7"),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Obx(() {
                    final kondisi = controller
                        .getSurahAudioState(surah.nomor);
                    return kondisi == "playing"
                        ? InkWell(
                            onTap: () {
                              controller.pauseAudio(surah);
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: HexColor.fromHex(
                                  "#5a7b8a",
                                ).withAlpha(30),
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons
                                      .pause_circle_filled_outlined,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              controller.resumeAudio(surah);
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: HexColor.fromHex(
                                  "#5a7b8a",
                                ).withAlpha(30),
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons
                                      .play_circle_filled_outlined,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  size: 30,
                                ),
                              ),
                            ),
                          );
                  }),
                  SizedBox(width: 6),
                  InkWell(
                    onTap: () => controller.playNext(),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex(
                          "#5a7b8a",
                        ).withAlpha(30),
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.skip_next_rounded,
                          color: HexColor.fromHex("#8da6b7"),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  InkWell(
                    onTap: () {
                      controller.stopAudio(surah);
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex(
                          "#5a7b8a",
                        ).withAlpha(30),
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.stop_rounded,
                          color: HexColor.fromHex("#8da6b7"),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
