import 'package:alquran_new/features/doa/data/doas.dart';
import 'package:alquran_new/features/doa/widgets/category_filter.dart';
import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  final List<String> categories = [
    "Semua",
    "Bacaan Bila Kagum Terhadap Sesuatu",
    "Bacaan",
  ];

  String activeCategory = "Semua";

  List<Map<String, String>> get filteredDoas {
    if (activeCategory == "Semua") {
      return doas;
    }
    return doas.where((doa) => doa["nama_doa"] == activeCategory).toList();
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
                  "Doa",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "227 Doa",
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
                              "Cari Doa...",
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
                itemCount: filteredDoas.length,
                itemBuilder: (context, index) {
                  final doa = filteredDoas[index];

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: HexColor.fromHex("#132e3a"),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(left: 16),
                                  leading: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: HexColor.fromHex("#17404a"),
                                    ),
                                    child: Center(
                                      child: Text(
                                        doa['nomor']!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor.fromHex("#2dc8b9"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    doa['nama_doa']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  subtitle: Text(
                                    doa['subtitle']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: HexColor.fromHex("#7c97a6"),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      WoltModalSheet.show(
                                        context: context,
                                        pageListBuilder: (bottomSheetContext) => [
                                          SliverWoltModalSheetPage(
                                            backgroundColor: HexColor.fromHex(
                                              "#132e3a",
                                            ),
                                            hasTopBarLayer: false,
                                            mainContentSliversBuilder: (context) => [
                                              SliverToBoxAdapter(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    right: 20,
                                                    left: 20,
                                                    top: 25,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Doa Sebelum Tidur 1",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "Doa Sebelum Tidur dan Sesudah Tidur",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              HexColor.fromHex(
                                                                "#7c97a6",
                                                              ),
                                                        ),
                                                      ),

                                                      SizedBox(height: 20),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color:
                                                              HexColor.fromHex(
                                                                "#0c1d27",
                                                              ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                16,
                                                              ),
                                                          child: Text(
                                                            "بِاسْمِكَ رَبِّيْ وَضَعْتُ جَنْبِيْ، وَبِكَ أَرْفَعُهُ، إِنْ أَمْسَكْتَ نَفْسِيْ فَارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِيْنَ",
                                                            style: TextStyle(
                                                              fontSize: 27,
                                                              color:
                                                                  Colors.white,
                                                              height: 2,
                                                            ),
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                        "Bismika robbii wa dho'tu janbii, wa bika arfa'uhu, in amsakta nafsii farhamhaa, wa in arsaltahaa fahfazhhaa bimaa tahfazhu bihi 'ibaadakash-sholihiin.",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              HexColor.fromHex(
                                                                "#2dc8b9",
                                                              ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                        "Dengan nama Engkau, wahai Tuhanku, aku meletakkan lambungku. Dan dengan namaMu pula aku bangun daripadanya. Apabila Engkau menahan rohku (mati), maka berilah rahmat padanya. Tapi apabila Engkau melepaskannya, maka peliharalah, sebagaimana Engkau memelihara hamba-hambaMu yang shalih.",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              HexColor.fromHex(
                                                                "#7c97a6",
                                                              ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: Colors.amber
                                                              .withAlpha(10),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                16,
                                                              ),
                                                          child: Text(
                                                            """ HR. Al-Bukhari 11/126, Muslim 4/2084.
"Apabila seseorang di antara kalian bangkit dari tempat tidurnya kemudian ingin kembali lagi, hendaknya ia mengibaskan ujung kainnya 3x, dan menyebut nama Allah, karena ia tidak tahu apa yang ditinggalkannya di atas tempat tidur setelah ia bangkit. Apabila ia ingin berbaring, maka hendaknya ia membaca: (doa di atas)."


Sumber: Hisnul Muslim. """,
                                                            style: TextStyle(
                                                              color:
                                                                  HexColor.fromHex(
                                                                    "#7c97a6",
                                                                  ),
                                                              height: 2,
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_circle_right_rounded,
                                    ),
                                    color: HexColor.fromHex("#7c97a6"),
                                  ),
                                ),
                              ),
                            ],
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
