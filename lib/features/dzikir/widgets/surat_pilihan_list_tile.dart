import 'package:alquran_new/binding/surah_binding.dart';
import 'package:alquran_new/features/dzikir/detail_surat_pilihan_screen.dart';
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
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Text(title, style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(description, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
