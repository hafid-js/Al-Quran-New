import 'package:alquran_new/binding/doa_binding.dart';
import 'package:alquran_new/binding/pemutar_audio_binding.dart';
import 'package:alquran_new/binding/surah_binding.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/ui/loading.dart';
import 'package:alquran_new/core/utils/constants/shadow_extension.dart';
import 'package:alquran_new/features/alquran/screens/alquran_screen.dart';
import 'package:alquran_new/features/bookmark/screens/bookmark.dart';
import 'package:alquran_new/features/doa/screens/doa_screen.dart';
import 'package:alquran_new/features/dzikir/screens/dzikir_screen.dart';
import 'package:alquran_new/features/home/controllers/prayer_time_controller.dart';
import 'package:alquran_new/features/home/repository/prayer_time_repository.dart';
import 'package:alquran_new/features/home/widgets/prayer_item.dart';
import 'package:alquran_new/features/kalender/screens/kalender_screen.dart';
import 'package:alquran_new/features/kiblat/screens/kiblat_screen.dart';
import 'package:alquran_new/features/lokasi/lokasi_screen.dart';
import 'package:alquran_new/features/pemutar_audio/screens/pemutar_audio_screen.dart';
import 'package:alquran_new/features/pengaturan/screens/pengaturan_aplikasi_screen.dart';
import 'package:alquran_new/features/pengaturan/screens/pengaturan_notifikasi_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class PrayerItem {
  final String label;
  final String time;
  final IconData icon;
  final bool highlight;

  PrayerItem({
    required this.label,
    required this.time,
    required this.icon,
    this.highlight = false,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(
    PrayerTimeController(repo: PrayerTimeRepository()),
  );

  final List<Map<String, dynamic>> menus = [
    {
      "title": "Quran",
      "icon": Icons.menu_book_rounded,
      "page": () => const AlQuranScreen(),
      "binding": SurahBinding(),
    },
    {
      "title": "Doa",
      "icon": Icons.feed_outlined,
      "page": () => DoaScreen(),
      "binding": DoaBinding(),
    },
    {
      "title": "Kiblat",
      "icon": Icons.my_location_rounded,
      "page": () => const KiblatScreen(),
    },
    {
      "title": "Dzikir",
      "icon": Icons.touch_app_rounded,
      "page": () => const DzikirScreen(),
    },
    {
      "title": "Kalender Islam",
      "icon": Icons.calendar_month_rounded,
      "page": () => const KalenderScreen(),
    },
    {
      "title": "Pemutar Audio",
      "icon": Icons.headset_rounded,
      "page": () => const PemutarAudioScreen(),
      "binding": PemutarAudioBinding()
    },
  ];

  final List<Map<String, dynamic>> nextMenus = [
    {
      "title": "Pengaturan",
      "icon": Icons.settings,
      "page": () => const PengaturanAplikasiScreen(),
    },
    {
      "title": "Bookmark",
      "icon": Icons.bookmarks_rounded,
      "page": () => const BookmarkScreen(),
    },
    // {"title": "Tasbih", "icon": Icons.touch_app_rounded, "page": null},
  ];

  bool showAllMenus = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.todayPrayer.value;
      final err = controller.errorMessage.value;

      if (controller.isLoading.value) {
        return Loading();
      }

      if (err != null) {
        return Scaffold(body: Center(child: Text("Error: $err")));
      }

      if (item == null) {
        return const Scaffold(body: Center(child: Text("Data kosong")));
      }

      final visibleMenus = showAllMenus ? menus : menus.take(6).toList();

      late final DateTime formattingDate;

      try {
        formattingDate = DateTime.parse(item.tanggalLengkap);
      } catch (_) {
        formattingDate = DateTime.now();
      }

      String dateNow = DateFormat('dd MMM yyyy', 'id').format(formattingDate);

      String formattingHijri = HijriCalendar.fromDate(
        formattingDate,
      ).toFormat("dd MMMM yyyy H");



final city = controller.currentCity.value;

      return Obx(() {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          appBar: AppBar(backgroundColor: Colors.transparent, toolbarHeight: 0),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 20),

              child: Column(
                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.surface,
                            ),

                            child: Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Text(
                            city,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                                     const SizedBox(width: 6),

                          GestureDetector(
                            onTap: () => Get.to(() => LokasiScreen()),
                            child: AnimatedRotation(
                                                    turns: 1.75,
                                                    duration: Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    child: Icon(
                                                      Icons
                                                          .arrow_circle_left_rounded,
                                                      color: Theme.of(context).textTheme.labelLarge?.color,
                                                      size: 22,
                                                    ),
                                                  ),
                          )
                        ],
                      ),

                      Container(
                        height: 40,
                        width: 40,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).cardColor,
                          boxShadow: context.shadow.small,
                        ),

                        child: Icon(
                          Icons.location_on,
                          size: 25,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          HexColor.fromHex("#228276"),
                          HexColor.fromHex("#27a399"),
                        ],
                      ),

                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            "Assalamu'alaikum,",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#45a399"),
                                borderRadius: BorderRadius.circular(20),
                              ),

                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),

                              child: Text(
                                "$dateNow - $formattingHijri",

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Obx(() {
                            final date = controller.nextPrayerTime.value;
                            final remaining = controller.remaining.value;

                            if (date == null) {
                              return const SizedBox();
                            }

                            final jam = DateFormat('HH:mm').format(date);

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.nextPrayerName.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      jam,
                                      style: TextStyle(
                                        color: HexColor.fromHex("#a5d9d4"),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: HexColor.fromHex("#249085"),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${remaining.inHours.toString().padLeft(2, '0')}:"
                                          "${(remaining.inMinutes % 60).toString().padLeft(2, '0')}:"
                                          "${(remaining.inSeconds % 60).toString().padLeft(2, '0')}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          "Tersisa",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: Icon(
                              Icons.access_time_filled_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12),

                          Text(
                            "Jadwal Sholat",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => PengaturanNotifikasiScreen()),
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 7,
                      padding: EdgeInsets.only(right: 18, left: 18, top: 5),
                      childAspectRatio: 1,

                      children: [
                        PrayerItemWidget(
                          nextPrayer: controller.nextPrayerName.toString(),
                          label: "Imsak",
                          time: item.imsak,
                          icon: Icons.bedtime_rounded,
                        ),
                        PrayerItemWidget(
                          nextPrayer: controller.nextPrayerName.toString(),
                          label: "Subuh",
                          time: item.subuh,
                          icon: Icons.bedtime_rounded,
                        ),
                        PrayerItemWidget(
                          nextPrayer: controller.nextPrayerName.toString(),
                          label: "Dzuhur",
                          time: item.dzuhur,
                          icon: Icons.sunny,
                        ),
                        PrayerItemWidget(
                          nextPrayer: controller.nextPrayerName.toString(),
                          label: "Ashar",
                          time: item.ashar,
                          icon: Icons.sunny_snowing,
                        ),
                        PrayerItemWidget(
                          nextPrayer: controller.nextPrayerName.toString(),
                          label: "Maghrib",
                          time: item.maghrib,
                          icon: Icons.bedtime_rounded,
                        ),
                        PrayerItemWidget(
                          nextPrayer: controller.nextPrayerName.toString(),
                          label: "Isya",
                          time: item.isya,
                          icon: Icons.bedtime_rounded,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                child: Icon(
                                  Icons.grid_view_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                              ),

                              SizedBox(width: 12),

                              Text(
                                "Menu",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),

                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              setState(() {
                                showAllMenus = !showAllMenus;
                              });
                            },

                            child: Container(
                             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).colorScheme.surface.withAlpha(20),
                              ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    showAllMenus
                                        ? "Sembunyikan"
                                        : "Lihat Semua",

                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),

                                  SizedBox(width: 5),

                                  AnimatedRotation(
                                    turns: showAllMenus ? 0.5 : 0,
                                    duration: Duration(milliseconds: 250),

                                    child: Icon(
                                      Icons.arrow_circle_down_rounded,
                                      size: 20,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,

                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,

                          children: visibleMenus.map((nextMenu) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(16),

                              onTap: () {
                                if (nextMenu["page"] != null) {
                                  Get.to(
                                    nextMenu["page"],
                                    binding: nextMenu["binding"],
                                  );
                                }
                              },

                              child: Container(
                                width: 100,
                                height: 108,
                                padding: EdgeInsets.symmetric(vertical: 12),

                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                      ),

                                      child: Icon(
                                        nextMenu["icon"],
                                        size: 30,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),

                                      child: Text(
                                        nextMenu["title"],
                                        textAlign: TextAlign.center,

                                        style: TextStyle(
                                          fontSize: 12,
                                          color: HexColor.fromHex("#5a7b8a"),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: 12),

                      showAllMenus
                          ? AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,

                              child: Row(
                                children: nextMenus.map((menu) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),

                                      onTap: () {
                                        if (menu["page"] != null) {
                                          Get.to(menu["page"]);
                                        }
                                      },

                                      child: Container(
                                    width: 100,
                                height: 108,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),

                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),

                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,

                                          children: [
                                            Container(
                                              height: 55,
                                              width: 55,

                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.surface,
                                              ),

                                              child: Icon(
                                                menu["icon"],
                                                size: 30,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                            ),

                                            SizedBox(height: 10),

                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 6,
                                              ),

                                              child: Text(
                                                menu["title"],
                                                textAlign: TextAlign.center,

                                                style: TextStyle(
                                           fontSize: 12,
                                                  color: HexColor.fromHex(
                                                    "#5a7b8a",
                                                  ),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
