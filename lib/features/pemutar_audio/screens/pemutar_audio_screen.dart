import 'package:alquran_new/core/ui/loading.dart';
import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PemutarAudioScreen extends StatefulWidget {
  const PemutarAudioScreen({super.key});

  @override
  State<PemutarAudioScreen> createState() => _PemutarAudioScreenState();
}

class _PemutarAudioScreenState extends State<PemutarAudioScreen> {
  final ExpansibleController controller = ExpansibleController();
  @override
  Widget build(BuildContext context) {
    final SurahController controller = Get.put(SurahController());

    // final SettingsController settingsController = Get.find<SettingsController>();

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
                      HexColor.fromHex("#23867c"),
                      HexColor.fromHex("#37b0a5"),
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
                                  color: HexColor.fromHex(
                                    "#19554d",
                                  ).withAlpha(140),
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
                                color: HexColor.fromHex(
                                  "#19554d",
                                ).withAlpha(140),
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
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                  "https://way2quran.com/_next/image?url=https%3A%2F%2Fmedia.way2quran.com%2Fimgs%2Fibrahim-al-dosari.png&w=640&q=75",
                                ),
                              ),
                              SizedBox(width: 8),

                              Flexible(
                                child: Text(
                                  "Ibrahim Al-Dossari",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              SizedBox(width: 8),
                              InkWell(
                                onTap: () {
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

                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  onTap: () {},
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 6,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(
                                                        context,
                                                      ).cardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                    ),
                                                    child: ListTile(
                                                      leading: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                        child: CachedNetworkImage(
                                                          imageUrl:
                                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnlUZ8nhYPRQDuhjxBpB5LDivq-_YzdFzbtw&s",
                                                          width: 35,
                                                          height: 35,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        "Abdullah Al-Jullany",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  onTap: () {},
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 6,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: HexColor.fromHex(
                                                        "#2cc4b6",
                                                      ).withAlpha(20),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: HexColor.fromHex(
                                                          "#2cc4b6",
                                                        ),
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      leading: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                        child: CachedNetworkImage(
                                                          imageUrl:
                                                              "https://i1.sndcdn.com/artworks-yRdHunkzvtypsKvH-YmPLEA-t500x500.jpg",
                                                          width: 35,
                                                          height: 35,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        "Ibrahim Al-Dossari",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              HexColor.fromHex(
                                                                "#2cc4b6",
                                                              ),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      trailing: Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        color: HexColor.fromHex(
                                                          "#2cc4b6",
                                                        ),
                                                        size: 22,
                                                      ),
                                                    ),
                                                  ),
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
                    Obx(() {
                      final nomor = controller.activeSurahNomor.value;
                      if (nomor == null) return const SizedBox.shrink();
                      final surah = controller.surahList.firstWhere(
                        (s) => s.nomor == nomor,
                      );

                      return Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                          ),
                          child: Column(
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

                                              return SizedBox(
                                                height: 20,
                                                child: Stack(
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                                      height: 4,
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
                                                          shape:
                                                              BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4,
                                                              color: Colors
                                                                  .black26,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnlUZ8nhYPRQDuhjxBpB5LDivq-_YzdFzbtw&s",
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
                        ),
                      );
                    }),
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
