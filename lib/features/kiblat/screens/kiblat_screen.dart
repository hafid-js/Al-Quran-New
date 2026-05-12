import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/kiblat/controllers/kiblat_controller.dart';
import 'package:alquran_new/features/kiblat/widgets/qibla_compass_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class KiblatScreen extends StatefulWidget {
  const KiblatScreen({super.key});

  @override
  State<KiblatScreen> createState() => _KiblatScreenState();
}

class _KiblatScreenState extends State<KiblatScreen> {
  final KiblatController controller = Get.put(KiblatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#132e3a").withAlpha(120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_circle_left_rounded),
          color: Colors.white,
        ),
        titleSpacing: 5,
        title: Row(
          children: [
            Container(
              height: 36,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor.fromHex("#17404a"),
              ),
              child: const Icon(
                Icons.my_location_rounded,
                size: 20,
                color: Color(0xFF2dc8b9),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Arah Kiblat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF2dc8b9)),
          );
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_off_rounded,
                    size: 64,
                    color: Color(0xFF5a7b8a),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF5a7b8a),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: controller.refreshLocation,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Coba Lagi"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2cc4b6),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildCompassSection(),
                const SizedBox(height: 24),
                _buildInfoCard(),
                const SizedBox(height: 24),
                _buildMapSection(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCompassSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HexColor.fromHex("#132e3a"),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Obx(() {
            double offset = controller.qiblaOffset;
            String direction = _getDirectionText(offset);

            return Column(
              children: [
                SizedBox(
                  height: 280,
                  child: QiblaCompassWidget(
                    heading: controller.heading.value,
                    qiblaDirection: controller.qiblaDirection.value,
                    compassAvailable: controller.compassAvailable.value,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Arah Kiblat: ${controller.qiblaDirection.value.toStringAsFixed(1)}°",
                  style: const TextStyle(
                    color: Color(0xFF2dc8b9),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  direction,
                  style: TextStyle(
                    color: (offset < 5 || offset > 355)
                        ? const Color(0xFF4CAF50)
                        : Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HexColor.fromHex("#132e3a"),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF2dc8b9).withAlpha(30),
            ),
            child: const Icon(
              Icons.location_on_rounded,
              color: Color(0xFF2dc8b9),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lokasi Anda",
                    style: TextStyle(
                      color: Color(0xFF5a7b8a),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${controller.latitude.value.toStringAsFixed(4)}°, ${controller.longitude.value.toStringAsFixed(4)}°",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
          ),
          IconButton(
            onPressed: controller.refreshLocation,
            icon: const Icon(
              Icons.my_location_rounded,
              color: Color(0xFF2dc8b9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.hardEdge,
      child: Obx(() {
        if (controller.latitude.value == 0 && controller.longitude.value == 0) {
          return const SizedBox.shrink();
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                controller.latitude.value,
                controller.longitude.value,
              ),
              initialZoom: 5,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.alquran.new',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      LatLng(
                        controller.latitude.value,
                        controller.longitude.value,
                      ),
                      const LatLng(
                        KiblatController.kaabaLat,
                        KiblatController.kaabaLon,
                      ),
                    ],
                    color: const Color(0xFFFFD700),
                    strokeWidth: 3,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      controller.latitude.value,
                      controller.longitude.value,
                    ),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.my_location_rounded,
                      color: Color(0xFF2dc8b9),
                      size: 30,
                    ),
                  ),
                  const Marker(
                    point: LatLng(
                      KiblatController.kaabaLat,
                      KiblatController.kaabaLon,
                    ),
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.mosque_rounded,
                      color: Color(0xFFFFD700),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  String _getDirectionText(double offset) {
    if (offset < 5 || offset > 355) {
      return "Anda menghadap Kiblat! ✓";
    } else if (offset > 5 && offset <= 30) {
      return "Putar ${offset.toStringAsFixed(0)}° ke kiri";
    } else if (offset >= 330 && offset < 355) {
      return "Putar ${(360 - offset).toStringAsFixed(0)}° ke kanan";
    } else if (offset > 180) {
      return "Putar ${(360 - offset).toStringAsFixed(0)}° ke kanan";
    } else {
      return "Putar ${offset.toStringAsFixed(0)}° ke kiri";
    }
  }
}
