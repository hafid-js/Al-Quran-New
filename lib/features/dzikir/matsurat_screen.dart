import 'package:alquran_new/core/utils/constants/app_colors.dart';
import 'package:alquran_new/features/dzikir/detail_matsurat_screen.dart';
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
          onTap: () => Get.to(DetailMatsuratScreen()),
          child: Container(
            padding: EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 16,
              top: 35,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/dzikir_sugro_background_1.png",
                ),
                fit: BoxFit.cover,
              
              ),
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dzikir Pagi Sugro",
                  style:             TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Dzikir pagi versi Sugro, ringan dan singkat untuk memulai hari.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 10),

        Container(
          padding: EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: 16,
            top: 35,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/dzikir_sugro_background_2.png",
              ),
   
              fit: BoxFit.cover,
            ),
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dzikir Petang Sugro",
                style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "Dzikir petang versi Sugro, untuk penenang hati menjelang sore.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ],
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
          onTap: () => Get.to(DetailMatsuratScreen()),
          child: Container(
            padding: EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 16,
              top: 35,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/dzikir_kubro_background_1.png",
                ),
           
                fit: BoxFit.cover,
              ),
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dzikir Pagi Kubro",
                                  style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Dzikir pagi versi Kubro, ringan dan singkat untuk memulai hari.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: 16,
            top: 35,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/dzikir_kubro_background_2.png",
              ),

              fit: BoxFit.cover,
            ),
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dzikir Petang Kubro",
                                style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "Dzikir petang versi Kubro, untuk penenang hati menjelang sore.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ],
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
                              color: Theme.of(context).textTheme.titleLarge!.color,
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
                            scale: Tween<double>(begin: 0.95, end: 1.0)
                                .animate(animation),
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

                SizedBox(height: 20),
                Text(
                  "Bacaan Surat Pilihan",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
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
                                  Text("🕌", style: TextStyle(fontSize: 18)),
                                  SizedBox(width: 10),
                                  Text(
                                    "Surah Al-Kahfi",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Bacalah Surah Al-Kahfi setiap hari jumat untuk ketenangan hati dan perlindungan dari fitnah Dajjal.",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
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
                                  Text("❄️", style: TextStyle(fontSize: 18)),
                                  SizedBox(width: 10),
                                  Text(
                                    "Surah Al-Waqiah",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Almalkan Surah Al-Waqiah setiap malam untuk memperluas rezeki dan mendapatkan keberkahan hidup.",
                    style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
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
                                  Text("🌟", style: TextStyle(fontSize: 18)),
                                  SizedBox(width: 10),
                                  Text(
                                    "Surah Al-Mulk",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Surah Al-Mulk dibaca setiap malam untuk memohon perlindungan dan syafaat di alam kubur.",
                 style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
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
                                  Text("🌿", style: TextStyle(fontSize: 18)),
                                  SizedBox(width: 10),
                                  Text(
                                    "Surah Ar-Rahman",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Surah Ar-Rahman indah dibaca untuk mengingat luasnya nikmat Allah dan menenangkan hati.",
                 style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
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
                                  Text("📖", style: TextStyle(fontSize: 18)),
                                  SizedBox(width: 10),
                                  Text(
                                    "Surah Yasin",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Surah Yasin disebut jantung Al-Quran. Bacalah untuk memohon kemudahan urusan dunia dan akhirat.",
            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
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
