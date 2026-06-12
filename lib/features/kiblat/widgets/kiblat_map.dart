// import 'package:alquran_new/features/kiblat/controllers/kiblat_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart';

// class KiblatMap extends StatelessWidget {
//   const KiblatMap({super.key});

//   static const double kaabaLat = 21.4225;
//   static const double kaabaLng = 39.8262;

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<KiblatController>();

//     return Obx(() {
//       if (!controller.hasPermission.value) {
//         return _buildMapPlaceholder(context, 'Aktifkan lokasi untuk melihat peta');
//       }

//       if (controller.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       final userPoint = LatLng(controller.latitude.value, controller.longitude.value);
//       final kaabaPoint = const LatLng(kaabaLat, kaabaLng);

//       return Stack(
//         children: [
//           FlutterMap(
//             options: MapOptions(
//               initialCenter: userPoint,
//               initialZoom: 4.0,
//               interactionOptions: const InteractionOptions(
//                 flags: InteractiveFlag.all,
//               ),
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 userAgentPackageName: 'com.alquran.app',
//               ),
//               PolylineLayer(
//                 polylines: [
//                   Polyline(
//                     points: [userPoint, kaabaPoint],
//                     color: Theme.of(context).colorScheme.primary,
//                     strokeWidth: 2.5,
//                   ),
//                 ],
//               ),
//               MarkerLayer(
//                 markers: [
//                   Marker(
//                     point: userPoint,
//                     width: 40,
//                     height: 40,
//                     child: Icon(
//                       Icons.my_location,
//                       color: Theme.of(context).colorScheme.primary,
//                       size: 36,
//                     ),
//                   ),
//                   const Marker(
//                     point: LatLng(kaabaLat, kaabaLng),
//                     width: 40,
//                     height: 40,
//                     child: Icon(
//                       Icons.location_on,
//                       color: Colors.red,
//                       size: 40,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           Positioned(
//             left: 12,
//             right: 12,
//             top: 12,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor.withAlpha(230),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withAlpha(26),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.explore, size: 18, color: Theme.of(context).colorScheme.primary),
//                       const SizedBox(width: 6),
//                       Text(
//                         'Arah Kiblat',
//                         style: Theme.of(context).textTheme.labelMedium?.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${controller.qiblaDirection.value.toStringAsFixed(1)}° ${controller.qiblaDirectionName}',
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                   ),
//                   Text(
//                     'Jarak: ${controller.qiblaDistanceText}',
//                     style: Theme.of(context).textTheme.labelSmall,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     });
//   }

//   Widget _buildMapPlaceholder(BuildContext context, String message) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.map, size: 64, color: Theme.of(context).colorScheme.primary),
//             const SizedBox(height: 16),
//             Text(
//               message,
//               style: Theme.of(context).textTheme.labelMedium,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
