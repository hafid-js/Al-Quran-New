import 'package:alquran_new/core/widgets/loading.dart';
import 'package:alquran_new/core/widgets/settings_slider.dart';
import 'package:alquran_new/core/widgets/settings_switch.dart';
import 'package:alquran_new/features/bookmark/controllers/bookmark_controller.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/features/surat/controllers/detail_surah_controller.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

const scrollDuration = Duration(seconds: 2);

class DetailSuratScreen extends StatefulWidget {
  const DetailSuratScreen({super.key});

  @override
  State<DetailSuratScreen> createState() => _DetailSuratScreenState();
}

class _DetailSuratScreenState extends State<DetailSuratScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<DetailSurahController>();

  final SettingsController setting = Get.find<SettingsController>();

  final bookmarkController = Get.find<BookmarkController>();

  final ItemScrollController itemScrollController = ItemScrollController();

  late int nomor;
  late int targetAyat;

  late AnimationController _animationController;
  late Animation<double> _rotation;
  late Animation<double> _scale;

  double _scrollOffset = 0;
  double _prevScrollOffset = 0;
  bool _showHeader = true;

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
          scrollToAyat(targetAyat);
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void scrollToAyat(int nomorAyat) {
    itemScrollController.scrollTo(
      index: nomorAyat,
      duration: scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: 0.2,
    );
  }

  Set<int> expandedIndexes = {};

  @override
  Widget build(BuildContext context) {
    final scale = Responsive.scale(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,

      body: Obx(() {
        final selectedIndex = setting.fontSelected.value;
        final fontFamily = fontArabs[selectedIndex]["title"];

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

        final headerHeight =
            Responsive.boxSize(context, phone: isLandscape ? 265 : 260) *
            (MediaQuery.of(context).size.width > 600 ? 1.1 : 1);
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, right: 10, left: 10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _showHeader ? headerHeight : 0,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withAlpha(160),
                      Theme.of(context).colorScheme.primary.withAlpha(190),
                    ],
                  ),
                ),
                child: ClipRect(
                  child: OverflowBox(
                    maxHeight: headerHeight,
                    alignment: Alignment.topCenter,
                    child: Opacity(
                      opacity: _showHeader ? 1.0 : 0.0,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Container(
                                    height: Responsive.boxSize(
                                      context,
                                      phone: 40,
                                    ),
                                    width: Responsive.boxSize(
                                      context,
                                      phone: 40,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(
                                        12 * scale,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_circle_left_rounded,
                                      color: Colors.white,
                                      size: Responsive.iconSize(
                                        context,
                                        phone: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    _animationController.forward();
                                    await WoltModalSheet.show(
                                      context: context,
                                      pageListBuilder: (context) => [
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
                                                    padding:
                                                        const EdgeInsets.all(
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
                                                                .titleLarge!
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
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
                                                          height: 5,
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
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        SettingsSwitchTile(
                                                          title:
                                                              "Font Arab Bold",
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
                                                          height: 5,
                                                        ),
                                                        SettingsSwitchTile(
                                                          title:
                                                              "Tampilan Latin",
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
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        SettingsSwitchTile(
                                                          title:
                                                              "Tampilan Terjemah",
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
                                  child: Container(
                                    height: Responsive.boxSize(
                                      context,
                                      phone: 40,
                                    ),
                                    width: Responsive.boxSize(
                                      context,
                                      phone: 40,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(
                                        12 * scale,
                                      ),
                                    ),
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
                                ),
                              ],
                            ),
                            Text(
                              data.nama,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: Responsive.fontSize(
                                  context,
                                  phone: 35,
                                ),
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: Responsive.boxSize(context, phone: 10),
                            ),
                            Text(
                              data.namaLatin,
                              style: TextStyle(
                                fontSize: Responsive.fontSize(
                                  context,
                                  phone: 22,
                                ),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5 * scale),
                            Text(
                              data.arti,
                              style: TextStyle(
                                fontSize: Responsive.fontSize(
                                  context,
                                  phone: 16,
                                ),
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(height: 12 * scale),
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
                                          Icons.mosque,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5 * scale),
                                        Text(
                                          data.tempatTurun,
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
                                          "${data.jumlahAyat.toString()} Ayat",
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
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  _prevScrollOffset = _scrollOffset;
                  _scrollOffset = notification.metrics.pixels;
                  setState(() {
                    if (_scrollOffset < 100) {
                      _showHeader = true;
                    } else if (_scrollOffset > _prevScrollOffset + 5 &&
                        _showHeader) {
                      _showHeader = false;
                    } else if (_scrollOffset < _prevScrollOffset - 5 &&
                        !_showHeader) {
                      _showHeader = true;
                    }
                  });
                  return false;
                },
                child: ScrollablePositionedList.builder(
                  // padding: EdgeInsets.only(top: 00),
                  itemScrollController: itemScrollController,
                  itemCount: data.ayat.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      if (data.namaLatin == "Al-Fatihah") {
                        return SizedBox(height: 16 * scale);
                      } else {
                        return Padding(
                          padding: EdgeInsets.all(Responsive.padding(context)),
                          child: Container(
                            padding: EdgeInsets.all(
                              Responsive.padding(context),
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16 * scale),
                            ),
                            child: Obx(() {
                              return Text(
                                "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.color,
                                  fontSize: Responsive.fontSize(
                                    context,
                                    phone: controller.ukuranTeksArab.value,
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      }
                    }

                    final ayat = data.ayat[index - 1];
                    final surah = data;
                    final isOpen = expandedIndexes.contains(index);
                    final tafsir = controller.tafsirList.firstWhereOrNull(
                      (t) => t.ayat == ayat.nomorAyat,
                    );
                    final pad = Responsive.padding(context);

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: pad),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16 * scale),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: Responsive.cardPadding(context),
                                vertical: Responsive.cardPadding(context),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            ayat.nomorAyat.toString(),
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: Responsive.fontSize(
                                                context,
                                                phone: 14,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.brightness_5_sharp,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.surface,
                                            size: Responsive.iconSize(
                                              context,
                                              phone: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (expandedIndexes.contains(
                                                  index,
                                                )) {
                                                  expandedIndexes.remove(index);
                                                } else {
                                                  expandedIndexes.add(index);
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: Responsive.boxSize(
                                                context,
                                                phone: 40,
                                              ),
                                              width: Responsive.boxSize(
                                                context,
                                                phone: 40,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      12 * scale,
                                                    ),
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.surface,
                                              ),
                                              child: Icon(
                                                Icons.menu_book_rounded,
                                                size: Responsive.iconSize(
                                                  context,
                                                  phone: 22,
                                                ),
                                                color: isOpen
                                                    ? Colors.amber
                                                    : Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.color,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8 * scale),
                                          Obx(() {
                                            final isSaved = bookmarkController
                                                .isBookmarked(
                                                  nomor,
                                                  ayat.nomorAyat,
                                                );
                                            return InkWell(
                                              onTap: () {
                                                bookmarkController.toggle(
                                                  nomor,
                                                  surah.nama,
                                                  surah.namaLatin,
                                                  ayat.nomorAyat,
                                                );
                                              },
                                              child: Container(
                                                height: Responsive.boxSize(
                                                  context,
                                                  phone: 40,
                                                ),
                                                width: Responsive.boxSize(
                                                  context,
                                                  phone: 40,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        12 * scale,
                                                      ),
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.surface,
                                                ),
                                                child: Icon(
                                                  isSaved
                                                      ? Icons.bookmark
                                                      : Icons.bookmark_border,
                                                  size: Responsive.iconSize(
                                                    context,
                                                    phone: 22,
                                                  ),
                                                  color: isSaved
                                                      ? Colors.amber
                                                      : Theme.of(context)
                                                            .textTheme
                                                            .labelLarge
                                                            ?.color,
                                                ),
                                              ),
                                            );
                                          }),
                                          SizedBox(width: 8 * scale),
                                          Obx(() {
                                            final kondisi = controller
                                                .getAyatAudioState(
                                                  ayat.nomorAyat,
                                                );

                                            return kondisi == "stop"
                                                ? Container(
                                                    height: Responsive.boxSize(
                                                      context,
                                                      phone: 40,
                                                    ),
                                                    width: Responsive.boxSize(
                                                      context,
                                                      phone: 40,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12 * scale,
                                                          ),
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.surface,
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        controller.playAudio(
                                                          ayat,
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .play_circle_filled_rounded,
                                                        size:
                                                            Responsive.iconSize(
                                                              context,
                                                              phone: 22,
                                                            ),
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                      ),
                                                    ),
                                                  )
                                                : SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        kondisi == "playing"
                                                            ? IconButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .pauseAudio(
                                                                        ayat,
                                                                      );
                                                                },
                                                                icon: Icon(
                                                                  Icons.pause,
                                                                  size:
                                                                      Responsive.iconSize(
                                                                        context,
                                                                        phone:
                                                                            22,
                                                                      ),
                                                                  color: Theme.of(
                                                                    context,
                                                                  ).colorScheme.primary,
                                                                ),
                                                              )
                                                            : IconButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .resumeAudio(
                                                                        ayat,
                                                                      );
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .play_arrow,
                                                                  size:
                                                                      Responsive.iconSize(
                                                                        context,
                                                                        phone:
                                                                            22,
                                                                      ),
                                                                  color: Theme.of(
                                                                    context,
                                                                  ).colorScheme.primary,
                                                                ),
                                                              ),
                                                        IconButton(
                                                          onPressed: () {
                                                            controller
                                                                .stopAudio(
                                                                  ayat,
                                                                );
                                                          },
                                                          icon: Icon(
                                                            Icons.stop,
                                                            size:
                                                                Responsive.iconSize(
                                                                  context,
                                                                  phone: 20,
                                                                ),
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .primary,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                          }),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: Responsive.boxSize(
                                      context,
                                      phone: 15,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Obx(() {
                                        return Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            ayat.teksArab,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontWeight:
                                                  controller.arabBold.value
                                                  ? FontWeight.bold
                                                  : null,
                                              color: Theme.of(
                                                context,
                                              ).textTheme.titleMedium?.color,
                                              fontSize: Responsive.fontSize(
                                                context,
                                                phone: controller
                                                    .ukuranTeksArab
                                                    .value,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      SizedBox(
                                        height: Responsive.boxSize(
                                          context,
                                          phone: 22,
                                        ),
                                      ),
                                      Obx(() {
                                        if (controller.latin.value ||
                                            controller.terjemah.value)
                                          return Column(
                                            children: [
                                              Divider(
                                                color: HexColor.fromHex(
                                                  "#5a7b8a",
                                                ).withAlpha(90),
                                                thickness: 0.1,
                                              ),
                                              SizedBox(
                                                height: Responsive.boxSize(
                                                  context,
                                                  phone: 10,
                                                ),
                                              ),
                                            ],
                                          );
                                        return SizedBox.shrink();
                                      }),

                                      Obx(() {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (controller.latin.value)
                                              Text(
                                                ayat.teksLatin,
                                                style: TextStyle(
                                                  fontSize: Responsive.fontSize(
                                                    context,
                                                    phone: controller
                                                        .ukuranLatinTerjemah
                                                        .value,
                                                  ),
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                ),
                                              ),
                                            if (controller.latin.value ||
                                                controller.terjemah.value)
                                              SizedBox(
                                                height: Responsive.boxSize(
                                                  context,
                                                  phone: 10,
                                                ),
                                              ),
                                            if (controller.terjemah.value)
                                              Text(
                                                ayat.teksIndonesia,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontSize: Responsive.fontSize(
                                                        context,
                                                        phone: controller
                                                            .ukuranLatinTerjemah
                                                            .value,
                                                      ),
                                                    ),
                                              ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (expandedIndexes.contains(index))
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: pad),
                            child: ExpansionTile(
                              initiallyExpanded: isOpen,
                              onExpansionChanged: (val) {
                                setState(() {
                                  if (val) {
                                    expandedIndexes.add(index);
                                  } else {
                                    expandedIndexes.remove(index);
                                  }
                                });
                              },
                              tilePadding: EdgeInsets.zero,
                              childrenPadding: EdgeInsets.zero,
                              minTileHeight: 0,
                              visualDensity: VisualDensity.compact,
                              shape: Border(),
                              collapsedShape: Border(),
                              showTrailingIcon: false,
                              title: const SizedBox.shrink(),
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withAlpha(10),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16 * scale),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Responsive.cardPadding(context),
                                    vertical: Responsive.cardPadding(context),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.menu_book_rounded,
                                            color: Colors.amber,
                                            size: Responsive.iconSize(
                                              context,
                                              phone: 22,
                                            ),
                                          ),
                                          SizedBox(width: 10 * scale),
                                          Text(
                                            "Tafsir",
                                            style: TextStyle(
                                              fontSize: Responsive.fontSize(
                                                context,
                                                phone: 16,
                                              ),
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Responsive.boxSize(
                                          context,
                                          phone: 15,
                                        ),
                                      ),
                                      Obx(() {
                                        return Text(
                                          tafsir?.teks ??
                                              "Tafsir tidak tersedia.",
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(
                                              context,
                                              phone: controller
                                                  .ukuranLatinTerjemah
                                                  .value,
                                            ),
                                            color: HexColor.fromHex("#7c97a6"),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        SizedBox(
                          height: Responsive.boxSize(context, phone: 10),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
