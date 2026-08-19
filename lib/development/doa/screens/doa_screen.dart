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
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: CommonAppBar(
        title: "Doa",
      ),
      body: Stack(
        children: [
          PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Column(
              children: [
                Padding(padding: EdgeInsets.only(right: 8, left: 8, top: 8), child: Column(
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
                Expanded(child:  

                Obx(() {
            if (controller.isLoading.value) {
              return CommonLoadingWidget(padded: true, bordered: true);
            }
            if (controller.categories.isEmpty) {
              return CommonEmptyWidget(padded: true, bordered: true);
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: controller.filteredDoa.length,
              itemBuilder: (context, index) {
                final doa = controller.filteredDoa[index];
                return _buildDoaItem(doa);
              },
            );
          }),
               )
              ],
            ),
        ),
        
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
                    OctagramBadge(number: "${doa.id}"),
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
    showModalBottomSheet(
      context: context,
      backgroundColor: HexColor.fromHex("#FAFCFF"),
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
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
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
            );
          },
        );
      },
    );
  }
}
