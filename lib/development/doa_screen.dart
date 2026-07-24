import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/widgets/loading.dart';
import 'package:alquran_new/development/search_bar.dart';
import 'package:alquran_new/features/doa/controllers/doa_controller.dart';
import 'package:alquran_new/development/category_filter.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

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
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(

        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Doa",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Icon(Iconsax.search_normal_1, color: Colors.black),
          SizedBox(width: 15),
        ],
        actionsPadding: EdgeInsets.all(16),

      ),
      body: Stack(
        children: [
          PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Column(
              children: [
                Padding(padding: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 0), child: Column(
                  children: [
                    AppSearchBar(
                  onChanged: controller.search,
                  hintText: "Cari Doa...",
                ),
                SizedBox(height: 8),
                Obx(() {
                  final categories =
                      controller.doaList.map((e) => e.grup).toSet().toList()
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
                ),),
                Expanded(child:  Obx(() {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: controller.filteredDoa.length,
              itemBuilder: (context, index) {
                final doa = controller.filteredDoa[index];
                return _buildDoaItem(doa);
              },
            );
          }),)
              ],
            ),
        ),
         
          Obx(() {
            if (!controller.isLoading.value) {
              return const SizedBox.shrink();
            }
            return const Positioned.fill(child: Loading());
          }),
        ],
      ),
    );
  }

  Widget _buildDoaItem(doa) {
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#DBB893").withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            "${doa.id}",
                            style: TextStyle(
                              color: HexColor.fromHex("#1E4355"),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Image.asset(
                            "assets/icon/octagram.png",
                            height: 35,
                            width: 35,
                            color: HexColor.fromHex("#DBB893"),
                          ),
                        ],
                      ),
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
                            style: TextStyle(
                              color: HexColor.fromHex("#1E4355"),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            doa.grup,
                            style: TextStyle(
                              color: HexColor.fromHex("#676767"),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
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
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (bottomSheetContext) => [
        SliverWoltModalSheetPage(
          backgroundColor: HexColor.fromHex("#FAFCFF"),
          surfaceTintColor: HexColor.fromHex("#FAFCFF"),
          hasTopBarLayer: false,
          mainContentSliversBuilder: (context) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doa.nama,
                      style: TextStyle(
                        color: HexColor.fromHex("#256980"),
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                        
                      )
                    ),
                    SizedBox(height: 5),
                    Text(
                      doa.grup,
                       style: TextStyle(
                              color: HexColor.fromHex("#676767"),
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
                            color: Colors.black,
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
                        color:  const Color.fromARGB(255, 45, 45, 45)
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      doa.idn,
                      style: TextStyle(
                        fontSize: 14,
                        color:  const Color.fromARGB(255, 45, 45, 45)
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                       
                        color: HexColor.fromHex("#FFFFFF"),
                        borderRadius: BorderRadius.circular(12),
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
                          style: TextStyle(
                            color: const Color.fromARGB(255, 45, 45, 45),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
