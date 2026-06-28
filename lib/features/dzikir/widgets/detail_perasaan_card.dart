import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/features/surat/controllers/detail_surah_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alquran_new/features/alquran/domain/entities/ayat.dart';

class DetailPerasaanCard extends StatefulWidget {
  DetailPerasaanCard({
    super.key,
    required this.nomorAyat,
    required this.ayat,
    required this.nama,
    required this.teksArab,
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
  final String teksLatin;
  final String teksIndonesia;
  final VoidCallback? onIncrement;
  final double ukuranTeksArab;
  final double ukuranTeksLatinTerjemah;

  @override
  State<DetailPerasaanCard> createState() => _DetailPerasaanCardState();
}

final controller = Get.find<DetailSurahController>();

class _DetailPerasaanCardState extends State<DetailPerasaanCard> {
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
                        ? Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: IconButton(
                              onPressed: () {
                                controller.playAudio(widget.ayat);
                              },
                              icon: Icon(
                                Icons.play_circle_filled_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              ),
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
                  fontWeight: FontWeight.bold,
                  fontSize: widget.ukuranTeksArab,
                  fontFamily: fontFamily,
                  height: 2,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "${widget.teksLatin}",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 14,
              fontFamily: fontFamily,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "${widget.teksIndonesia}",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 12,
              fontFamily: fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
