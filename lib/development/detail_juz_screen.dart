import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/alquran_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DetailJuzScreen extends StatefulWidget {
  const DetailJuzScreen({super.key});

  @override
  State<DetailJuzScreen> createState() => _DetailJuzScreenState();
}

class _DetailJuzScreenState extends State<DetailJuzScreen> {
  final controller = Get.put(JuzController(), permanent: false);
  final ItemScrollController itemScrollController = ItemScrollController();

  late int juzNumber;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map;
    juzNumber = args["juz"];

    controller.fetchJuz(juzNumber);
  }

  @override
  void dispose() {
    if (controller.juzAyatList.isNotEmpty) {
      controller.stopAudio(controller.juzAyatList.first);
    }
    Get.delete<JuzController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          "Juz $juzNumber",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Icon(Iconsax.book_1, color: Colors.black),
          SizedBox(width: 15),
          Icon(Iconsax.setting_4, color: Colors.black),
        ],
        actionsPadding: EdgeInsets.all(16),
      ),
      body: Obx(() {
         if (controller.isLoading.value) {
          return Container(
              color: Colors.white,
              child: Center(
                child: Image.asset('assets/animations/bar_loader.gif', height:100),
              )
            );
        }

        final ayatList = controller.juzAyatList;

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
                                  text: "Juz:",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text.rich(
                                TextSpan(
                                  text: "$juzNumber",
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
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ayat.teksArab,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,

                            height: 2.5,
                          ),
                        ),
                      ),
                      
                           SizedBox(height: 30),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ayat.teksLatin,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                          ),
                        ),
                      ),
                    SizedBox(height: 10),
                    Text(
                        ayat.teksIndonesia,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14
                        ),
                      ),
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
