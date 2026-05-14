import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/core/ui/loading.dart';
import 'package:alquran_new/features/bookmark/controllers/bookmark_controller.dart';
import 'package:alquran_new/features/surat/controllers/detail_surah_controller.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const scrollDuration = Duration(seconds: 2);

class DetailSuratScreen extends StatefulWidget {
  const DetailSuratScreen({super.key});

  @override
  State<DetailSuratScreen> createState() => _DetailSuratScreenState();
}

class _DetailSuratScreenState extends State<DetailSuratScreen> {
  final controller = Get.put(DetailSurahController());

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  double alignment = 0.02;
  bool reversed = false;

  final bookmarkController = Get.put(BookmarkController());

  late int nomor;
  late int targetAyat;

  final ScrollController _scrollController = ScrollController();
  double appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map;

    nomor = args["surah"];
    targetAyat = args["ayat"] ?? 0;

    controller.fetchDetailSurah(nomor);
    controller.fetchTafsirAyat(nomor);

    _scrollController.addListener(() {
      double offset = _scrollController.offset;

      setState(() {
        appBarOpacity = (offset / 150).clamp(0.0, 1.0);
      });
    });

    ever(controller.detailSurah, (data) {
      if (data == null) return;
      if (targetAyat <= 0) return;
      if (data != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 300), () {
            scrollToAyat(targetAyat);
          });
        });
      }
    });
  }

  void scrollToAyat(int nomorAyat) {
    itemScrollController.scrollTo(
      index: nomorAyat,
      duration: scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: alignment,
    );
  }

  Set<int> expandedIndexes = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#132e3a").withAlpha(120),

      extendBodyBehindAppBar: true,

      body: Obx(() {
        if (controller.isLoading.value) {
          return Loading();
        }

        final data = controller.detailSurah.value;

        if (data == null) {
          return Center(child: Text("Data kosong"));
        }

        return Stack(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        data.nama,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        data.namaLatin,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        data.arti,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(40),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.mosque,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    data.tempatTurun,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(40),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.feed_outlined,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "${data.jumlahAyat.toString()} Ayat",
                                    style: TextStyle(
                                      fontSize: 14,
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

                // Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 16),
                //     child: Container(
                //       height: 80,
                //       width: double.infinity,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(16),
                //         color: HexColor.fromHex("#132e3a"),
                //       ),
                //       child: Padding(
                //         padding: EdgeInsetsGeometry.symmetric(
                //           horizontal: 16,
                //           vertical: 16,
                //         ),
                //         child: Column(
                //           children: [
                //             Text(
                //               "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                //               textAlign: TextAlign.right,
                //               style: TextStyle(
                //                 color: HexColor.fromHex("#2dc8b9"),
                //                 fontSize: 25,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                Expanded(
                  child: OrientationBuilder(
                    builder: (context, orientation) => Column(
                      children: <Widget>[
                        Expanded(
                          child: ScrollablePositionedList.builder(
                            itemScrollController: itemScrollController,
                            itemPositionsListener: itemPositionsListener,
                            scrollOffsetController: scrollOffsetController,
                            scrollDirection: Axis.vertical,
                            itemCount: data.ayat.length,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: HexColor.fromHex("#132e3a"),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: HexColor.fromHex("#2dc8b9"),
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final ayat = data.ayat[index - 1];
                              final surah = data;
                              final isOpen = expandedIndexes.contains(index);
                              final tafsir = controller.tafsirList
                                  .firstWhereOrNull(
                                    (t) => t.ayat == ayat.nomorAyat,
                                  );

                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: HexColor.fromHex("#132e3a"),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsGeometry.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Text(
                                                      ayat.nomorAyat.toString(),
                                                      style: TextStyle(
                                                        color: HexColor.fromHex(
                                                          "#28ab9e",
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.brightness_5_sharp,
                                                      color: HexColor.fromHex(
                                                        "#28ab9e",
                                                      ).withAlpha(90),
                                                      size: 40,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Obx(() {
                                                      final isSaved =
                                                          bookmarkController
                                                              .isBookmarked(
                                                                nomor,
                                                                ayat.nomorAyat,
                                                              );
                                                      return InkWell(
                                                        onTap: () {
                                                          bookmarkController
                                                              .toggle(
                                                                nomor,
                                                                surah.nama,
                                                                ayat.nomorAyat,
                                                              );
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            color:
                                                                HexColor.fromHex(
                                                                  "#1a3a4a",
                                                                ),
                                                          ),
                                                          child: Icon(
                                                            isSaved
                                                                ? Icons.bookmark
                                                                : Icons
                                                                      .bookmark_border,
                                                            color: isSaved
                                                                ? Colors.amber
                                                                : Colors.white,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                    SizedBox(width: 8),

                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          if (expandedIndexes
                                                              .contains(
                                                                index,
                                                              )) {
                                                            expandedIndexes
                                                                .remove(index);
                                                          } else {
                                                            expandedIndexes.add(
                                                              index,
                                                            );
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          color:
                                                              HexColor.fromHex(
                                                                "#1a3a4a",
                                                              ),
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .menu_book_rounded,
                                                          color: isOpen
                                                              ? Colors.amber
                                                              : HexColor.fromHex(
                                                                  "#7c97a6",
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Obx(() {
                                                      final kondisi = controller
                                                          .getAyatAudioState(
                                                            ayat.nomorAyat,
                                                          );

                                                      return kondisi == "stop"
                                                          ? Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      12,
                                                                    ),
                                                                color:
                                                                    HexColor.fromHex(
                                                                      "#1a3a4a",
                                                                    ),
                                                              ),
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .playAudio(
                                                                        ayat,
                                                                      );
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .play_circle_filled_rounded,
                                                                  color:
                                                                      HexColor.fromHex(
                                                                        "#2dc8b9",
                                                                      ),
                                                                ),
                                                              ),
                                                            )
                                                          : SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  kondisi ==
                                                                          "playing"
                                                                      ? IconButton(
                                                                          onPressed: () {
                                                                            controller.pauseAudio(
                                                                              ayat,
                                                                            );
                                                                          },
                                                                          icon: Icon(
                                                                            Icons.pause,
                                                                            color: HexColor.fromHex(
                                                                              "#2dc8b9",
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : IconButton(
                                                                          onPressed: () {
                                                                            controller.resumeAudio(
                                                                              ayat,
                                                                            );
                                                                          },
                                                                          icon: Icon(
                                                                            Icons.play_arrow,
                                                                            color: HexColor.fromHex(
                                                                              "#2dc8b9",
                                                                            ),
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
                                                                      Icons
                                                                          .stop,
                                                                      color: HexColor.fromHex(
                                                                        "#2dc8b9",
                                                                      ),
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

                                            SizedBox(height: 15),
                                            Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    ayat.teksArab,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Divider(
                                                  color: HexColor.fromHex(
                                                    "#5a7b8a",
                                                  ).withAlpha(90),
                                                  thickness: 0.1,
                                                ),
                                                SizedBox(height: 10),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        ayat.teksLatin,
                                                        style: TextStyle(
                                                          color:
                                                              HexColor.fromHex(
                                                                "#228276",
                                                              ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        ayat.teksIndonesia,
                                                        style: TextStyle(
                                                          color:
                                                              HexColor.fromHex(
                                                                "#7c97a6",
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (expandedIndexes.contains(index))
                                    Obx(() {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
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
                                          title: SizedBox.shrink(),
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.amber.withAlpha(
                                                  10,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(16),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 16,
                                                  ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.menu_book_rounded,
                                                        color: Colors.amber,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "Tafsir",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.amber,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    tafsir?.teks ??
                                                        "Tafsir tidak tersedia.",
                                                    style: TextStyle(
                                                      color: HexColor.fromHex(
                                                        "#7c97a6",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),

                                  SizedBox(height: 20),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: 60,
                  left: 16,
                  right: 16,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: HexColor.fromHex(
                    "#0c1d27",
                  ).withValues(alpha: appBarOpacity),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#19554d").withAlpha(140),
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
                        color: HexColor.fromHex("#19554d").withAlpha(140),
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
            ),
          ],
        );
      }),
    );
  }
}
