import 'package:alquran_new/features/kiblat/controllers/kiblat_controller.dart';
import 'package:alquran_new/features/kiblat/widgets/compass_view.dart';
import 'package:alquran_new/features/kiblat/widgets/kiblat_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KiblatScreen extends StatefulWidget {
  const KiblatScreen({super.key});

  @override
  State<KiblatScreen> createState() => _KiblatScreenState();
}

class _KiblatScreenState extends State<KiblatScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final KiblatController controller = Get.put(KiblatController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.requestPermissionsAndLocate();
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    Get.delete<KiblatController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Icon(
                Icons.my_location_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Text("Kiblat", style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).textTheme.labelSmall?.color,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.navigation, size: 18, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 6),
                  const Text("Kompas"),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.map, size: 18),
                  const SizedBox(width: 6),
                  const Text("Peta"),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          CompassView(),
          KiblatMap(),
        ],
      ),
    );
  }
}
