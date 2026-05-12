import 'package:alquran_new/features/alquran/screens/alquran_screen.dart';
import 'package:alquran_new/features/home/widgets/prayer_item.dart';
import 'package:alquran_new/features/doa/screens/doa_screen.dart';
import 'package:alquran_new/features/dzikir/screens/dzikir_screen.dart';
import 'package:alquran_new/features/home/controllers/prayer_time_controller.dart';
import 'package:alquran_new/features/kalender/screens/kalender_screen.dart';
import 'package:alquran_new/features/pemutar_audio/screens/pemutar_audio_screen.dart';
import 'package:alquran_new/features/kiblat/screens/kiblat_screen.dart';
import 'package:alquran_new/features/pengaturan/screens/pengaturan_aplikasi_screen.dart';
import 'package:alquran_new/features/pengaturan/screens/pengaturan_notifikasi_screen.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
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
  final List<Map<String, dynamic>> menus = [
    {
      "title": "Quran",
      "icon": Icons.menu_book_rounded,
      "page": AlQuranScreen(),
    },
    {"title": "Doa", "icon": Icons.feed_outlined, "page": () => DoaScreen()},
    {"title": "Kiblat", "icon": Icons.my_location_rounded, "page": () => const KiblatScreen()},
    {
      "title": "Dzikir",
      "icon": Icons.repeat_rounded,
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
    },
  ];
  final List<Map<String, dynamic>> nextMenus = [

    {"title": "Pengaturan", "icon": Icons.settings, "page" : () => const PengaturanAplikasiScreen()},
    {"title": "Kajian", "icon": Icons.mic_rounded, "page": null},
    {"title": "Tasbih", "icon": Icons.touch_app_rounded, "page": null},
  ];

  bool showAllMenus = false;

  @override
  Widget build(BuildContext context) {
    final visibleMenus = showAllMenus ? menus : menus.take(6).toList();
    final controller = Get.put(
      PrayerTimeController(),
    );
    return Obx(() {
      if (controller.isLoading.value || controller.todayPrayer.value == null) {
        return SizedBox(
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.errorMessage.value != null) {
        return SizedBox(
          child: Center(child: Text("Error: ${controller.errorMessage.value}")),
        );
      }

      final item = controller.todayPrayer.value!;
      // final province = "Jawa Tengah";
      final city = "Kab. Purworejo";

      DateTime formattingDate = DateTime.parse(item.tanggalLengkap);
      String dateNow = DateFormat('dd MMM yyy', 'id').format(formattingDate);
      String formattingHijri = HijriCalendar.fromDate(
        formattingDate,
      ).toFormat("dd MMMM yyyy H");

      final date = controller.nextPrayerTime.value;
      final jam = DateFormat('HH:mm').format(date!);

      return Scaffold(
        backgroundColor: HexColor.fromHex("#132e3a").withAlpha(120),

        appBar: AppBar(backgroundColor: Colors.transparent, toolbarHeight: 0),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 20),
            child: Column(
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
                            color: HexColor.fromHex("#132e3a"),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: HexColor.fromHex("#2dc8b9"),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          city,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: HexColor.fromHex("#132e3a"),
                      ),
                      child: Icon(
                        Icons.location_on,
                        size: 30,
                        color: HexColor.fromHex("#2dc8b9"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                  child: Stack(
                    children: [
                      Positioned(
                        top: -30,
                        right: -25,
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: HexColor.fromHex("#37b0a5"),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: -30,
                        left: -30,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: HexColor.fromHex("#259b8e"),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Assalamu'alaikum,",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20),

                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HexColor.fromHex("#45a399"),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Text(
                                  "$dateNow - $formattingHijri",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.nextPrayerName.value,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      jam,
                                      style: TextStyle(
                                        color: HexColor.fromHex("#a5d9d4"),
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 80,
                                  width: 150,
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
                                          "${controller.remaining.value.inHours.toString().padLeft(2, '0')}:"
                                          "${controller.remaining.value.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
                                          "${controller.remaining.value.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Tersisa",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: HexColor.fromHex("#132e3a"),
                          ),
                          child: Icon(
                            Icons.access_time_filled_outlined,
                            color: HexColor.fromHex("#2dc8b9"),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Jadwal Sholat",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => PengaturanNotifikasiScreen()),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: HexColor.fromHex("#132e3a"),
                        ),
                        child: Icon(
                          Icons.notifications,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Container(
                  height: 257,
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#132e3a"),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 7,
                    padding: EdgeInsets.only(right: 15, left: 15, top: 10),
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

                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: HexColor.fromHex("#132e3a"),
                              ),
                              child: Icon(
                                Icons.grid_view_rounded,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                            ),

                            SizedBox(width: 12),

                            Text(
                              "Menu",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
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
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: HexColor.fromHex("#132e3a"),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  showAllMenus ? "Sembunyikan" : "Lihat Semua",

                                  style: TextStyle(
                                    color: HexColor.fromHex("#2f9993"),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(width: 5),

                                AnimatedRotation(
                                  turns: showAllMenus ? 0.5 : 0,
                                  duration: Duration(milliseconds: 250),

                                  child: Icon(
                                    Icons.arrow_circle_down_rounded,
                                    size: 20,
                                    color: HexColor.fromHex("#2dc8b9"),
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

                            onTap: ()  {
                              if (nextMenu["page"] != null) {
                                Get.to(nextMenu["page"]);
                              }
                            },

                            child: Container(
                              width: 115,
                              height: 120,
                              padding: EdgeInsets.symmetric(vertical: 12),

                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#132e3a"),
                                borderRadius: BorderRadius.circular(16),
                              ),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Container(
                                    height: 55,
                                    width: 55,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: HexColor.fromHex("#17404a"),
                                    ),

                                    child: Icon(
                                      nextMenu["icon"],
                                      size: 30,
                                      color: HexColor.fromHex("#2dc8b9"),
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
                                        fontSize: 13,
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

                    showAllMenus ? AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,

                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,

                        children: nextMenus.map((menu) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(16),

                            onTap: () {
                              if (menu["page"] != null) {
                                Get.to(menu["page"]);
                              }
                            },

                            child: Container(
                              width: 115,
                              height: 120,
                              padding: EdgeInsets.symmetric(vertical: 12),

                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#132e3a"),
                                borderRadius: BorderRadius.circular(16),
                              ),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Container(
                                    height: 55,
                                    width: 55,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: HexColor.fromHex("#17404a"),
                                    ),

                                    child: Icon(
                                      menu["icon"],
                                      size: 30,
                                      color: HexColor.fromHex("#2dc8b9"),
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
                                        fontSize: 13,
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
                    ) : SizedBox.shrink()

                    
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
