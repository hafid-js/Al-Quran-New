import 'package:alquran_new/binding/surah_binding.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:alquran_new/development/alquran_screen_new.dart';
import 'package:alquran_new/development/doa_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:alquran_new/binding/doa_binding.dart';

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
  {"title": "Doa", "icon": Iconsax.note_1, "page": () => const DoaScreen(),       "binding": DoaBinding(),},
  {"title": "Kiblat", "icon": Iconsax.gps, "page": () => const Placeholder()},
  {
    "title": "Tasbih",
    "icon": Iconsax.more_2,
    "page": () => const Placeholder(),
  },
  {
    "title": "Hijriah",
    "icon": Iconsax.calendar,
    "page": () => const Placeholder(),
  },
  {
    "title": "Murrotal",
    "icon": Iconsax.music_square,
    "page": () => const Placeholder(),
  },
  {
    "title": "Bookmark",
    "icon": Iconsax.save_2,
    "page": () => const Placeholder(),
  },
  {"title": "Dzikir", "icon": Iconsax.flash, "page": () => const Placeholder()},
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

class _HomeScreenNewState extends State<HomeScreenNew> {
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
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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
                                "Jakarta, Indonesia",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Icon(Iconsax.search_normal_1),
                            SizedBox(width: 10),
                            Icon(Iconsax.notification),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    Column(
                      children: [
                        Text(
                          "Jumada Al Akhira 15, 1446 AH",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "14:54",
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
                                text: "Maghrib akan tiba dalam ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: "27 Minutes",
                                style: TextStyle(
                                  color: HexColor.fromHex("#D39D52"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 50, thickness: 0.5, color: Colors.white60),
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
                        children: prayerTimes
                            .map(
                              (prayerTime) =>
                                  _buildPrayerTimeItem(context, prayerTime),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            top: 310,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
                              .map((menu) => _buildMenuItem(context, menu))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 13),
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
                                "35%",
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
                            SizedBox(height: 10),
                            Text(
                              "8 dari 24 Selesai",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(
                                    color: HexColor.fromHex("#256980"),
                                    fontSize: 12,
                                  ),
                            ),
                            SizedBox(height: 6),
                            StepProgressIndicator(
                              totalSteps: 38,
                              currentStep: 10,
                              selectedColor: HexColor.fromHex("#256980"),
                              size: 28,
                              padding: 3,
                              unselectedColor: Colors.grey,
                              roundedEdges: const Radius.circular(5),
                            ),
                            SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#D39D52"),
                                borderRadius: BorderRadius.circular(10),
                              ),

                              child: Center(
                                child: Text(
                                  "Buka Daftar Checklist",
                                  style: Theme.of(context).textTheme.titleSmall,
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

Widget _buildPrayerTimeItem(BuildContext context, Map prayerTime) {
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
            color: prayerTime["title"] == "Subuh"
                ? HexColor.fromHex("#D39D52")
                : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Icon(
          prayerTime["icon"],
          size: 20,
          color: prayerTime["title"] == "Subuh"
              ? HexColor.fromHex("#D39D52")
              : Colors.white,
        ),
        SizedBox(height: 5),
        Text(
          prayerTime["time"],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: prayerTime["title"] == "Subuh"
                ? HexColor.fromHex("#D39D52")
                : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildMenuItem(BuildContext context, Map menu) {
  return GestureDetector(
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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(menu["icon"], size: 30, color: HexColor.fromHex("#D39D52")),
        SizedBox(height: 5),
        Text(
          menu["title"],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: HexColor.fromHex("#5a7b8a"),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
