import 'package:alquran_new/features/kiblat/controllers/kiblat_controller.dart';
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
      if (controller.isDeniedForever.value) {
        return _buildDeniedForeverView(context, controller);
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return _buildErrorView(context, controller);
      }

      if (!controller.hasPermission.value) {
        return _buildPermissionView(context, controller);
      }

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final userPoint = LatLng(controller.latitude.value, controller.longitude.value);
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
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.alquran.app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [userPoint, kaabaPoint],
                    color: Theme.of(context).colorScheme.primary,
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
                      color: Theme.of(context).colorScheme.primary,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withAlpha(230),
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
                      Icon(Icons.explore, size: 18, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 6),
                      Text(
                        'Arah Kiblat',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${controller.qiblaDirection.value.toStringAsFixed(1)}° ${controller.qiblaDirectionName}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Jarak: ${controller.qiblaDistanceText}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '* Perbesar peta (zoom) untuk melihat posisi kiblat yang sebenarnya',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
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

  Widget _buildPermissionView(BuildContext context, KiblatController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_off, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Kiblat membutuhkan akses lokasi',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Aktifkan lokasi untuk mengetahui arah kiblat',
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => controller.requestPermissionsAndLocate(),
              icon: const Icon(Icons.my_location),
              label: const Text('Aktifkan Lokasi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeniedForeverView(BuildContext context, KiblatController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_off, size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Izin lokasi ditolak permanen',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Buka Pengaturan & aktifkan izin lokasi untuk menggunakan fitur kiblat',
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => controller.openAppSettings(),
              icon: const Icon(Icons.settings),
              label: const Text('Buka Pengaturan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, KiblatController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              controller.errorMessage.value,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => controller.requestPermissionsAndLocate(),
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
