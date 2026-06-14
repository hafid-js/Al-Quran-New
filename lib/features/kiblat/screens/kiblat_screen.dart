import 'dart:io';

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

class _KiblatScreenState extends State<KiblatScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final KiblatController controller = Get.put(KiblatController());

  Widget _deviceWarning(KiblatController c) {
    if (!c.deviceHasCompassSensor.value) {
      return _androidNoCompass();
    }

    if (Platform.isIOS &&
        (!c.hasHeadingData.value && c.compassAvailable.value)) {
      return _iosSystemWarning();
    }

    return const SizedBox();
  }

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
                  Icon(
                    Icons.navigation,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
      body: Obx(() {
        return Column(
          children: [
            _deviceWarning(controller),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [CompassView(), KiblatMap()],
              ),
            ),
          ],
        );
      }),
    );
  }
}

Widget _androidNoCompass() {
  return Container(
    margin: const EdgeInsets.all(12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.red.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.red),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "⚠ Perangkat tidak memiliki sensor kompas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text("Fitur kompas tidak dapat digunakan di perangkat ini."),
        SizedBox(height: 6),
        Text("Gunakan mode Peta untuk menentukan arah kiblat."),
      ],
    ),
  );
}

Widget _iosSystemWarning() {
  return Container(
    margin: const EdgeInsets.all(12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.orange.withOpacity(0.08),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.orange.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
            const SizedBox(width: 8),
            Text(
              "Kalibrasi Kompas iOS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Aktifkan kalibrasi kompas iOS agar kompas berfungsi:",
          style: TextStyle(fontSize: 13, color: Colors.orange.shade900),
        ),
        const SizedBox(height: 8),
        _iosBulletItem("Settings → Privacy & Security"),
        _iosBulletItem("Location Services → System Services"),
        _iosBulletItem("Motion Calibration & Distance = ON"),
        _iosBulletItem("Compass Calibration = ON"),
      ],
    ),
  );
}

Widget _iosBulletItem(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.chevron_right, size: 16, color: Colors.orange.shade700),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.orange.shade900),
          ),
        ),
      ],
    ),
  );
}
