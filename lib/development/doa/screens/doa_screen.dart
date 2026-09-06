import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/shared/widgets/search_bar.dart';
import 'package:alquran_new/development/doa/controllers/doa_controller.dart';
import 'package:alquran_new/development/shared/widgets/category_filter.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
import 'package:alquran_new/development/shared/widgets/common_empty_widget.dart';
import 'package:alquran_new/development/shared/widgets/common_loading_widget.dart';
import 'package:alquran_new/development/shared/widgets/octagram_badge.dart';
import 'package:alquran_new/development/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  final DoaController controller = Get.put(DoaController());
  final SettingsController setting = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar(
        title: "Doa",
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        titleColor: Theme.of(context).textTheme.titleMedium!.color,
        backIconColor: Theme.of(context).textTheme.titleSmall!.color,
      ),
      body: Stack(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8, left: 8, top: 8),
                  child: Column(
                    children: [
                      AppSearchBar(
                        onChanged: controller.search,
                        hintText: "Cari Doa...",
                      ),
                      SizedBox(height: 8),
                      Obx(() {
                        final categories =
                            controller.doaList
                                .map((e) => e.grup)
                                .toSet()
                                .toList()
                              ..sort();

                        return CategoryFilter(
                          categories: categories,
                          activeCategory: controller.activeCategory.value,
                          onCategorySelected: (category) {
                            controller.filter(category, null);
                          },
                        );
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return CommonLoadingWidget(padded: true, bordered: true);
                    }
                    if (controller.filteredDoa.isEmpty) {
                      return CommonEmptyWidget(
                        showRefresh: false,
                        padded: true,
                        bordered: true,
                        refresh: () => controller.fetchDoa(),
                      );
                    }
                    return RefreshIndicator(
          backgroundColor: isDark ? Theme.of(context).cardColor : AppColors.primary,
          color: AppColors.secondary,
                      onRefresh: controller.fetchDoa,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.filteredDoa.length,
                        itemBuilder: (context, index) {
                          final doa = controller.filteredDoa[index];
                          return _buildDoaItem(doa);
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoaItem(doa) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        final selectedIndex = setting.fontSelected.value;
        final fontFamily = fontArabs[selectedIndex]["title"];
        _showDoaDetail(doa, fontFamily);
      },
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
                      number: "${doa.id}",
                      numberColor: isDark ? AppColors.light : AppColors.dark,
                    ),
                    SizedBox(width: 15),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            doa.nama,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(fontSize: 14),
                          ),
                          Text(
                            doa.grup,
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(
                                  color: isDark
                                      ? AppColors.textPrimaryDark.withAlpha(120)
                                      : null,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDoaDetail(doa, String fontFamily) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? Theme.of(context).cardColor : Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doa.nama, style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: 5),
                  Text(
                    doa.grup,
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textPrimaryDark.withAlpha(120)
                          : HexColor.fromHex("#676767"),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        doa.ar,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 28,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                          height: 2.5,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    doa.tr,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppColors.secondary : AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    doa.idn,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Theme.of(context).cardColor
                          : AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                      border: isDark
                          ? Border(
                              left: BorderSide(
                                width: 3,
                                color: AppColors.secondary,
                              ),
                            )
                          : null,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(10),
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        doa.tentang,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
