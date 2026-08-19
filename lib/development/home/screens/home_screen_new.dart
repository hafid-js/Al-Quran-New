import 'package:alquran_new/binding/surah_binding.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:alquran_new/development/alquran/screens/alquran_screen_new.dart';
import 'package:alquran_new/development/murrotal/screens/detail_qari_screen.dart';
import 'package:alquran_new/development/doa/screens/doa_screen.dart';
import 'package:alquran_new/development/ibadah/ibadah_screen.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alquran_new/development/murrotal/controllers/murrotal_controller.dart';
import 'package:alquran_new/development/murrotal/screens/detail_murrotal_screen.dart';
import 'package:alquran_new/development/bookmark/screens/bookmark_screen.dart';
import 'package:alquran_new/development/kalender/screens/hijriah_screen.dart';
import 'package:alquran_new/development/kiblat/screens/kiblat_screen_new.dart';
import 'package:alquran_new/development/dzikir/screens/matsurat_screen.dart';
import 'package:alquran_new/development/tasbih/screens/tasbih_screen.dart';
import 'package:alquran_new/development/alquran/domain/entities/surah.dart';
import 'package:alquran_new/development/home/controllers/prayer_time_controller.dart';
import 'package:alquran_new/development/lokasi/screens/lokasi_screen.dart';
import 'package:alquran_new/development/pengaturan/screens/pengaturan_notifikasi_screen.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:alquran_new/binding/doa_binding.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

final List<Map<String, dynamic>> prayerTimes = [
  {"title": "Imsak", "icon": Iconsax.moon, "time": "04:40"},
  {"title": "Subuh", "icon": Iconsax.moon, "time": "04:50"},
  {"title": "Dzuhur", "icon": Iconsax.sun_1, "time": "11:48"},
  {"title": "Ashar", "icon": Icons.sunny_snowing, "time": "15:05"},
  {"title": "Maghrib", "icon": Iconsax.sun_fog, "time": "18:03"},
  {"title": "Isya", "icon": Iconsax.moon, "time": "19:10"},
];
final List<Map<String, dynamic>> menus = [
  {
    "title": "Quran",
    "icon": Iconsax.book_1,
    "page": () => const AlquranScreenNew(),
    "binding": SurahBinding(),
  },
  {
    "title": "Doa",
    "icon": Iconsax.note_1,
    "page": () => const DoaScreen(),
    "binding": DoaBinding(),
  },
  {
    "title": "Kiblat",
    "icon": Iconsax.gps,
    "page": () => const KiblatScreenNew(),
  },
  {
    "title": "Tasbih",
    "icon": Iconsax.more_2,
    "page": () => const TasbihScreen(),
  },
  {
    "title": "Ibadah",
    "icon": FlutterIslamicIcons.muslim2,
    "page": () => const IbadahScreen(),
  },

  {
    "title": "Murrotal",
    "icon": Iconsax.music_square,
    "onTap": _showMurrotalScreen,
  },
  {
    "title": "Bookmark",
    "icon": Iconsax.save_2,
    "page": () => const BookmarkScreenNew(),
  },
  {"title": "Semua", "icon": Iconsax.menu, "page": () => {}},
  {"title": "Dzikir", "icon": Iconsax.flash, "page": () => null},
  {
    "title": "Hijriah",
    "icon": Iconsax.calendar,
    "page": () => const HijriahScreen(),
  },
];

class TopNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    const double notchWidth = 340;
    const double notchDepth = 20;

    path.moveTo(0, 0);

    path.lineTo(size.width / 2 - notchWidth / 2, 0);

    path.quadraticBezierTo(
      size.width / 2,
      notchDepth,
      size.width / 2 + notchWidth / 2,
      0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _HomeScreenNewState extends State<HomeScreenNew>
    with WidgetsBindingObserver {
  late final PrayerTimeController controller;
  bool _showAllMenus = false;

  @override
  void initState() {
    super.initState();
    if (!GetInstance().isRegistered<PrayerTimeController>()) {
      Get.put(PrayerTimeController());
    }
    controller = Get.find<PrayerTimeController>();
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

  DateTime _parseDate(String tanggalLengkap) {
    try {
      return DateTime.parse(tanggalLengkap);
    } catch (_) {
      return DateTime.now();
    }
  }

  final GetStorage _storage = GetStorage();

  int _ibadahChecklistDone(dynamic list) {
    if (list is! List) return 0;
    return list.where((e) => e is Map && e['done'] == true).length;
  }

  (int, int) get _ibadahProgress {
    final now = DateTime.now();
    final key =
        'ibadah_${now.year}-${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
    final data = _storage.read(key);
    final map = data is Map ? data : null;

    final checklistDone =
        _ibadahChecklistDone(map?['sholatWajib']) +
        _ibadahChecklistDone(map?['sholatSunnah']) +
        _ibadahChecklistDone(map?['dzikir']) +
        _ibadahChecklistDone(map?['puasa']);

    int tilawahPages = 0;
    final tilawah = map?['tilawah'];
    if (tilawah is List) {
      for (final t in tilawah) {
        if (t is Map) {
          tilawahPages += int.tryParse(t['halaman'].toString()) ?? 0;
        }
      }
    }

    final sedekah = map?['sedekah'] is List
        ? (map?['sedekah'] as List).whereType<int>().length
        : 0;

    final all = 14 + tilawahPages + sedekah;
    final done = checklistDone + tilawahPages + sedekah;
    return (done, all);
  }

  List<Map<String, dynamic>> _prayerList() {
    final item = controller.todayPrayer.value;
    if (item == null) return prayerTimes;
    return [
      {"title": "Imsak", "icon": Iconsax.moon, "time": item.imsak},
      {"title": "Subuh", "icon": Iconsax.moon, "time": item.subuh},
      {"title": "Dzuhur", "icon": Iconsax.sun_1, "time": item.dzuhur},
      {"title": "Ashar", "icon": Icons.sunny_snowing, "time": item.ashar},
      {"title": "Maghrib", "icon": Iconsax.sun_fog, "time": item.maghrib},
      {"title": "Isya", "icon": Iconsax.moon, "time": item.isya},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        backgroundColor: HexColor.fromHex("#256980"),
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 60),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      HexColor.fromHex("#256980").withAlpha(210),
                      BlendMode.srcATop,
                    ),
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/image.png"),
                  ),
                  color: HexColor.fromHex("#256980"),
                ),
                child: Obx(() {
                  final item = controller.todayPrayer.value;
                  final nextTime = controller.nextPrayerTime.value;
                  final jam = nextTime != null
                      ? DateFormat('HH:mm').format(nextTime)
                      : "--:--";
                  final hijri = item != null
                      ? HijriCalendar.fromDate(_parseDate(item.tanggalLengkap))
                      : null;
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => LokasiScreen()),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(30),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.location,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    controller.currentCity.value,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Obx(() {
                            final loading = controller.isLoading.value;
                            return GestureDetector(
                              onTap: loading
                                  ? null
                                  : () => controller.detectLocation(),
                              child: loading
                                  ? const Padding(
                                      padding: EdgeInsets.all(2),
                                      child: SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Icon(Iconsax.location_add),
                            );
                          }),
                        ],
                      ),
                      SizedBox(height: 30),

                      Column(
                        children: [
                          Text(
                            hijri != null
                                ? "${hijri.longMonthName} ${hijri.hDay}, ${hijri.hYear} H"
                                : "Sedang memuat...",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            jam,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${controller.nextPrayerName.value} akan tiba dalam ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextSpan(
                                  text: controller.remainingText,
                                  style: TextStyle(
                                    color: HexColor.fromHex("#D39D52"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 50,
                        thickness: 0.5,
                        color: Colors.white60,
                      ),
                      AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: GridView.count(
                          crossAxisCount: Responsive.gridColumns(
                            context,
                            phone: 6,
                            tablet: 6,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: Responsive.value(
                            context,
                            phone: 6,
                            tablet: 16,
                          ),
                          mainAxisSpacing: Responsive.value(
                            context,
                            phone: 6,
                            tablet: 16,
                          ),
                          childAspectRatio: Responsive.value(
                            context,
                            phone: 0.7,
                            tablet: 1.0,
                          ),
                          padding: EdgeInsets.zero,
                          children: _prayerList()
                              .map(
                                (prayerTime) => _buildPrayerTimeItem(
                                  context,
                                  prayerTime,
                                  controller.nextPrayerName.value,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),

          Positioned(
            top: 310,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  ClipPath(
                    clipper: TopNotchClipper(),
                    child: Container(
                      padding: EdgeInsets.only(
                        right: 10,
                        left: 10,
                        bottom: 16,
                        top: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: GridView.count(
                          crossAxisCount: Responsive.gridColumns(
                            context,
                            phone: 4,
                            tablet: 4,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: Responsive.value(
                            context,
                            phone: 4,
                            tablet: 16,
                          ),
                          mainAxisSpacing: Responsive.value(
                            context,
                            phone: 4,
                            tablet: 16,
                          ),
                          childAspectRatio: Responsive.value(
                            context,
                            phone: 1.1,
                            tablet: 1.0,
                          ),
                          padding: EdgeInsets.zero,
                          children: menus
                              .where(
                                (menu) =>
                                    _showAllMenus ||
                                    (menu["title"] != "Dzikir" &&
                                        menu["title"] != "Hijriah"),
                              )
                              .map(
                                (menu) => _MenuItemWidget(
                                  menu: menu,
                                  onTap: menu["title"] == "Semua"
                                      ? () {
                                          setState(() {
                                            _showAllMenus = !_showAllMenus;
                                          });
                                        }
                                      : () async {
                                          if (menu["title"] == "Dzikir") {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      HexColor.fromHex(
                                                        "#F9F5EF",
                                                      ),
                                                  title: Text(
                                                    "Masih Dalam Pengembangan",
                                                    style: TextStyle(
                                                      color: HexColor.fromHex(
                                                        "#256980",
                                                      ),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    "Fitur Dzikir masih dalam tahap pengembangan. "
                                                    "Silakan coba lagi pada pembaruan berikutnya.",
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                            context,
                                                          ),
                                                      child: Text(
                                                        "Mengerti",
                                                        style: TextStyle(
                                                          color:
                                                              HexColor.fromHex(
                                                                "#256980",
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            return;
                                          }

                                          if (menu["onTap"] != null) {
                                            menu["onTap"](context);
                                            return;
                                          }

                                          final binding = menu["binding"];
                                          if (binding != null) {
                                            await Get.to(
                                              menu["page"](),
                                              binding: binding,
                                            );
                                          } else {
                                            await Get.to(menu["page"]());
                                          }

                                          if (mounted) {
                                            setState(() {});
                                          }
                                        },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Progress Hari ini",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(color: HexColor.fromHex("#256980")),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#246177"),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${_ibadahProgress.$2 == 0 ? 0 : (_ibadahProgress.$1 * 100 / _ibadahProgress.$2).round()}%",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selesaikan checklist ibadah hari ini.",
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "${_ibadahProgress.$1} dari ${_ibadahProgress.$2} Selesai",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(
                                    color: HexColor.fromHex("#256980"),
                                    fontSize: 12,
                                  ),
                            ),

                            const SizedBox(height: 6),

                            StepProgressIndicator(
                              totalSteps: max(2, _ibadahProgress.$2 * 2 + 10),
                              currentStep: _ibadahProgress.$1 > 0
                                  ? _ibadahProgress.$1 * 2 + 10
                                  : 0,
                              selectedColor: HexColor.fromHex("#256980"),
                              size: 28,
                              padding: 3,
                              unselectedColor: Colors.grey.withAlpha(120),
                              roundedEdges: const Radius.circular(5),
                            ),

                            const SizedBox(height: 12),

                            GestureDetector(
                              onTap: () async {
                                await Get.to(() => const IbadahScreen());

                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: HexColor.fromHex("#D39D52"),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Buka Daftar Checklist",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white),
                                  ),
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
          ),
        ],
      ),
    );
  }
}

Widget _buildPrayerTimeItem(
  BuildContext context,
  Map prayerTime,
  String nextPrayerName,
) {
  final isNext = prayerTime["title"] == nextPrayerName;
  return InkWell(
    onTap: () {},
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prayerTime["title"],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: isNext ? HexColor.fromHex("#D39D52") : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Icon(
          prayerTime["icon"],
          size: 20,
          color: isNext ? HexColor.fromHex("#D39D52") : Colors.white,
        ),
        SizedBox(height: 5),
        Text(
          prayerTime["time"],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: isNext ? HexColor.fromHex("#D39D52") : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class _MenuItemWidget extends StatefulWidget {
  final Map menu;
  final VoidCallback? onTap;
  const _MenuItemWidget({required this.menu, this.onTap});

  @override
  State<_MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<_MenuItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.4,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  void _onTap() {
    _controller.reverse().then((_) {
      final menu = widget.menu;

      if (widget.onTap != null) {
        widget.onTap!();
        return;
      }

      if (menu["onTap"] != null) {
        menu["onTap"](context);
        return;
      }

      if (menu["page"] != null) {
        final binding = menu["binding"];
        if (binding != null) {
          Get.to(menu["page"], binding: binding);
        } else {
          Get.to(menu["page"]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.menu["icon"],
              size: 30,
              color: HexColor.fromHex("#D39D52"),
            ),
            SizedBox(height: 5),
            Text(
              widget.menu["title"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: HexColor.fromHex("#5a7b8a"),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarouselItem {
  final Surah surah;
  final int qariIndex;
  const _CarouselItem({required this.surah, required this.qariIndex});
}

void _showMurrotalScreen(BuildContext context) {
  SurahBinding().dependencies();
  WoltModalSheet.show(
    context: context,
    pageListBuilder: (bottomSheetContext) => [
      SliverWoltModalSheetPage(
        backgroundColor: HexColor.fromHex("#F9F5EF"),
        surfaceTintColor: HexColor.fromHex("#F9F5EF"),
        hasTopBarLayer: false,
        mainContentSliversBuilder: (context) => const [
          SliverToBoxAdapter(child: MurrotalContent()),
        ],
      ),
    ],
  );
}

class MurrotalContent extends StatefulWidget {
  const MurrotalContent({super.key});

  @override
  State<MurrotalContent> createState() => _MurrotalContentState();
}

class _MurrotalContentState extends State<MurrotalContent> {
  final c = Get.find<MurrotalController>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: HexColor.fromHex("#256980"),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20),
          Obx(() {
            final surahList = c.surahList;
            if (surahList.isEmpty) {
              return SizedBox(
                height: 210,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final random = Random();
            final displayList = List.generate(
              MurrotalController.qariData.length,
              (qariIndex) {
                final qariKey = (qariIndex + 1).toString().padLeft(2, '0');
                final available = surahList
                    .where((s) => s.audioFull.containsKey(qariKey))
                    .toList();
                if (available.isEmpty) return null;
                final surah = available[random.nextInt(available.length)];
                return _CarouselItem(surah: surah, qariIndex: qariIndex);
              },
            ).whereType<_CarouselItem>().toList();
            return SizedBox(
              height: 210,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          HexColor.fromHex("#F9F5EF"),
                          HexColor.fromHex("#256980"),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -50,
                          bottom: 30,
                          left: 0,
                          right: -250,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: HexColor.fromHex("#256980"),
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                        CarouselSlider(
                          items: displayList
                              .map(
                                (item) => GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => DetailMurrotalScreen(
                                        qariIndex: item.qariIndex,
                                        surahNomor: item.surah.nomor,
                                        surahNama: item.surah.namaLatin,
                                        surahArti: item.surah.arti,
                                        qariNama: MurrotalController
                                            .qariData[item.qariIndex]["title"]!,
                                        qariImage: MurrotalController
                                            .qariData[item.qariIndex]["image"]!,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 20,
                                          bottom: 60,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${c.getSurahNumberLabel(item.surah.nomor)}-${item.surah.namaLatin}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                MurrotalController.qariData[item
                                                        .qariIndex]["title"] ??
                                                    "",
                                                style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Icon(
                                                Iconsax.play_circle5,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 12,
                                          bottom: 0,
                                          left: 0,
                                          right: -250,
                                          child: ColorFiltered(
                                            colorFilter:
                                                const ColorFilter.matrix([
                                                  0.26,
                                                  0.72,
                                                  0.02,
                                                  0,
                                                  0,
                                                  0.26,
                                                  0.72,
                                                  0.02,
                                                  0,
                                                  0,
                                                  0.26,
                                                  0.72,
                                                  0.02,
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  1,
                                                  0,
                                                ]),
                                            child: Image.asset(
                                              MurrotalController.qariData[item
                                                      .qariIndex]["banner"] ??
                                                  "",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 185,
                            viewportFraction: 1.0,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SmoothPageIndicator(
                    count: displayList.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                      expansionFactor: 4,
                      activeDotColor: HexColor.fromHex("#256980"),
                      dotColor: Colors.white,
                    ),
                    controller: PageController(initialPage: _currentIndex),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 10),
          Text(
            "Qori Terfavorit",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: HexColor.fromHex("#256980"),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: MurrotalController.qariData.length,
              itemBuilder: (context, index) {
                final qari = MurrotalController.qariData[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => DetailQariScreen(qariIndex: index));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Stack(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                qari["image"]!,
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 80,
                        child: Text(
                          qari["title"]!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: HexColor.fromHex("#1E4355"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
