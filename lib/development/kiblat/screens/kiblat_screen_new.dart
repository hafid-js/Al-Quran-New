import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/kiblat/controllers/kiblat_controller.dart';
import 'package:alquran_new/development/kiblat/widgets/compass_view.dart';
import 'package:alquran_new/development/kiblat/widgets/kiblat_map.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KiblatScreenNew extends StatefulWidget {
  const KiblatScreenNew({super.key});

  @override
  State<KiblatScreenNew> createState() => _KiblatScreenNewState();
}

class _KiblatScreenNewState extends State<KiblatScreenNew>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    Get.put(KiblatController());
    tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (tabController.indexIsChanging) return;
    if (tabController.index == 1) {
      final controller = Get.find<KiblatController>();
      if (controller.latitude.value == 0.0 &&
          controller.longitude.value == 0.0) {
        controller.startLocation();
      }
    }
  }

  @override
  void dispose() {
    tabController.removeListener(_onTabChanged);
    tabController.dispose();
    Get.delete<KiblatController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: CommonAppBar(
        title: "Kiblat",
        bottom: TabBar(
          controller: tabController,
          indicatorColor: HexColor.fromHex("#256980"),
          labelColor: HexColor.fromHex("#256980"),
          unselectedLabelColor: HexColor.fromHex("#5a7b8a"),
           overlayColor: WidgetStateProperty.all(
    Colors.transparent,
  ),
          tabs: const [
            Tab(text: "Kompas"),
            Tab(text: "Peta"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [CompassView(), KiblatMap()],
      ),
    );
  }
}
