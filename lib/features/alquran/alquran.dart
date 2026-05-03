import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/features/alquran/models/surah_model.dart';
import 'package:alquran_new/features/surat/detail_surat.dart';
import 'package:alquran_new/features/alquran/widgets/category_filter.dart';
import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OctagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    double cut = 20;

    Path path = Path();
    path.moveTo(cut, 0);
    path.lineTo(w - cut, 0);
    path.lineTo(w, cut);
    path.lineTo(w, h - cut);
    path.lineTo(w - cut, h);
    path.lineTo(cut, h);
    path.lineTo(0, h - cut);
    path.lineTo(0, cut);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AlQuranScreen extends StatefulWidget {
  const AlQuranScreen({super.key});

  @override
  State<AlQuranScreen> createState() => _AlQuranScreenState();
}

class _AlQuranScreenState extends State<AlQuranScreen> {
  final SurahController controller = Get.put(SurahController());
  final List<String> categories = ["Surah", "Mekah", "Madinah"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#0c1d27"),
      appBar: AppBar(
        backgroundColor: HexColor.fromHex("#0c1d27"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_circle_left_rounded),
          color: Colors.white,
        ),
        titleSpacing: 5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 36,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor.fromHex("#17404a"),
              ),
              child: Icon(
                Icons.menu_book_rounded,
                size: 20,
                color: HexColor.fromHex("#2dc8b9"),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Al-Quran",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: HexColor.fromHex("#2dc8b9"),
                        strokeWidth: 3,
                      ),
                    );
                  }
                  return Text(
                    "${controller.surahList.length} Doa",
                    style: TextStyle(
                      color: HexColor.fromHex("#7c97a6"),
                      fontSize: 14,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 55,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: HexColor.fromHex("#132e3a"),
                      ),

                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: HexColor.fromHex("#7c97a6"),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              "Cari Surat...",
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor.fromHex("#7c97a6"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Obx(() {
              return CategoryFilter(
                categories: categories,
                activeCategory: controller.activeCategory.value,
                onCategorySelected: (category) {
                  controller.filter(category);
                },
              );
            }),

            SizedBox(height: 15),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: HexColor.fromHex("#2dc8b9"),
                      strokeWidth: 3,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.filteredSurah.length,
                  itemBuilder: (context, index) {
                    final surah = controller.filteredSurah[index];

                    return Column(
                      children: [
                        InkWell(
                          onTap: () => Get.to(() => DetailSuratScreen(), arguments: surah.nomor),
                          child: Container(
                            height: 90,
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#132e3a"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            surah.nomor.toString(),
                                            style: TextStyle(
                                              color: HexColor.fromHex(
                                                "#28ab9e",
                                              ),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Icon(
                                            Icons.brightness_5_sharp,
                                            color: HexColor.fromHex(
                                              "#28ab9e",
                                            ).withAlpha(90),
                                            size: 45,
                                          ),
                                        ],
                                      ),

                                      SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            surah.namaLatin,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width:
                                                    surah.tempatTurun.toApi() == "Mekah"
                                                    ? 70
                                                    : 80,
                                                decoration: BoxDecoration(
                                                  color:
                                                      surah.tempatTurun
                                                              .toApi() ==
                                                          "Mekah"
                                                      ? HexColor.fromHex(
                                                          "#19393b",
                                                        )
                                                      : HexColor.fromHex(
                                                          "#133550",
                                                        ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    surah.tempatTurun.toApi(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          surah.tempatTurun
                                                                  .toApi() ==
                                                              "Madinah"
                                                          ? HexColor.fromHex(
                                                              "#4d9ee1",
                                                            )
                                                          : HexColor.fromHex(
                                                              "#57aa5e",
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "${surah.jumlahAyat} Ayat",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: HexColor.fromHex(
                                                    "#5a7b8a",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            softWrap: false,
                                            textDirection: TextDirection.rtl,
                                            surah.nama,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor.fromHex(
                                                "#28ab9e",
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            surah.arti,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: HexColor.fromHex(
                                                "#5a7b8a",
                                              ),
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
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
