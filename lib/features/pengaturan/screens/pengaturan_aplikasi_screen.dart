import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class PengaturanAplikasiScreen extends StatefulWidget {
  const PengaturanAplikasiScreen({super.key});

  @override
  State<PengaturanAplikasiScreen> createState() =>
      _PengaturanAplikasiScreenState();
}

Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);

class _PengaturanAplikasiScreenState extends State<PengaturanAplikasiScreen> {
  int qariSelected = 4;
  String title = "Misyari Rasyid Al-Afi";

  int fontSelected = 1;
  String font = "Naskh";

  int modeSelected = 1;
  String mode = "Mode Gelap";

  int colorSelected = 1;
  String name = "Hijau";

  final List<Map<String, dynamic>> qoris = [
    {"title": "Abdullah Al-Juhany"},
    {"title": "Abdul Musim Al-Qasim"},
    {"title": "Abdurrahman as-Sudais"},
    {"title": "Ibraim Al-Dossari"},
    {"title": "Misyari Rasyid Al-Afsi"},
    {"title": "Yaser Al-Dosari"},
  ];

  final List<Map<String, dynamic>> fontArabs = [
    {"title": "Naskh", "subtitle": "Noto Naskh Arabic"},
    {"title": "Mushaf Madinah"},
    {"title": "Mushaf Indonesia"},
  ];

  final List<Map<String, dynamic>> themeModes = [
    {"title": "Mode Gelap", "icon": Icons.bedtime_rounded},
    {"title": "Mode Terang", "icon": Icons.sunny},
  ];

