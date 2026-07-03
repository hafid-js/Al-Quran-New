import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/features/surat/controllers/detail_surah_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:alquran_new/features/alquran/domain/entities/ayat.dart';

class SuratPilihanCard extends StatefulWidget {
  SuratPilihanCard({
    super.key,
    required this.nomorAyat,
    required this.ayat,
    required this.nama,
    required this.teksArab,
    this.isBold = true,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.ukuranTeksArab,
    required this.ukuranTeksLatinTerjemah,
    this.onIncrement,
  });

  final int nomorAyat;
  final Ayat ayat;
  final String nama;
  final String teksArab;
  final bool isBold;
  final String teksLatin;
  final String teksIndonesia;
  final VoidCallback? onIncrement;
  final double ukuranTeksArab;
  final double ukuranTeksLatinTerjemah;

  @override
  State<SuratPilihanCard> createState() => _SuratPilihanCardState();
}

final controller = Get.find<DetailSurahController>();

class _SuratPilihanCardState extends State<SuratPilihanCard> {
  Set<int> expandedIndexes = {};
  @override
  Widget build(BuildContext context) {
    final SettingsController setting = Get.find<SettingsController>();
    final selectedIndex = setting.fontSelected.value;
    final fontFamily = fontArabs[selectedIndex]["nama"];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Ayat ${widget.nomorAyat}",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Obx(() {
                    final kondisi = controller.getAyatAudioState(
                      widget.nomorAyat,
                    );

                    return kondisi == "stop"
                        ? IconButton(
                            onPressed: () {
                              controller.playAudio(widget.ayat);
                            },
                            icon: Icon(
                              Icons.play_circle_filled_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 28,
                            ),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                kondisi == "playing"
                                    ? IconButton(
                                        onPressed: () {
                                          controller.pauseAudio(widget.ayat);
                                        },
                                        icon: Icon(
                                          Icons.pause,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          controller.resumeAudio(widget.ayat);
                                        },
                                        icon: Icon(
                                          Icons.play_arrow,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                IconButton(
                                  onPressed: () {
                                    controller.stopAudio(widget.ayat);
                                  },
                                  icon: Icon(
                                    Icons.stop,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
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
          SizedBox(height: 20),
          Obx(() {
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 18),
                    child: Text(
                      "${widget.teksArab}",
                      softWrap: true,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: widget.isBold ? FontWeight.bold : null,
                        fontSize: widget.ukuranTeksArab,
                        fontFamily: fontFamily,
                        height: 2,
                      ),
                    ),
                  ),
                ),
                if (controller.latin.value) ...[
                  SizedBox(height: 10),
                  Text(
                    "${widget.teksLatin}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: Responsive.fontSize(
                        context,
                        phone: controller.ukuranLatinTerjemah.value,
                      ),
                      fontFamily: fontFamily,
                    ),
                  ),
                ],
                if (controller.terjemah.value) ...[
                  SizedBox(height: 10),
                  Text(
                    "${widget.teksIndonesia}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: Responsive.fontSize(
                        context,
                        phone: controller.ukuranLatinTerjemah.value,
                      ),
                      fontFamily: fontFamily,
                    ),
                  ),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }
}
