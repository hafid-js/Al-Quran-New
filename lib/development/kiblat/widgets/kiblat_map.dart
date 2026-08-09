import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/kiblat/controllers/kiblat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class KiblatMap extends StatelessWidget {
  const KiblatMap({super.key});

  static const double kaabaLat = 21.4225;
  static const double kaabaLng = 39.8262;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KiblatController>();

    return Obx(() {
      if (controller.errorMessage.value.isNotEmpty) {
        return _buildErrorView(context, controller);
      }

      if (controller.latitude.value == 0.0 &&
          controller.longitude.value == 0.0 &&
          controller.isLoading.value) {
        return Center(child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset('assets/animations/bar_loader.gif', height:100),
              )
            ));
      }

      if (controller.latitude.value == 0.0 &&
          controller.longitude.value == 0.0) {
        return _buildNoLocationView(context, controller);
      }

      final userPoint =
          LatLng(controller.latitude.value, controller.longitude.value);
      final kaabaPoint = const LatLng(kaabaLat, kaabaLng);

      return Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: userPoint,
              initialZoom: 4.0,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.alquran.app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [userPoint, kaabaPoint],
                    color: HexColor.fromHex("#256980"),
                    strokeWidth: 2.5,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: userPoint,
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.my_location,
                      color: HexColor.fromHex("#256980"),
                      size: 36,
                    ),
                  ),
                  const Marker(
                    point: LatLng(kaabaLat, kaabaLng),
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 12,
            right: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#256980").withAlpha(230),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.explore,
                          size: 18,
                          color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        'Arah Kiblat',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Colors.white,fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${controller.qiblaDirection.value.toStringAsFixed(1)}° ${controller.qiblaDirectionName}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: HexColor.fromHex("#D39D52"),
                        ),
                  ),
                  Text(
                    'Jarak: ${controller.qiblaDistanceText}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '* Perbesar peta (zoom) untuk melihat posisi kiblat lebih jelas.',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildNoLocationView(BuildContext context, KiblatController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.map,
                size: 64, color: HexColor.fromHex("#256980")),
            const SizedBox(height: 16),
            Text(
              'Lokasi belum tersedia',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Buka tab Kompas untuk mengaktifkan lokasi, atau tekan tombol di bawah.',
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => controller.startLocation(),
                style: ElevatedButton.styleFrom(
    backgroundColor: HexColor.fromHex("#256980"),
    foregroundColor: Colors.white,
  ),
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(
      BuildContext context, KiblatController controller) {
    final isPermanent = controller.errorMessage.value.contains('permanen');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              controller.errorMessage.value,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(color: HexColor.fromHex("#256980")),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                if (isPermanent) {
                  controller.openAppSettings();
                } else {
                  controller.startLocation();
                }
              },
                style: ElevatedButton.styleFrom(
    backgroundColor: HexColor.fromHex("#256980"),
    foregroundColor: Colors.white,
  ),
              icon: Icon(isPermanent ? Icons.settings : Icons.refresh),
              label: Text(isPermanent ? 'Buka Pengaturan' : 'Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
