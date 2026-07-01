import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/dzikir/detail_matsurat_screen.dart';
import 'package:alquran_new/features/dzikir/detail_perasaan_screen.dart';
import 'package:alquran_new/features/dzikir/widgets/perasaan_card.dart';
import 'package:alquran_new/features/dzikir/widgets/surat_pilihan_list_tile.dart';
import 'package:alquran_new/features/tasbih/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatsuratScreen extends StatefulWidget {
  const MatsuratScreen({super.key});

  @override
  State<MatsuratScreen> createState() => _MatsuratScreenState();
}

class _MatsuratScreenState extends State<MatsuratScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildSugroColumn() {
    return Column(
      key: const ValueKey('sugro'),
      children: [
        GestureDetector(
          onTap: () => Get.to(DetailMatsuratScreen(type: 'pagi_sugro')),
          child: Container(
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 35),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/dzikir_sugro_background_1.png",
                ),
                fit: BoxFit.cover,
              ),
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dzikir Pagi Sugro",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Dzikir pagi versi Sugro, ringan dan singkat untuk memulai hari.",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 10),

        GestureDetector(
          onTap: () => Get.to(DetailMatsuratScreen(type: 'petang_sugro')),
          child: Container(
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 35),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/dzikir_sugro_background_2.png",
                ),

                fit: BoxFit.cover,
              ),
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dzikir Petang Sugro",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Dzikir petang versi Sugro, untuk penenang hati menjelang sore.",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKubroColumn() {
    return Column(
      key: const ValueKey('kubro'),
      children: [
        GestureDetector(
          onTap: () => Get.to(DetailMatsuratScreen(type: 'pagi_kubro')),
          child: Container(
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 35),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/dzikir_kubro_background_1.png",
                ),

                fit: BoxFit.cover,
              ),
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dzikir Pagi Kubro",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Dzikir pagi versi Kubro, ringan dan singkat untuk memulai hari.",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 10),
        GestureDetector(
          onTap: () => Get.to(DetailMatsuratScreen(type: 'petang_kubro')),
          child: Container(
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 35),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/dzikir_kubro_background_2.png",
                ),

                fit: BoxFit.cover,
              ),
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dzikir Petang Kubro",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Dzikir petang versi Kubro, untuk penenang hati menjelang sore.",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_circle_left_rounded),
          color: Theme.of(context).iconTheme.color,
        ),

        titleSpacing: 5,

        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Al-Barokah",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                Text(
                  "Dzikir pagi & petang harian",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).textTheme.titleLarge!.color,
                            borderRadius: BorderRadius.circular(18),
                          ),

                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),

                          labelColor: isDark ? Colors.black : Colors.white,
                          labelStyle: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),

                          tabs: const [
                            TabItem(title: "Sugro"),
                            TabItem(title: "Kubro"),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),

              SizedBox(
                height: 230,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.95,
                            end: 1.0,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _tabController.index == 0
                        ? _buildSugroColumn()
                        : _buildKubroColumn(),
                  ),
                ),
              ),
              SizedBox(height: 10),

              Column(
                children: [
                  SizedBox(
                    height: 160,
                    child: GridView.count(
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 130 / 220,
                      children: [
                        PerasaanCard(
                          title: "Marah",
                          color: "#F4B8C1",
                          onTap: () =>
                              Get.to(DetailPerasaanScreen(type: "marah",)),
                        ),
                        PerasaanCard(
                          title: "Cemas/Gelisah",
                          color: "#B8D4F4",
                         onTap: () =>
                              Get.to(DetailPerasaanScreen(type: "cemas_gelisah",)),
                        ),
                          PerasaanCard(
                          title: "Bosan",
                          color: "#D4D4D4",
                         onTap: () =>
                              Get.to(DetailPerasaanScreen(type: "bosan",)),
                        ),
                        PerasaanCard(
                          title: "Percaya Diri",
                          color: "#B8E8D4",
                         onTap: () =>
                              Get.to(DetailPerasaanScreen(type: "percaya_diri",)),
                        ),
                        PerasaanCard(
                          title: "Bingung",
                          color: "#E8DDB8",
                         onTap: () =>
                              Get.to(DetailPerasaanScreen(type: "bingung",)),
                        ),
                        PerasaanCard(
                          title: "Puas/Tenang",
                          color: "#F4C8E8",
                       onTap: () =>
                              Get.to(DetailPerasaanScreen(type: "puas_tenang",)),
                        ),
                        PerasaanCard(
                          title: "Depresi/Sedih Mendalam",
                          color: "#C8B4D4",
                         onTap: () =>
                              Get.to(DetailPerasaanScreen(type: "depresi_sedih_mendalam",)),
                        ),
                        PerasaanCard(
                          title: "Ragu-Ragu",
                          color: "#D4B8E8",
                          onTap: () =>
                              Get.to(DetailPerasaanScreen(type: "ragu_ragu",)),
                        ),
                        PerasaanCard(
                          title: "Bersyukur",
                          color: "#B8E8C8",
                          onTap: () =>
                              Get.to(DetailPerasaanScreen(type: "bersyukur",)),
                        ),
                        PerasaanCard(
                          title: "Serakah/Tamak",
                          color: "#E8D4B8",
                         onTap: () =>
                              Get.to(DetailPerasaanScreen(type: "serakah_tamak",)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Text(
                "Bacaan Surat Pilihan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  SuratPilihanListTile(
                    emoji: "🕌",
                    title: "Surah Al-Kahfi",
                    description:
                        "Bacalah Surah Al-Kahfi setiap hari jumat untuk ketenangan hati dan perlindungan dari fitnah Dajjal.",
                    surahNumber: 18,
                  ),
                  SizedBox(height: 10),
                  SuratPilihanListTile(
                    emoji: "❄️",
                    title: "Surah Al-Waqiah",
                    description:
                        "Almalkan Surah Al-Waqiah setiap malam untuk memperluas rezeki dan mendapatkan keberkahan hidup.",
                    surahNumber: 56,
                  ),
                  SizedBox(height: 10),
                  SuratPilihanListTile(
                    emoji: "🌟",
                    title: "Surah Al-Mulk",
                    description:
                        "Surah Al-Mulk dibaca setiap malam untuk memohon perlindungan dan syafaat di alam kubur.",
                    surahNumber: 67,
                  ),
                  SizedBox(height: 10),
                  SuratPilihanListTile(
                    emoji: "🌿",
                    title: "Surah Ar-Rahman",
                    description:
                        "Surah Ar-Rahman indah dibaca untuk mengingat luasnya nikmat Allah dan menenangkan hati.",
                    surahNumber: 55,
                  ),
                  SizedBox(height: 10),
                  SuratPilihanListTile(
                    emoji: "📖",
                    title: "Surah Yasin",
                    description:
                        "Surah Yasin disebut jantung Al-Quran. Bacalah untuk memohon kemudahan urusan dunia dan akhirat.",
                    surahNumber: 36,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
