import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
import 'package:alquran_new/development/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PengaturanAplikasi extends StatefulWidget {
  const PengaturanAplikasi({super.key});

  @override
  State<PengaturanAplikasi> createState() => _PengaturanAplikasiState();
}

class _PengaturanAplikasiState extends State<PengaturanAplikasi> {
  final controller = Get.find<SettingsController>();

  final List<Map<String, dynamic>> qoris = [
    {"title": "Abdullah Al-Juhany"},
    {"title": "Abdul Musim Al-Qasim"},
    {"title": "Abdurrahman as-Sudais"},
    {"title": "Ibraim Al-Dossari"},
    {"title": "Misyari Rasyid Al-Afsi"},
    {"title": "Yaser Al-Dosari"},
  ];

  @override
  Widget build(BuildContext context) {
    final scale = Responsive.scale(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(() {
      final fontIndex = controller.fontSelected.value;
      final fontFamily = fontArabs[fontIndex]["title"];
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CommonAppBar(
               backIconColor:  Theme.of(context).textTheme.titleMedium!.color,
        titleColor: Theme.of(context).textTheme.titleMedium!.color,
          title: "Pengaturan Aplikasi",
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Preferensi",
                        style: Theme.of(context).textTheme.titleSmall
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).textTheme.titleSmall!.color!.withAlpha(10),
                                child: Icon(
                                  Icons.color_lens_outlined,
                                  color: Theme.of(context).textTheme.titleSmall!.color,
                                ),
                              ),
                              SizedBox(width: 18),
                              Text(
                                "Tema Gelap",
                                style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14)
                              ),
                            ],
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              value: controller.modeSelected.value == 0,
                              thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                                (states) {
                                  return const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  );
                                },
                              ),

                              thumbColor: const WidgetStatePropertyAll(
                                Colors.white,
                              ),

                              trackColor:
                                  WidgetStateProperty.resolveWith<Color>((
                                    states,
                                  ) {
                                    if (states.contains(WidgetState.selected)) {
                                      return AppColors.secondary;
                                    }

                                    return Colors.black.withAlpha(60);
                                  }),

                    trackOutlineColor: const WidgetStatePropertyAll(
    Colors.transparent,
  ),

                              onChanged: (bool value) {
                                controller.changeMode(value ? 0 : 1);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(16),
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
                          Text(
                            "Font Arab",
                            style:  Theme.of(context).textTheme.titleSmall
                          ),
                          Text(
                            "الله",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.titleSmall!.color,
                              fontFamily: fontFamily,
                              fontSize: Responsive.fontSize(context, phone: 25),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ...List.generate(fontArabs.length, (index) {
                        final item = fontArabs[index];
                        final isSelected =
                            controller.fontSelected.value == index;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () => controller.changeFont(index),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary.withAlpha(90)
                                    : Theme.of(context).colorScheme.primary.withAlpha(50),
                                border: isSelected
                                    ? BoxBorder.all(
                                              color: Theme.of(context).colorScheme.primary,
                                        width: 0.8,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:Theme.of(context).textTheme.labelSmall?.color!.withAlpha(10),
                                        child: Icon(
                                          Icons.text_fields_rounded,
                                          color: isSelected
                                ? Theme.of(context).textTheme.titleSmall!.color
                                : Theme.of(context).textTheme.titleSmall!.color!.withAlpha(130),
                          ),
                                      ),
                                      SizedBox(width: 18),
                                      Text(
                                        item["title"],
                                        style: TextStyle(
                                          color: isSelected
                                ? Theme.of(context).textTheme.titleSmall!.color
                                : Theme.of(context).textTheme.titleSmall!.color!.withAlpha(130),
                            fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color:isSelected
                                ? isDark ? AppColors.light : AppColors.primary
                                : AppColors.primary.withAlpha(130),
                          ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                       color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Qari Default",
                       style:  Theme.of(context).textTheme.titleSmall
                      ),
                      SizedBox(height: 10),
                      ...List.generate(qoris.length, (index) {
                        final item = qoris[index];
                        final isSelected =
                            controller.qariSelected.value == index;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () => controller.changeQari(index),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary.withAlpha(90)
                                    : Theme.of(context).colorScheme.primary.withAlpha(50),
                                border: isSelected
                                    ? BoxBorder.all(
                                              color: Theme.of(context).colorScheme.primary,
                                        width: 0.8,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Theme.of(context).textTheme.titleSmall!.color!.withAlpha(10),
                                        child: Icon(
                                          isSelected
                                              ? Iconsax.microphone_25
                                              : Iconsax.microphone_2,
                                         color: isSelected
                                ? Theme.of(context).textTheme.titleSmall!.color
                                : Theme.of(context).textTheme.titleSmall!.color!.withAlpha(130),
                          
                                        ),
                                      ),
                                      SizedBox(width: 18),
                                      Text(
                                        item["title"],
                                         style: TextStyle(
                                          color: isSelected
                                ? Theme.of(context).textTheme.titleSmall!.color
                                : Theme.of(context).textTheme.titleSmall!.color!.withAlpha(130),
                            fontWeight: FontWeight.w500,
                                        ),
                                      
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color:isSelected
                                ? isDark ? AppColors.light : AppColors.primary
                                : AppColors.primary.withAlpha(130),
                          ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(16),
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
                          Row(
                            children: [
                              Icon(
                                Iconsax.info_circle,
                                color: AppColors.secondary,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Tentang Aplikasi",
                                style : Theme.of(context).textTheme.titleSmall
                              ),
                            ],
                          ),
                          Text(
                            "Versi 2.0.0",
                            style: TextStyle(
                              color: isDark ? AppColors.secondary : AppColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        ''' Al-Barokah ID Official Mobile App

Aplikasi resmi dari Hafid Tech yang menyediakan Al-Quran digital lengkap dengan tafsir, audio murottal dari berbagai qari, doa harian, jadwal sholat, arah kiblat, dzikir, dan fitur islami lainnya.  ''',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.textPrimaryDark : HexColor.fromHex("#5A7A8A"),
                        ),
                      ),

                      SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.instagram,
                            size: 20 * scale,
                            color: isDark ? AppColors.light : AppColors.primary,
                          ),
                          SizedBox(width: 10),
                          Text.rich(
                            TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: [
                                TextSpan(
                                  text: 'Kontak : ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.light : HexColor.fromHex("#5A7A8A"),
                                  ),
                                ),
                                TextSpan(
                                  text: '@hafidtechcom',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.secondary : AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ' (Instagram)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.light : HexColor.fromHex("#5A7A8A"),
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
