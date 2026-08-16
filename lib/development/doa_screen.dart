import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/search_bar.dart';
import 'package:alquran_new/features/doa/controllers/doa_controller.dart';
import 'package:alquran_new/development/category_filter.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
              return Padding(padding: EdgeInsets.all(8), child: 
              Container(

             decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16)
                  ),
                child: Center(
                  child: Image.asset(
                    'assets/animations/bar_loader.gif',
                    height: 100,
                  ),
                ),
              ));

              
            }
            if (controller.categories.isEmpty) {
              return Center(
                child: Padding(padding: EdgeInsets.all(8), child: Container(
                  decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16)
                  ),
            
                  child: Stack(
                    children: [
                      Positioned(
                        top: -100,
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/animations/empty.json',
                              width: 180,
                              height: 180,
                            ),

                            Text(
                              "Data Tidak Ditemukan",
                              style: TextStyle(
                                color: HexColor.fromHex("#246177"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),)
              );
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
