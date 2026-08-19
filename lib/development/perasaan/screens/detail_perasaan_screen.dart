import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
import 'package:alquran_new/development/shared/widgets/common_loading_widget.dart';
import 'package:alquran_new/development/shared/widgets/settings_slider.dart';
import 'package:alquran_new/development/shared/widgets/settings_switch.dart';
import 'package:alquran_new/development/perasaan/controllers/doa_perasaan_controller.dart';
import 'package:alquran_new/development/perasaan/models/doa_perasaan_model.dart';
import 'package:alquran_new/development/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailPerasaanScreen extends StatefulWidget {
  final String type;
  const DetailPerasaanScreen({super.key, required this.type});

  @override
  State<DetailPerasaanScreen> createState() => _DetailPerasaanScreenState();
}

class _DetailPerasaanScreenState extends State<DetailPerasaanScreen>
    with SingleTickerProviderStateMixin {
  late final DoaPerasaanController controller;
  final SettingsController settings = Get.find<SettingsController>();
  late AnimationController _animationController;
  late Animation<double> _rotation;
  late Animation<double> _scale;
  bool _isRotated = false;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DoaPerasaanController(type: widget.type));

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

  void _toggle() {
    setState(() {
      _isRotated = !_isRotated;
    });

    if (_isRotated) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    Get.delete<DoaPerasaanController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: CommonAppBar(
        title: controller.title,
        actions: [
          GestureDetector(
            onTap: () async {
              _toggle();

              await WoltModalSheet.show(
                context: context,
                pageListBuilder: (context) => [
                  SliverWoltModalSheetPage(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    hasTopBarLayer: false,
                    mainContentSliversBuilder: (context) => [
                      SliverToBoxAdapter(
                        child: StatefulBuilder(
                          builder: (context, modalSetState) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Pengaturan",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: HexColor.fromHex("#256980"),
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SettingsSwitchTile(
                                    title: "Terjemah",
                                    value: controller.terjemah.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        controller.terjemah.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 5),

                                  SettingsSwitchTile(
                                    title: "Latin",
                                    value: controller.latin.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        controller.latin.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 5),

                                  SettingsSwitchTile(
                                    title: "Font Arab Tebal",
                                    value: controller.arabBold.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        controller.arabBold.value = v;
                                      });
                                    },
                                  ),

                                  const SizedBox(height: 18),
                                  SettingsSlider(
                                    label: "Ukuran Teks Arab",
                                    value: controller.ukuranTeksArab.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        controller.ukuranTeksArab.value = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  SettingsSlider(
                                    label: "Ukuran Teks latin & Terjemah",
                                    value: controller.ukuranLatinTerjemah.value,
                                    onChanged: (v) {
                                      modalSetState(() {
                                        controller.ukuranLatinTerjemah.value = v;
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
                _toggle();
              }
            },
            child: RotationTransition(
              turns: _rotation,
              child: ScaleTransition(
                scale: _scale,
                child: Icon(
                  _isRotated ? Iconsax.setting_45 : Iconsax.setting_4,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.all(16),
      ),
      body: Obx(() {
        final ukuranArab = controller.ukuranTeksArab.value;
        final ukuranLatin = controller.ukuranLatinTerjemah.value;
        final showLatin = controller.latin.value;
        final showTerjemah = controller.terjemah.value;
        final isBold = controller.arabBold.value;

        if (controller.isLoading.value) {
          return CommonLoadingWidget();
        }

        if (controller.data.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.note_2,
                  size: 64,
                  color: HexColor.fromHex("#DBB893"),
                ),
                SizedBox(height: 16),
                Text(
                  "Tidak ada data",
                  style: TextStyle(
                    color: HexColor.fromHex("#1E4355"),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            return _buildItem(
              item: controller.data[index],
              ukuranArab: ukuranArab,
              ukuranLatin: ukuranLatin,
              showLatin: showLatin,
              showTerjemah: showTerjemah,
              isBold: isBold,
            );
          },
        );
      }),
    );
  }

  Widget _buildItem({
    required DoaPerasaanModel item,
    required double ukuranArab,
    required double ukuranLatin,
    required bool showLatin,
    required bool showTerjemah,
    required bool isBold,
  }) {
    final selectedIndex = settings.fontSelected.value;
    final fontFamily = fontArabs[selectedIndex]["title"];

    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${item.nomor}",
              style: TextStyle(
                color: HexColor.fromHex("#D39D52"),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  item.arab,
                  softWrap: true,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ukuranArab,
                    fontFamily: fontFamily,
                    fontWeight: isBold ? FontWeight.w600 : null,
                    height: 2.5,
                  ),
                ),
              ),
            ),
            if (showLatin) ...[
              SizedBox(height: 12),
              Text(
                item.latin,
                style: TextStyle(
                  color: HexColor.fromHex("#256980"),
                  fontSize: ukuranLatin,
                ),
              ),
            ],
            if (showTerjemah) ...[
              SizedBox(height: 8),
              Text(
                item.arti,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ukuranLatin,
                ),
              ),
            ],
            if (item.keterangan != null ||
                (item.sumber).isNotEmpty) ...[
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 3,
                      color: HexColor.fromHex("#D39D52"),
                    ),
                  ),
                  color: HexColor.fromHex("#D39D52").withAlpha(10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.keterangan != null) ...[
                      Text(
                        "Faedah/Konteks:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ukuranLatin,
                          color: HexColor.fromHex("#1E4355"),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        item.keterangan!,
                        style: TextStyle(
                          fontSize: ukuranLatin,
                          color: HexColor.fromHex("#1E4355"),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                    Text(
                      "Sumber: ${item.sumber}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ukuranLatin,
                        color: HexColor.fromHex("#1E4355"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 12),
            Divider(
              thickness: 1,
              color: const Color.fromARGB(81, 158, 158, 158),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final buffer = StringBuffer();
                      buffer.writeln(item.arab);
                      if (showLatin) {
                        buffer.writeln('');
                        buffer.writeln(item.latin);
                      }
                      if (showTerjemah) {
                        buffer.writeln('');
                        buffer.writeln(item.arti);
                      }
                      if ((item.keterangan ?? '').isNotEmpty) {
                        buffer.writeln('');
                        buffer.writeln(
                            'Faedah/Konteks: ${item.keterangan}');
                      }
                      buffer.writeln('');
                      buffer.writeln('Sumber: ${item.sumber}');
                      await Clipboard.setData(
                        ClipboardData(text: buffer.toString()),
                      );
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Berhasil Disalin'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(37, 158, 158, 158),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Iconsax.copy,
                        color: HexColor.fromHex("#504F52"),
                        size: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final buffer = StringBuffer();
                      buffer.writeln(controller.title);
                      buffer.writeln('');
                      buffer.writeln(item.arab);
                      if (showLatin) {
                        buffer.writeln('');
                        buffer.writeln(item.latin);
                      }
                      if (showTerjemah) {
                        buffer.writeln('');
                        buffer.writeln(item.arti);
                      }
                      if ((item.keterangan ?? '').isNotEmpty) {
                        buffer.writeln('');
                        buffer.writeln(
                            'Faedah/Konteks: ${item.keterangan}');
                      }
                      buffer.writeln('');
                      buffer.writeln('Sumber: ${item.sumber}');
                      Clipboard.setData(
                        ClipboardData(text: buffer.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Berhasil Disalin'),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(37, 158, 158, 158),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Iconsax.export_2,
                        color: HexColor.fromHex("#504F52"),
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
