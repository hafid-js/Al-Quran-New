import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

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

    return Scaffold(
      extendBodyBehindAppBar: true,

      backgroundColor: HexColor.fromHex("#132e3a").withAlpha(120),

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
                                    backgroundColor: HexColor.fromHex(
                                      "#132e3a",
                                    ),
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
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
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
                                                      color: HexColor.fromHex(
                                                        "#5a7b8a",
                                                      ).withAlpha(30),
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
                                                          imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnlUZ8nhYPRQDuhjxBpB5LDivq-_YzdFzbtw&s",
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
                                                          imageUrl: "https://i1.sndcdn.com/artworks-yRdHunkzvtypsKvH-YmPLEA-t500x500.jpg",
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
                      if (controller.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: HexColor.fromHex("#2dc8b9"),
                            strokeWidth: 3,
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.surahList.length,
                        itemBuilder: (context, index) {
                          final surah = controller.surahList[index];

                            return Obx(() {
                                final kondisi = controller.getSurahAudioState(surah.nomor);
                                final activeSurahNomor = controller.activeSurahNomor.value;
                                return kondisi == "playing" && activeSurahNomor == surah.nomor
                                ? Padding(
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
                                              color: HexColor.fromHex(
                                                "#2cc4b6",
                                              ),
                                            ),
                                            color: HexColor.fromHex(
                                              "#2cc4b6",
                                            ).withAlpha(30),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                ),
                                            leading: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              onTap: () {
                                                  controller.playAudio(surah);
                                              },
                                              child: Container(
                                                height: 45,
                                                width: 45,
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
                                                    color: HexColor.fromHex(
                                                      "#2cc4b6",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              surah.namaLatin,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                            subtitle: Wrap(
                                              spacing: 5,
                                              runSpacing: 4,
                                              children: [
                                                Text(
                                                  surah.arti,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: HexColor.fromHex(
                                                      "#5a7b8a",
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 9,
                                                  ),
                                                  child: Icon(
                                                    Icons.circle,
                                                    size: 5,
                                                    color: HexColor.fromHex(
                                                      "#5a7b8a",
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "${surah.jumlahAyat} Ayat",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: HexColor.fromHex(
                                                      "#5a7b8a",
                                                    ),
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
                                                    fontSize: 20,
                                                    color: HexColor.fromHex(
                                                      "#8da6b7",
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 15),

                                                Icon(
                                                  Icons
                                                      .download_for_offline_outlined,
                                                  color: HexColor.fromHex(
                                                    "#2cc4b6",
                                                  ),
                                                  size: 22,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                      top: 10,
                                      right: 16,
                                      left: 16,
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          onTap: () {
                                            controller.playAudio(surah);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: HexColor.fromHex(
                                                "#132e3a",
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: ListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                  ),
                                              leading: Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color: HexColor.fromHex(
                                                    "#5a7b8a",
                                                  ).withAlpha(30),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    surah.nomor.toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: HexColor.fromHex(
                                                        "#2cc4b6",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                surah.namaLatin,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              subtitle: Wrap(
                                                spacing: 5,
                                                runSpacing: 4,
                                                children: [
                                                  Text(
                                                    surah.arti,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: HexColor.fromHex(
                                                        "#5a7b8a",
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 9,
                                                    ),
                                                    child: Icon(
                                                      Icons.circle,
                                                      size: 5,
                                                      color: HexColor.fromHex(
                                                        "#5a7b8a",
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${surah.jumlahAyat} Ayat",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: HexColor.fromHex(
                                                        "#5a7b8a",
                                                      ),
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
                                                      fontSize: 20,
                                                      color: HexColor.fromHex(
                                                        "#8da6b7",
                                                      ),
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
                                                      color: HexColor.fromHex(
                                                        "#2cc4b6",
                                                      ),
                                                      size: 22,
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
                          });
                        },
                      );
                    }),
                    Obx(() {
                      final nomor = controller.activeSurahNomor.value;
                      if (nomor == null) return const SizedBox.shrink();
                      final surah = controller.surahList.firstWhere((s) => s.nomor == nomor);

                      return Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: HexColor.fromHex("#132e3a"),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  left: 16,
                                  right: 16,
                                ),
                                child: LinearPercentIndicator(
                                  backgroundColor: HexColor.fromHex("#1a3a4a"),
                                  padding: EdgeInsets.zero,
                                  barRadius: const Radius.circular(16),
                                  lineHeight: 4,
                                  percent: 0.2,
                                  progressColor: HexColor.fromHex("#2cc4b6"),
                                ),
                              ),

                              ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnlUZ8nhYPRQDuhjxBpB5LDivq-_YzdFzbtw&s",
                                    width: 45,
                                    height: 45,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  surah.namaLatin,

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Text(
                                  "00:03 / 00:51",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: HexColor.fromHex("#5a7b8a"),
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex(
                                          "#5a7b8a",
                                        ).withAlpha(30),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.skip_previous_rounded,
                                          color: HexColor.fromHex("#8da6b7"),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Obx(() {
                                      final kondisi = controller.getSurahAudioState(surah.nomor);
                                      return kondisi == "playing"
                                          ? InkWell(
                                              onTap: () {
                                                controller.pauseAudio(surah);
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
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
                                                    color: HexColor.fromHex(
                                                      "#2cc4b6",
                                                    ),
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
                                                height: 40,
                                                width: 40,
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
                                                    color: HexColor.fromHex(
                                                      "#2cc4b6",
                                                    ),
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            );
                                    }),
                                    SizedBox(width: 5),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex(
                                          "#5a7b8a",
                                        ).withAlpha(30),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.skip_next_rounded,
                                          color: HexColor.fromHex("#8da6b7"),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    InkWell(
                                      onTap: () {
                                        controller.stopAudio(surah);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
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
        ],
      ),
    );
  }
}
