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
import 'package:flutter/services.dart';

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

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
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
      "binding": PemutarAudioBinding(),
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
  ];

  bool showAllMenus = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.resumeCountdown();
      controller.fetchPrayerTimes();
    } else if (state == AppLifecycleState.paused) {
      controller.pauseCountdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(backgroundColor: Colors.transparent, toolbarHeight: 0),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Loading();
          }
          if (controller.errorMessage.value != null) {
            return Scaffold(body: Center(
              child: Text("Error: ${controller.errorMessage.value}"),
            ));
          }
          if (controller.todayPrayer.value == null) {
            return const Scaffold(body: Center(child: Text("Data kosong")));
          }
          return _buildContent(context);
        }),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 20),
        child: Column(
          children: [
            _buildCityRow(context),
            const SizedBox(height: 20),
            _buildPrayerCard(context),
            const SizedBox(height: 20),
            _buildJadwalHeader(context),
            const SizedBox(height: 20),
            _buildPrayerGrid(context),
            const SizedBox(height: 20),
            _buildMenuSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCityRow(BuildContext context) {
    return Obx(() {
      final city = controller.currentCity.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 35, width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Text(city, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => Get.to(() => LokasiScreen()),
                child: AnimatedRotation(
                  turns: 1.75,
                  duration: Duration(milliseconds: 300),
                  child: Icon(Icons.arrow_circle_left_rounded,
                    color: Theme.of(context).textTheme.labelLarge?.color,
                    size: 22),
                ),
              ),
            ],
          ),
          Container(
            height: 40, width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
              boxShadow: context.shadow.small,
            ),
            child: Icon(Icons.location_on, size: 25, color: Theme.of(context).colorScheme.primary),
          ),
        ],
      );
    });
  }

  Widget _buildPrayerCard(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withAlpha(160),
            Theme.of(context).colorScheme.primary.withAlpha(190),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Assalamu'alaikum,",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _buildDateText(context),
            const SizedBox(height: 15),
            _buildCountdown(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDateText(BuildContext context) {
    return Center(
      child: Obx(() {
        final item = controller.todayPrayer.value;
        if (item == null) return const SizedBox.shrink();
        late final DateTime formattingDate;
        try {
          formattingDate = DateTime.parse(item.tanggalLengkap);
        } catch (_) {
          formattingDate = DateTime.now();
        }
        final dateNow = DateFormat('dd MMM yyyy', 'id').format(formattingDate);
        final formattingHijri = HijriCalendar.fromDate(formattingDate).toFormat("dd MMMM yyyy H");
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(100),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text("$dateNow - $formattingHijri",
            style: const TextStyle(color: Colors.white, fontSize: 14)),
        );
      }),
    );
  }

  Widget _buildCountdown(BuildContext context) {
    return Obx(() {
      final date = controller.nextPrayerTime.value;
      if (date == null) return const SizedBox();
      final jam = DateFormat('HH:mm').format(date);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.nextPrayerName.value,
                style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              Text(jam,
                style: TextStyle(color: HexColor.fromHex("#a5d9d4"), fontSize: 18)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withAlpha(100),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(controller.remainingText,
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const Text("Tersisa", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildJadwalHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 35, width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Icon(Icons.access_time_filled_outlined, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Text("Jadwal Sholat", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        GestureDetector(
          onTap: () => Get.to(() => PengaturanNotifikasiScreen()),
          child: Container(
            height: 35, width: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildPrayerGrid(BuildContext context) {
    return Obx(() {
      final item = controller.todayPrayer.value;
      final nextPrayer = controller.nextPrayerName.value;
      if (item == null) return const SizedBox.shrink();

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 2,
              mainAxisSpacing: 7,
              padding: const EdgeInsets.only(right: 18, left: 18, top: 5, bottom: 5),
              childAspectRatio: 1,
              children: [
                PrayerItemWidget(nextPrayer: nextPrayer, label: "Imsak", time: item.imsak, icon: Icons.bedtime_rounded),
                PrayerItemWidget(nextPrayer: nextPrayer, label: "Subuh", time: item.subuh, icon: Icons.bedtime_rounded),
                PrayerItemWidget(nextPrayer: nextPrayer, label: "Dzuhur", time: item.dzuhur, icon: Icons.sunny),
                PrayerItemWidget(nextPrayer: nextPrayer, label: "Ashar", time: item.ashar, icon: Icons.sunny_snowing),
                PrayerItemWidget(nextPrayer: nextPrayer, label: "Maghrib", time: item.maghrib, icon: Icons.bedtime_rounded),
                PrayerItemWidget(nextPrayer: nextPrayer, label: "Isya", time: item.isya, icon: Icons.bedtime_rounded),
              ],
            ),
            Positioned(
              top: 0, bottom: 0, left: 0, right: 0,
              child: Center(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.grey.withAlpha(15),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMenuSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 35, width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Icon(Icons.grid_view_rounded, color: Theme.of(context).colorScheme.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Text("Menu", style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => setState(() => showAllMenus = !showAllMenus),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface.withAlpha(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(showAllMenus ? "Sembunyikan" : "Lihat Semua",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(width: 5),
                    AnimatedRotation(
                      turns: showAllMenus ? 0.5 : 0,
                      duration: Duration(milliseconds: 250),
                      child: Icon(Icons.arrow_circle_down_rounded, size: 20,
                        color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
            padding: EdgeInsets.zero,
            children: menus.map((menu) => _buildMenuItem(context, menu)).toList(),
          ),
        ),
        const SizedBox(height: 12),
        if (showAllMenus)
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
              padding: EdgeInsets.zero,
              children: nextMenus.map((menu) => _buildMenuItem(context, menu)).toList(),
            ),
          ),
      ],
    );
  }

}

Widget _buildMenuItem(BuildContext context, Map menu) {
  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: () {
      if (menu["page"] != null) {
        final binding = menu["binding"];

        if (binding != null) {
          Get.to(menu["page"], binding: binding);
        } else {
          Get.to(menu["page"]);
        }
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Icon(
              menu["icon"],
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              menu["title"],
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
}
