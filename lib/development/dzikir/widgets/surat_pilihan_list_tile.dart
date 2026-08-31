import 'package:alquran_new/binding/surah_binding.dart';
import 'package:alquran_new/core/constants/app_colors.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                    Text(title, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: isDark ? AppColors.secondary : AppColors.primary)),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.primary,
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(description,                             style: Theme.of(context).textTheme.labelSmall!.copyWith(  color: isDark ? AppColors.textPrimaryDark.withAlpha(200) : HexColor.fromHex("#676767"),)),
          ],
        ),
      ),
    );
  }
}
