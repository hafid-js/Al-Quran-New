import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/alquran/data/hizb_list_data_mock.dart';
import 'package:alquran_new/development/alquran/screens/detail_hizb_screen.dart';
import 'package:alquran_new/development/alquran/screens/detail_juz_screen.dart';
import 'package:alquran_new/development/alquran/screens/detail_surah_screen.dart';
import 'package:alquran_new/development/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/development/alquran/domain/entities/surah.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
import 'package:alquran_new/development/shared/widgets/common_empty_widget.dart';
import 'package:alquran_new/development/shared/widgets/octagram_badge.dart';
import 'package:alquran_new/development/shared/widgets/search_bar.dart';
import 'package:alquran_new/development/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HizbData {
  final int number;
  final int startPage;
  final String startSurah;
  final int startAyah;
  final String endSurah;
  final int endAyah;

  const HizbData({
    required this.number,
    required this.startPage,
    required this.startSurah,
    required this.startAyah,
    required this.endSurah,
    required this.endAyah,
  });
}

class JuzData {
  final int number;
  final int startPage;
  final String startSurah;
  final int startAyah;
  final String endSurah;
  final int endAyah;

  const JuzData({
    required this.number,
    required this.startPage,
    required this.startSurah,
    required this.startAyah,
    required this.endSurah,
    required this.endAyah,
  });
}

class AlquranScreenNew extends StatefulWidget {
  const AlquranScreenNew({super.key});

  @override
  State<AlquranScreenNew> createState() => _AlquranScreenNewState();
}

class _AlquranScreenNewState extends State<AlquranScreenNew>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final SurahController controller = Get.put(
    SurahController(),
    permanent: true,
  );

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget _buildSurahItem(Surah surah) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Get.to(
        () => DetailSurahScreen(),
        arguments: {"surah": surah.nomor, "ayat": null},
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OctagramBadge(
                      number: "${surah.nomor}",
                      numberColor: isDark ? AppColors.light : AppColors.dark,
                    ),
                    SizedBox(width: 15),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${surah.namaLatin} (${surah.arti})",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(fontSize: 14),
                          ),
                          Text(
                            "${surah.tempatTurun.name} - ${surah.jumlahAyat} Ayat",
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(
                                  color: isDark
                                      ? AppColors.textPrimaryDark.withAlpha(120)
                                      : HexColor.fromHex("#676767"),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                width: 55,
                height: 55,
                "assets/svg_arab_kaligrafi/Surah_${surah.nomor}_of_114.svg",
                colorFilter: ColorFilter.mode(
                  isDark ? AppColors.light : AppColors.dark,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHizbItem(HizbData hizb) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () =>
          Get.to(() => DetailHizbScreen(), arguments: {"hizb": hizb.number}),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  OctagramBadge(
                    number: "${hizb.number}",
                    numberColor: isDark ? AppColors.light : AppColors.dark,
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hizb ${hizb.number}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall!.copyWith(fontSize: 14),
                      ),
                      Text(
                        "${hizb.startSurah}: ${hizb.startAyah} - ${hizb.endSurah}: ${hizb.endAyah}",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJuzItem(JuzData juz) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () =>
          Get.to(() => DetailJuzScreen(), arguments: {"juz": juz.number}),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  OctagramBadge(
                    number: "${juz.number}",
                    numberColor: isDark ? AppColors.light : AppColors.dark,
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Juz ${juz.number}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall!.copyWith(fontSize: 14),
                      ),
                      Text(
                        "${juz.startSurah}: ${juz.startAyah} - ${juz.endSurah}: ${juz.endAyah}",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSurahListShimmer() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const subWidths = [160.0, 120.0, 140.0, 180.0];
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 9,
      itemBuilder: (context, index) {
        final subWidth = subWidths[index % subWidths.length];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Shimmer.fromColors(
            baseColor: isDark
                ? const Color(0xFF263238)
                : const Color(0xFFE3E7EC),
            highlightColor: isDark
                ? const Color(0xFF3A464F)
                : const Color(0xFFF4F6F9),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ShimmerBox(width: 40, height: 40, radius: 10),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(
                          width: double.infinity,
                          height: 14,
                          radius: 6,
                        ),
                        const SizedBox(height: 8),
                        ShimmerBox(width: subWidth, height: 12, radius: 6),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const ShimmerBox(width: 55, height: 55, radius: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar(
        title: "Quran",
        backIconColor: isDark
            ? Theme.of(context).textTheme.titleSmall!.color
            : Theme.of(context).textTheme.titleMedium!.color,
        titleColor: isDark
            ? Theme.of(context).textTheme.titleSmall!.color
            : Theme.of(context).textTheme.titleMedium!.color,
        backgroundColor: isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : AppColors.textPrimaryDark,
        surfaceTintColor: isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : AppColors.textPrimaryDark,
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          controller: tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.black,
          indicatorWeight: 2.5,
          labelStyle: TextStyle(fontSize: 14),
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Surah",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelSmall!.color,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Juz",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelSmall!.color,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hizb",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelSmall!.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8, left: 8, top: 8),
            child: AppSearchBar(
              onChanged: controller.search,
              hintText: switch (tabController.index) {
                1 => "Cari Juz...",
                2 => "Cari Hizb...",
                _ => "Cari Surah...",
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshSurah,
              child: TabBarView(
                controller: tabController,
                children: [
                  Obx(() {
                    if (controller.isLoading.value &&
                        controller.filteredSurah.isEmpty) {
                      return _buildSurahListShimmer();
                    }
                    if (controller.filteredSurah.isEmpty) {
                      return CommonEmptyWidget(
                        showRefresh: false,
                        padded: true,
                        bordered: true,
                        refresh: controller.refreshSurah,
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.filteredSurah.length,
                      itemBuilder: (context, index) {
                        return _buildSurahItem(controller.filteredSurah[index]);
                      },
                    );
                  }),

                  Obx(() {
                    final query = controller.searchQuery.value
                        .toLowerCase()
                        .trim();
                    final filteredList = query.isEmpty
                        ? juzList
                        : juzList
                              .where(
                                (j) =>
                                    j.number.toString() == query ||
                                    'juz ${j.number}'.contains(query) ||
                                    j.startSurah.toLowerCase().contains(
                                      query,
                                    ) ||
                                    j.endSurah.toLowerCase().contains(query),
                              )
                              .toList();
                    if (controller.isLoading.value &&
                        controller.filteredSurah.isEmpty) {
                      return _buildSurahListShimmer();
                    }
                    if (filteredList.isEmpty) {
                      return CommonEmptyWidget(
                        padded: true,
                        bordered: true,
                        refresh: controller.refreshSurah,
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return _buildJuzItem(filteredList[index]);
                      },
                    );
                  }),

                  Obx(() {
                    final query = controller.searchQuery.value
                        .toLowerCase()
                        .trim();
                    final filteredList = query.isEmpty
                        ? hizbList
                        : hizbList
                              .where(
                                (h) =>
                                    h.number.toString() == query ||
                                    'hizb ${h.number}'.contains(query) ||
                                    h.startSurah.toLowerCase().contains(
                                      query,
                                    ) ||
                                    h.endSurah.toLowerCase().contains(query),
                              )
                              .toList();
                    if (controller.isLoading.value &&
                        controller.filteredSurah.isEmpty) {
                      return _buildSurahListShimmer();
                    }
                    if (filteredList.isEmpty) {
                      return CommonEmptyWidget(
                        padded: true,
                        bordered: true,
                        refresh: controller.refreshSurah,
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return _buildHizbItem(filteredList[index]);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
