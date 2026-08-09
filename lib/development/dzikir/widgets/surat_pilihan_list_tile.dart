import 'package:alquran_new/binding/surah_binding.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/dzikir/screens/detail_surat_pilihan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuratPilihanListTile extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final int surahNumber;

  const SuratPilihanListTile({
    super.key,
    required this.emoji,
    required this.title,
    required this.description,
    required this.surahNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => DetailSuratPilihanScreen(),
        binding: SurahBinding(),
        arguments: {"surah": surahNumber, "ayat": null},
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                    Text(title, style: TextStyle(color: HexColor.fromHex("#256980"),fontSize: 16, fontWeight: FontWeight.w600)),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: HexColor.fromHex("#256980"),
                ),
              ],
            ),
            Text(description, style:Theme.of(context).textTheme.labelSmall!
                                  .copyWith(fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
