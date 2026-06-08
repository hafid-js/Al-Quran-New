import 'dart:math';
import 'package:alquran_new/features/kiblat/controllers/kiblat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompassView extends StatelessWidget {
  const CompassView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KiblatController>();

    
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      if (controller.isDeniedForever.value) {
        return _buildDeniedForeverView(context, controller);
      }

      if (!controller.hasPermission.value) {
        return _buildPermissionView(context, controller);
      }

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.compassAvailable.value &&
          !controller.hasHeadingData.value &&
          controller.errorMessage.value.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Menunggu sensor kompas...',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Gerakkan perangkat membentuk angka 8 untuk kalibrasi',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      if (!controller.compassAvailable.value) {
        return _buildNoCompassView(context, controller);
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return _buildErrorView(context, controller);
      }

      return _buildCompass(context, controller, isDark);
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
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => controller.requestPermissionsAndLocate(),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoCompassView(BuildContext context, KiblatController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.explore_off, size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Perangkat Tidak Memiliki Kompas',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Perangkat ini tidak dilengkapi sensor kompas (magnetometer). Arah kiblat tidak dapat ditampilkan.',
              style: Theme.of(context).textTheme.labelSmall,
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

  Widget _buildCompass(BuildContext context, KiblatController controller, bool isDark) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),

          _buildInfoCard(context, controller, isDark),

          const SizedBox(height: 32),

          SizedBox(
            width: 320,
            height: 320,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(320, 320),
                  painter: CompassRosePainter(
                    heading: controller.heading.value,
                    isDark: isDark,
                  ),
                ),
                CustomPaint(
                  size: const Size(320, 320),
                  painter: QiblaArrowPainter(
                    qiblaAngle: controller.qiblaDirection.value,
                    heading: controller.heading.value,
                    isDark: isDark,
                  ),
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.navigation, size: 20, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                '${controller.heading.value.toStringAsFixed(0)}° ${controller.headingDirectionName}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Latitude', style: Theme.of(context).textTheme.labelSmall),
                      Text(
                        controller.latitude.value.toStringAsFixed(4),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Longitude', style: Theme.of(context).textTheme.labelSmall),
                      Text(
                        controller.longitude.value.toStringAsFixed(4),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, KiblatController controller, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withAlpha(40),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Arah Kiblat',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.explore,
                size: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                '${controller.qiblaDirection.value.toStringAsFixed(1)}°',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                controller.qiblaDirectionName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.straighten,
                size: 16,
                color: Theme.of(context).textTheme.labelSmall?.color,
              ),
              const SizedBox(width: 4),
              Text(
                'Jarak: ${controller.qiblaDistanceText}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CompassRosePainter extends CustomPainter {
  final double heading;
  final bool isDark;

  CompassRosePainter({required this.heading, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = min(cx, cy) - 8;

    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(-heading * pi / 180);

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke;

    final markPaint = Paint()
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 360; i += 5) {
      final angle = i * pi / 180;
      final isMajor = i % 30 == 0;
      final isMid = i % 15 == 0 && !isMajor;

      double outerR = radius;
      double innerR;

      if (isMajor) {
        innerR = radius * 0.82;
        markPaint.color = isDark ? Colors.white70 : Colors.black54;
        markPaint.strokeWidth = 2.0;
      } else if (isMid) {
        innerR = radius * 0.88;
        markPaint.color = (isDark ? Colors.white38 : Colors.black26);
        markPaint.strokeWidth = 1.5;
      } else {
        innerR = radius * 0.92;
        markPaint.color = (isDark ? Colors.white24 : Colors.black12);
        markPaint.strokeWidth = 1.0;
      }

      final x1 = innerR * sin(angle);
      final y1 = -innerR * cos(angle);
      final x2 = outerR * sin(angle);
      final y2 = -outerR * cos(angle);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), markPaint);
    }

    borderPaint.color = isDark ? Colors.white24 : Colors.black12;
    borderPaint.strokeWidth = 2;
    canvas.drawCircle(Offset.zero, radius, borderPaint);

    borderPaint.color = isDark ? Colors.white12 : Colors.black12;
    borderPaint.strokeWidth = 1;
    canvas.drawCircle(Offset.zero, radius * 0.82, borderPaint);

    _drawLabel(canvas, 'U', 0, radius, isDark, true);
    _drawLabel(canvas, 'S', pi, radius, isDark, false);
    _drawLabel(canvas, 'T', pi / 2, radius, isDark, false);
    _drawLabel(canvas, 'B', -pi / 2, radius, isDark, false);

    canvas.restore();
  }

  void _drawLabel(Canvas canvas, String text, double angle, double radius, bool isDark, bool isNorth) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: isNorth
              ? Colors.redAccent
              : (isDark ? Colors.white70 : Colors.black54),
          fontSize: 20,
          fontWeight: isNorth ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final x = (radius * 0.7) * sin(angle) - tp.width / 2;
    final y = -(radius * 0.7) * cos(angle) - tp.height / 2;
    tp.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(CompassRosePainter oldDelegate) =>
      oldDelegate.heading != heading || oldDelegate.isDark != isDark;
}

class QiblaArrowPainter extends CustomPainter {
  final double qiblaAngle;
  final double heading;
  final bool isDark;

  QiblaArrowPainter({
    required this.qiblaAngle,
    required this.heading,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = min(cx, cy) - 8;
    final arrowAngle = (qiblaAngle - heading) * pi / 180;

    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(arrowAngle);

    final arrowPaint = Paint()
      ..color = Colors.amber.shade600
      ..style = PaintingStyle.fill;

    final stemPaint = Paint()
      ..color = Colors.amber.shade600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final arrowLength = radius * 0.7;
    final arrowHeadSize = 18.0;

    final path = Path();
    path.moveTo(0, -arrowLength);
    path.lineTo(-arrowHeadSize, -arrowLength + arrowHeadSize + 10);
    path.lineTo(0, -arrowLength + arrowHeadSize);
    path.lineTo(arrowHeadSize, -arrowLength + arrowHeadSize + 10);
    path.close();

    canvas.drawPath(path, arrowPaint);
    canvas.drawLine(
      Offset(0, -arrowLength + arrowHeadSize),
      Offset(0, radius * 0.15),
      stemPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(QiblaArrowPainter oldDelegate) =>
      oldDelegate.qiblaAngle != qiblaAngle ||
      oldDelegate.heading != heading ||
      oldDelegate.isDark != isDark;
}
