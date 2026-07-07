import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:alquran_new/features/kiblat/controllers/kiblat_controller.dart';
import 'package:alquran_new/features/kiblat/services/qibla_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CompassView extends StatefulWidget {
  const CompassView({super.key});

  @override
  State<CompassView> createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  Stream<LocationStatus> get stream => _locationStreamController.stream;
  bool? _hasCompassSensor;

  @override
  void initState() {
    super.initState();
    _checkDeviceSupport();
    _checkLocationStatus();
  }

  @override
  void dispose() {
    _locationStreamController.close();
    super.dispose();
  }

  Future<void> _checkDeviceSupport() async {
    if (Platform.isAndroid) {
      final hasSensor = await FlutterQiblah.androidDeviceSensorSupport();
      if (mounted) setState(() => _hasCompassSensor = hasSensor ?? false);
    } else {
      _hasCompassSensor = true;
    }
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasCompassSensor == false) {
      return _buildNoCompassView(context);
    }

    if (_hasCompassSensor == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<LocationStatus>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.enabled) {
            return _LocationErrorWidget(
              error: "Hidupkan GPS untuk menggunakan kompas",
              callback: _checkLocationStatus,
            );
          }

          switch (snapshot.data!.status) {
            case LocationPermission.always:
            case LocationPermission.whileInUse:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.find<KiblatController>().startLocation();
              });
              return const _QiblahCompassWidget();

            case LocationPermission.denied:
              return _LocationErrorWidget(
                error: "Izin lokasi ditolak",
                callback: _checkLocationStatus,
              );
            case LocationPermission.deniedForever:
              return _LocationErrorWidget(
                error: "Izin lokasi ditolak permanen",
                callback: () {
                  Get.find<KiblatController>().openAppSettings();
                },
              );
            case LocationPermission.unableToDetermine:
              return _LocationErrorWidget(
                error: "Tidak dapat menentukan izin lokasi",
                callback: _checkLocationStatus,
              );
          }
        },
      ),
    );
  }

  Widget _buildNoCompassView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.explore_off,
                size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Perangkat Tidak Memiliki Kompas',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Perangkat ini tidak dilengkapi sensor kompas (magnetometer).\nGunakan tab Peta untuk melihat arah kiblat.',
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback callback;

  const _LocationErrorWidget({
    required this.error,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_off,
                size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              error,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: callback,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class _QiblahCompassWidget extends StatelessWidget {
  const _QiblahCompassWidget();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KiblatController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
              ],
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'Menunggu data kompas...',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          );
        }

        final data = snapshot.data!;

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              _buildInfoCard(context, data, controller),
              const SizedBox(height: 32),
              SizedBox(
                width: 280,
                height: 280,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: (data.direction * pi / 180 * -1),
                      child: CustomPaint(
                        size: const Size(280, 280),
                        painter: _CompassRosePainter(isDark: isDark),
                      ),
                    ),
                    Transform.rotate(
                      angle: (data.qiblah * pi / 180 * -1),
                      alignment: Alignment.center,
                      child: CustomPaint(
                        size: const Size(280, 280),
                        painter: _NeedlePainter(),
                      ),
                    ),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${data.offset.toStringAsFixed(1)}° dari arah hadap',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 24),
              _buildLocationCard(context, controller),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(
      BuildContext context, QiblahDirection data, KiblatController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
              Icon(Icons.explore,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                '${data.qiblah.toStringAsFixed(1)}°',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(width: 8),
              Text(
                QiblaCalculator.getDirectionName(data.qiblah),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.straighten,
                    size: 16,
                    color: Theme.of(context).textTheme.labelSmall?.color),
                const SizedBox(width: 4),
                Text(
                  'Jarak: ${controller.qiblaDistanceText}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLocationCard(
      BuildContext context, KiblatController controller) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  Text('Latitude',
                      style: Theme.of(context).textTheme.labelSmall),
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
                  Text('Longitude',
                      style: Theme.of(context).textTheme.labelSmall),
                  Text(
                    controller.longitude.value.toStringAsFixed(4),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _CompassRosePainter extends CustomPainter {
  final bool isDark;

  _CompassRosePainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = min(cx, cy) - 8;

    canvas.save();
    canvas.translate(cx, cy);

    final borderPaint = Paint()..style = PaintingStyle.stroke;
    final markPaint = Paint()..style = PaintingStyle.stroke;

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
        markPaint.color = isDark ? Colors.white38 : Colors.black26;
        markPaint.strokeWidth = 1.5;
      } else {
        innerR = radius * 0.92;
        markPaint.color = isDark ? Colors.white24 : Colors.black12;
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

  void _drawLabel(Canvas canvas, String text, double angle, double radius,
      bool isDark, bool isNorth) {
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
  bool shouldRepaint(_CompassRosePainter oldDelegate) =>
      oldDelegate.isDark != isDark;
}

class _NeedlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = min(cx, cy) - 8;

    canvas.save();
    canvas.translate(cx, cy);

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
  bool shouldRepaint(_NeedlePainter oldDelegate) => false;
}