  final List<Map<String, dynamic>> colorPicker = [
    {"name": "Hijau", "color": HexColor.fromHex("#2EC4B6")},
    {"name": "Ungu", "color": HexColor.fromHex("#BB86FC")},
    {"name": "Biru", "color": HexColor.fromHex("#42A5F5")},
    {"name": "Emas", "color": HexColor.fromHex("#D4A574")},
    {"name": "Kustom", "color": "custom"},
  ];

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#132D3B").withAlpha(120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 65,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_circle_left_rounded),
          color: Colors.white,
        ),
        titleSpacing: 5,
        title: Row(
          children: [
            Container(
              height: 36,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor.fromHex("#17404a"),
              ),
              child: Icon(
                Icons.settings,
                size: 20,
                color: HexColor.fromHex("#2dc8b9"),
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Pengaturan",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 16, left: 16, bottom: 30),
          child: Column(
            children: [
              Column(
                children: [
                  ListTile(
                    minTileHeight: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.headphones_rounded,
                      size: 24,
                      color: HexColor.fromHex("#2dc8b9"),
                    ),
                    title: Text(
                      "Qari Default",
                      style: TextStyle(
                        color: HexColor.fromHex("#8BA4B4"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(qoris.length, (index) {
                      final item = qoris[index];
                      final bool isSelected = qariSelected == index;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            setState(() {
                              qariSelected = index;
                              title = item["title"];
                            });

                            if (index == 0) {
                              {}
                            }
                          },

                          child: AnimatedContainer(
                            padding: EdgeInsets.all(5),
                            duration: const Duration(milliseconds: 250),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? HexColor.fromHex("#0F3137")
                                  : HexColor.fromHex("#132D3B"),

                              borderRadius: BorderRadius.circular(16),

                              border: Border.all(
                                color: isSelected
                                    ? HexColor.fromHex("#2cc4b6")
                                    : Colors.transparent,
                                width: 1,
                              ),
                            ),

                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),

                              leading: isSelected
                                  ? Container(
                                      height: 36,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: HexColor.fromHex("#154E50"),
                                      ),
                                      child: Icon(
                                        Icons.check_circle_rounded,
                                        size: 20,
                                        color: HexColor.fromHex("#2EC4B6"),
                                      ),
                                    )
                                  : Container(
                                      height: 36,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: HexColor.fromHex("#1A3A4A"),
                                      ),
                                      child: Icon(
                                        Icons.mic_none_rounded,
                                        size: 20,
                                        color: HexColor.fromHex("#5A7A8A"),
                                      ),
                                    ),

                              title: Text(
                                item["title"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),

                              trailing: isSelected
                                  ? Icon(
                                      Icons.check_circle_rounded,
                                      color: HexColor.fromHex("#2dc8b9"),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),

              Column(
                children: [
                  ListTile(
                    minTileHeight: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.text_fields_rounded,
                      size: 24,
                      color: HexColor.fromHex("#2dc8b9"),
                    ),
                    title: Text(
                      "Font Arab",
                      style: TextStyle(
                        color: HexColor.fromHex("#8BA4B4"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(fontArabs.length, (index) {
                      final item = fontArabs[index];
                      final bool isSelected = fontSelected == index;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            setState(() {
                              fontSelected = index;
                              title = item["title"];
                            });

                            if (index == 0) {
                              {}
                            }
                          },

                          child: AnimatedContainer(
                            padding: EdgeInsets.all(5),
                            duration: const Duration(milliseconds: 250),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? HexColor.fromHex("#0F3137")
                                  : HexColor.fromHex("#132D3B"),

                              borderRadius: BorderRadius.circular(16),

                              border: Border.all(
                                color: isSelected
                                    ? HexColor.fromHex("#2cc4b6")
                                    : Colors.transparent,
                                width: 1,
                              ),
                            ),

                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),

                              leading: isSelected
                                  ? Container(
                                      height: 36,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: HexColor.fromHex("#154E50"),
                                      ),
                                      child: Icon(
                                        Icons.check_circle_rounded,
                                        size: 20,
                                        color: HexColor.fromHex("#2EC4B6"),
                                      ),
                                    )
                                  : Container(
                                      height: 36,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: HexColor.fromHex("#1A3A4A"),
                                      ),
                                      child: Icon(
                                        Icons.text_fields_rounded,
                                        size: 20,
                                        color: HexColor.fromHex("#5A7A8A"),
                                      ),
                                    ),

                              title: Text(
                                item["title"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),

                              trailing: isSelected
                                  ? Icon(
                                      Icons.check_circle_rounded,
                                      color: HexColor.fromHex("#2dc8b9"),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),

              Column(
                children: [
                  ListTile(
                    minTileHeight: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.headphones_rounded,
                      size: 24,
                      color: HexColor.fromHex("#2dc8b9"),
                    ),
                    title: Text(
                      "Tampilan",
                      style: TextStyle(
                        color: HexColor.fromHex("#8BA4B4"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: List.generate(themeModes.length, (index) {
                          final item = themeModes[index];
                          final bool isSelected = modeSelected == index;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                setState(() {
                                  modeSelected = index;
                                  title = item["title"];
                                });

                                if (index == 0) {
                                  {}
                                }
                              },

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 43,
                                      vertical: 15,
                                    ),
                                    duration: const Duration(milliseconds: 250),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? HexColor.fromHex("#0F3137")
                                          : HexColor.fromHex("#132D3B"),

                                      borderRadius: BorderRadius.circular(16),

                                      border: Border.all(
                                        color: isSelected
                                            ? HexColor.fromHex("#2cc4b6")
                                            : Colors.transparent,
                                        width: 1.5,
                                      ),
                                    ),

                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          item["icon"],
                                          size: 30,
                                          color: isSelected
                                              ? HexColor.fromHex("#2EC4B6")
                                              : HexColor.fromHex("#5A7A8A"),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          item["title"],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: isSelected
                                                ? HexColor.fromHex("#2EC4B6")
                                                : Colors.white,
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: List.generate(colorPicker.length, (index) {
                          final item = colorPicker[index];
                          final bool isSelected = colorSelected == index;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                setState(() {
                                  colorSelected = index;
                                  name = item["name"];
                                });

                                if (index == 0) {
                                  {}
                                }
                              },

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (item["color"] == "custom")
                                      ? GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                backgroundColor:
                                                    HexColor.fromHex("#132D3B"),
                                                title: Text(
                                                  'Tentukan Warna',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),

                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    pickerColor: pickerColor,
                                                    onColorChanged: changeColor,
                                                  ),
                                                ),

                                                actions: [
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      elevation:
                                                          WidgetStatePropertyAll(
                                                            0,
                                                          ),
                                                      foregroundColor:
                                                          WidgetStatePropertyAll(
                                                            HexColor.fromHex(
                                                              "#2EC4B6",
                                                            ),
                                                          ),
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                            HexColor.fromHex(
                                                              "#153945",
                                                            ),
                                                          ),
                                                    ),

                                                    child: const Text('Got it'),

                                                    onPressed: () {
                                                      setState(() {
                                                        currentColor =
                                                            pickerColor;
                                                        colorSelected = index;
                                                      });

                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: AnimatedContainer(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 12,
                                            ),
                                            duration: const Duration(
                                              milliseconds: 250,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? HexColor.fromHex("#0F3137")
                                                  : HexColor.fromHex("#132D3B"),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color:
                                                    (isSelected &&
                                                        item["color"] ==
                                                            "custom")
                                                    ? HexColor.fromHex(
                                                        "#2cc4b6",
                                                      )
                                                    : Colors.transparent,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    // gradient: LinearGradient(
                                                    //   colors: [
                                                    //     Colors.red,
                                                    //     Colors.green,
                                                    //     Colors.blue,
                                                    //   ],
                                                    // ),
                                                    color: currentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30,
                                                        ),
                                                  ),
                                                  child: Icon(
                                                    Icons.edit_rounded,
                                                    size: 20,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  item["name"],
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color: isSelected
                                                        ? HexColor.fromHex(
                                                            "#2EC4B6",
                                                          )
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : AnimatedContainer(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 12,
                                          ),
                                          duration: const Duration(
                                            milliseconds: 250,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? HexColor.fromHex("#0F3137")
                                                : HexColor.fromHex("#132D3B"),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            border: Border.all(
                                              color:
                                                  (isSelected &&
                                                      item["color"] != "custom")
                                                  ? HexColor.fromHex("#2cc4b6")
                                                  : Colors.transparent,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: item["color"],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                item["name"],
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  color: isSelected
                                                      ? HexColor.fromHex(
                                                          "#2EC4B6",
                                                        )
                                                      : Colors.white,
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
                      ),
                    ],
                  ),
                ],
              ),

              Column(
                children: [
                  ListTile(
                    minTileHeight: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.error_rounded,
                      size: 24,
                      color: HexColor.fromHex("#2dc8b9"),
                    ),
                    title: Text(
                      "Tentang",
                      style: TextStyle(
                        color: HexColor.fromHex("#8BA4B4"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#132D3B"),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor.fromHex("#154E50"),
                            ),
                            child: Icon(
                              Icons.menu_book_rounded,
                              size: 25,
                              color: HexColor.fromHex("#2EC4B6"),
                            ),
                          ),
                          title: Text(
                            "Al-Barokah Mobile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            "Versi 1.0.0",
                            style: TextStyle(
                              color: HexColor.fromHex("#5A7A8A"),
                            ),
                          ),
                        ),
                        Text(
                          ''' Al-Barokah ID Official Mobile App

Aplikasi resmi dari Hafid Tech yang menyediakan Al-Quran digital lengkap dengan tafsir, audio murottal dari berbagai qari , doa harian, jadwal sholat, arah kiblat, dan fitur islami lainnya.  ''',
                          style: TextStyle(color: HexColor.fromHex("#5A7A8A")),
                        ),

                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email_rounded,
                              size: 20,
                              color: HexColor.fromHex("#2EC4B6"),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Kontak: admin@hafidtech.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor.fromHex("#5A7A8A"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: HexColor.fromHex("#153945"),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.email_rounded,
                                      size: 18,
                                      color: HexColor.fromHex("#2EC4B6"),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Syarat & Ketentuan",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: HexColor.fromHex("#2EC4B6"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: HexColor.fromHex("#153945"),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.email_rounded,
                                      size: 18,
                                      color: HexColor.fromHex("#2EC4B6"),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Kebijakan Privasi",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: HexColor.fromHex("#2EC4B6"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }
}
