import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/ui/webview_page.dart';
import 'package:alquran_new/core/utils/constants/app_colors.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
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


  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: 65,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_circle_left_rounded),
            color: Theme.of(context).iconTheme.color,
          ),
          titleSpacing: 5,
          title: Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Icon(
                  Icons.settings,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(width: 10),
              Text("Pengaturan", style: Theme.of(context).textTheme.titleLarge),
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "Qari Default",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Column(
                      children: List.generate(qoris.length, (index) {
                        final item = qoris[index];
                        final bool isSelected =
                            controller.qariSelected.value == index;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              controller.changeQari(index);
                            },

                            child: AnimatedContainer(
                              padding: EdgeInsets.all(5),
                              duration: const Duration(milliseconds: 250),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.surface
                                    : Theme.of(context).cardColor,

                                borderRadius: BorderRadius.circular(16),

                                border: Border.all(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
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
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surface,
                                        ),
                                        child: Icon(
                                          Icons.check_circle_rounded,
                                          size: 20,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      )
                                    : Container(
                                        height: 36,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: isDark
                                              ? HexColor.fromHex("#1A3A4A")
                                              : HexColor.fromHex("#E8F0EE"),
                                        ),
                                        child: Icon(
                                          Icons.mic_none_rounded,
                                          size: 20,
                                          color: HexColor.fromHex("#5A7A8A"),
                                        ),
                                      ),

                                title: Text(
                                  item["title"],
                                  style: TextStyle(
                                    fontSize: Theme.of(
                                      context,
                                    ).textTheme.titleSmall?.fontSize,
                                    color: isDark
                                        ? AppColors.light
                                        : (isSelected
                                              ? Theme.of(
                                                  context,
                                                ).colorScheme.primary
                                              : Theme.of(
                                                  context,
                                                ).textTheme.titleLarge?.color),
                                  ),
                                ),

                                trailing: isSelected
                                    ? Icon(
                                        Icons.check_circle_rounded,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "Font Arab",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Column(
                      children: List.generate(fontArabs.length, (index) {
                        final item = fontArabs[index];
                        final bool isSelected = controller.fontSelected.value == index;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              controller.changeFont(index);
                            },

                            child: AnimatedContainer(
                              padding: EdgeInsets.all(5),
                              duration: const Duration(milliseconds: 250),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.surface
                                    : Theme.of(context).cardColor,

                                borderRadius: BorderRadius.circular(16),

                                border: Border.all(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
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
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary.withAlpha(80),
                                        ),
                                        child: Icon(
                                          Icons.check_circle_rounded,
                                          size: 20,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      )
                                    : Container(
                                        height: 36,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: isDark
                                              ? HexColor.fromHex("#1A3A4A")
                                              : HexColor.fromHex("#E8F0EE"),
                                        ),
                                        child: Icon(
                                          Icons.text_fields_rounded,
                                          size: 20,
                                          color: HexColor.fromHex("#5A7A8A"),
                                        ),
                                      ),

                                title: Text(
                                  item["title"],
                                  style: TextStyle(
                                    fontSize: Theme.of(
                                      context,
                                    ).textTheme.titleSmall?.fontSize,
                                    color: isDark
                                        ? AppColors.light
                                        : (isSelected
                                              ? Theme.of(
                                                  context,
                                                ).colorScheme.primary
                                              : Theme.of(
                                                  context,
                                                ).textTheme.titleLarge?.color),
                                  ),
                                ),

                                trailing: isSelected
                                    ? Icon(
                                        Icons.check_circle_rounded,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "Tampilan",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            children: List.generate(themeModes.length, (index) {
                              final item = themeModes[index];
                              final bool isSelected =
                                  controller.modeSelected.value == index;

                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: index != themeModes.length - 1
                                        ? 10
                                        : 0,
                                    left: index == themeModes.length - 1
                                        ? 10
                                        : 0,
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      controller.changeMode(index);
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.surface
                                            : Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: isSelected
                                              ? Theme.of(
                                                  context,
                                                ).colorScheme.primary
                                              : Colors.transparent,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            item["icon"],
                                            size: 30,
                                            color: isSelected
                                                ? Theme.of(
                                                    context,
                                                  ).colorScheme.primary
                                                : HexColor.fromHex("#5A7A8A"),
                                          ),

                                          const SizedBox(height: 10),

                                          Text(
                                            item["title"],
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: isSelected
                                                  ? Theme.of(
                                                      context,
                                                    ).colorScheme.primary
                                                  : Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: List.generate(colorPicker.length, (
                              index,
                            ) {
                              final item = colorPicker[index];
                              final bool isSelected =
                                  controller.colorSelected.value == index;

                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                  right: 5,
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    controller.changeColor(
                                      index,
                                      item['color'] as Color,
                                    );
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
                                                        HexColor.fromHex(
                                                          "#132D3B",
                                                        ),
                                                    title: Text(
                                                      'Tentukan Warna',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),

                                                    content:
                                                        SingleChildScrollView(
                                                          child: ColorPicker(
                                                            pickerColor:
                                                                pickerColor,
                                                            onColorChanged:
                                                                changeColor,
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

                                                        child: const Text(
                                                          'Simpan',
                                                        ),

                                                        onPressed: () async {
                                                          await controller
                                                              .changeColor(
                                                                index,
                                                                pickerColor,
                                                              );

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
                                                  horizontal: 16,
                                                  vertical: 12,
                                                ),
                                                duration: const Duration(
                                                  milliseconds: 250,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Theme.of(
                                                          context,
                                                        ).colorScheme.surface
                                                      : Theme.of(
                                                          context,
                                                        ).cardColor,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  border: Border.all(
                                                    color:
                                                        (isSelected &&
                                                            item["color"] ==
                                                                "custom")
                                                        ? Theme.of(
                                                            context,
                                                          ).colorScheme.primary
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: isSelected
                                                            ? Theme.of(context)
                                                                  .colorScheme
                                                                  .primary
                                                            : Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge
                                                                  ?.color,
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
                                                    ? Theme.of(
                                                        context,
                                                      ).colorScheme.surface
                                                    : Theme.of(
                                                        context,
                                                      ).cardColor,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                  color:
                                                      (isSelected &&
                                                          item["color"] !=
                                                              "custom")
                                                      ? Theme.of(
                                                          context,
                                                        ).colorScheme.primary
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: isSelected
                                                          ? Theme.of(context)
                                                                .colorScheme
                                                                .primary
                                                          : Theme.of(context)
                                                                .textTheme
                                                                .titleLarge
                                                                ?.color,
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "Tentang",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
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
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: Icon(
                                Icons.menu_book_rounded,
                                size: 25,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            title: Text(
                              "Al-Barokah Mobile",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: Text(
                              "Versi 1.0.0",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          Text(
                            ''' Al-Barokah ID Official Mobile App

Aplikasi resmi dari Hafid Tech yang menyediakan Al-Quran digital lengkap dengan tafsir, audio murottal dari berbagai qari , doa harian, jadwal sholat, arah kiblat, dan fitur islami lainnya.  ''',
                            style: TextStyle(
                              color: HexColor.fromHex("#5A7A8A"),
                            ),
                          ),

                          SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email_rounded,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Kontak: admin@hafidtech.com",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => const LocalWebViewPage(
                                          title: "Syarat & Ketentuan",
                                          assetPath: "assets/terms.html",
                                        ),
                                      );
                                    },
                                    child: _menuButton(
                                      context,
                                      Icons.email_rounded,
                                      "Syarat & Ketentuan",
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => const LocalWebViewPage(
                                          title: "Kebijakan Privasi",
                                          assetPath:
                                              "assets/privacy_policy.html",
                                        ),
                                      );
                                    },
                                    child: _menuButton(
                                      context,
                                      Icons.security_rounded,
                                      "Kebijakan Privasi",
                                    ),
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
    });
  }
}

Widget _menuButton(BuildContext context, IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    ),
  );
}
