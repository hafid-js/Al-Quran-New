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

class PlayerBar extends StatefulWidget {
  const PlayerBar({super.key});

  @override
  State<PlayerBar> createState() => _PlayerBarState();
}

class _PlayerBarState extends State<PlayerBar> {
  bool _isDragging = false;

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
        padding: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 16,
                right: 16,
              ),
              child: _SeekBar(
                controller: controller,
                isDragging: _isDragging,
                onDragStart: () => setState(() => _isDragging = true),
                onDragEnd: () => setState(() => _isDragging = false),
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

class _SeekBar extends StatelessWidget {
  final SurahController controller;
  final bool isDragging;
  final VoidCallback onDragStart;
  final VoidCallback onDragEnd;

  const _SeekBar({
    required this.controller,
    required this.isDragging,
    required this.onDragStart,
    required this.onDragEnd,
  });

  void _seek(BuildContext context, Offset localPosition) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final width = box.size.width;
    final dx = localPosition.dx.clamp(0.0, width);
    final duration = controller.player.duration ?? Duration.zero;
    controller.player.seek(duration * (dx / width));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: controller.player.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration = controller.player.duration ?? Duration.zero;
        final pct = duration.inMilliseconds == 0
            ? 0.0
            : position.inMilliseconds / duration.inMilliseconds;
        final clamped = pct.clamp(0.0, 1.0);

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final knobX = width * clamped;
            final knobSize = isDragging ? 18.0 : 12.0;

            return GestureDetector(
              onTapDown: (d) => _seek(context, d.localPosition),
              onHorizontalDragStart: (d) {
                onDragStart();
                _seek(context, d.localPosition);
              },
              onHorizontalDragUpdate: (d) =>
                  _seek(context, d.localPosition),
              onHorizontalDragEnd: (_) => onDragEnd(),
              child: SizedBox(
                height: 20,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 4,
                      width: width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 6,
                      width: knobX,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Positioned(
                      left: knobX - knobSize / 2,
                      top: 9 - knobSize / 2,
                      child: Container(
                        width: knobSize,
                        height: knobSize,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
