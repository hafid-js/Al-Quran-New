import 'package:alquran_new/features/alquran/data/surats.dart';
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
  final List<String> categories = ["Surat", "Makkiyah", "Madaniyah"];

  String activeCategory = "Surat";

  List<Map<String, String>> get filteredSurats {
    if (activeCategory == "Surat") {
      return surats;
    }
    return surats
        .where((surat) => surat["tempat_turun"] == activeCategory)
        .toList();
  }

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
                Text(
                  "114 Surat",
                  style: TextStyle(
                    color: HexColor.fromHex("#7c97a6"),
                    fontSize: 14,
                  ),
                ),
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

            CategoryFilter(
              categories: categories,
              activeCategory: activeCategory,
              onCategorySelected: (category) {
                setState(() {
                  activeCategory = category;
                });
              },
            ),

            SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: filteredSurats.length,
                itemBuilder: (context, index) {
                  final surat = filteredSurats[index];

                  return Column(
                    children: [
                      InkWell(
                        onTap: () => Get.to(() => DetailSuratScreen()),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Text(
                                          surat['nomor']!,
                                          style: TextStyle(
                                            color: HexColor.fromHex("#28ab9e"),
                                            fontWeight: FontWeight.w500,
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

                                    SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          surat['nama_surat']!,
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
                                                  surat['tempat_turun'] ==
                                                      "Makkiyah"
                                                  ? 70
                                                  : 80,
                                              decoration: BoxDecoration(
                                                color:
                                                    surat['tempat_turun'] ==
                                                        "Makkiyah"
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
                                                  surat['tempat_turun']!,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        surat['tempat_turun'] ==
                                                            "Madaniyah"
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
                                              "${surat['jumlah_ayat']!} Ayat",
                                              style: TextStyle(
                                                fontSize: 14,
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
                                Column(
                                  children: [
                                    Text(
                                      surat['nama_surat_arab']!,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor.fromHex("#28ab9e"),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      surat['arti']!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: HexColor.fromHex("#5a7b8a"),
                                      ),
                                    ),
                                  ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
