import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';

class KompasScreen extends StatefulWidget {
  const KompasScreen({super.key});

  @override
  State<KompasScreen> createState() => _KompasScreenState();
}

class _KompasScreenState extends State<KompasScreen> {
  double _heading = 0;
  double _qiblaDirection = 0;

  StreamSubscription? _magnetometerSub;
  StreamSubscription? _accelerometerSub;

  double _mx = 0, _my = 0, _mz = 0;
  double _ax = 0, _ay = 0, _az = 0;
  bool _hasMagData = false;
  bool _hasAccData = false;

  static const double _filterAlpha = 0.35;

  @override
  void initState() {
    super.initState();
    _initCompass();
  }

  Future<void> _initCompass() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location service tidak aktif');
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        debugPrint('Permission lokasi ditolak');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      _qiblaDirection = calculateQiblaDirection(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      debugPrint('Error getting location: $e');
    }

    _magnetometerSub = magnetometerEventStream().listen(
      (event) {
        _mx += (event.x - _mx) * _filterAlpha;
        _my += (event.y - _my) * _filterAlpha;
        _mz += (event.z - _mz) * _filterAlpha;
        _hasMagData = true;
        _calculateHeading();
      },
      onError: (e) => debugPrint('Magnetometer error: $e'),
    );

    _accelerometerSub = accelerometerEventStream().listen(
      (event) {
        _ax += (event.x - _ax) * _filterAlpha;
        _ay += (event.y - _ay) * _filterAlpha;
        _az += (event.z - _az) * _filterAlpha;
        _hasAccData = true;
        _calculateHeading();
      },
      onError: (e) => debugPrint('Accelerometer error: $e'),
    );

    if (!mounted) return;
    setState(() {});
  }

  void _calculateHeading() {
    if (!_hasMagData || !_hasAccData) return;

    final roll = atan2(_ay, -_az);
    final pitch = atan2(-_ax, sqrt(_ay * _ay + _az * _az));

    final cR = cos(roll), sR = sin(roll);
    final cP = cos(pitch), sP = sin(pitch);

    final magX = _mx * cP + _mz * sP;
    final magY = _mx * sR * sP + _my * cR - _mz * sR * cP;

    final heading = (atan2(-magX, magY) * 180 / pi + 360) % 360;

    if (!mounted) return;
    setState(() => _heading = heading);
  }

  @override
  void dispose() {
    _magnetometerSub?.cancel();
    _accelerometerSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qiblaAngle = (_qiblaDirection - _heading);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
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
                Icons.navigation,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Kompas Kiblat',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
      body: _buildBody(context, qiblaAngle),
    );
  }

  Widget _buildBody(BuildContext context, double qiblaAngle) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black54
                      : Colors.black.withAlpha(30),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CustomPaint(
              size: const Size(300, 300),
              painter: _CompassPainter(
                heading: _heading,
                qiblaAngle: qiblaAngle,
                isDark: isDark,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '${_heading.toStringAsFixed(0)}°',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getDirectionName(_heading),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 32),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.explore,
                  color: Colors.amber.shade600,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Kiblat: ${_qiblaDirection.toStringAsFixed(1)}° ${_getDirectionName(_qiblaDirection)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getDirectionName(double degrees) {
    if (degrees >= 337.5 || degrees < 22.5) return 'U';
    if (degrees >= 22.5 && degrees < 67.5) return 'TL';
    if (degrees >= 67.5 && degrees < 112.5) return 'T';
    if (degrees >= 112.5 && degrees < 157.5) return 'TG';
    if (degrees >= 157.5 && degrees < 202.5) return 'S';
    if (degrees >= 202.5 && degrees < 247.5) return 'BD';
    if (degrees >= 247.5 && degrees < 292.5) return 'B';
    return 'BL';
  }
}

class _CompassPainter extends CustomPainter {
  final double heading;
  final double qiblaAngle;
  final bool isDark;

  _CompassPainter({
    required this.heading,
    required this.qiblaAngle,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = min(cx, cy) - 12;

    canvas.save();
    canvas.translate(cx, cy);

    _drawCompassRing(canvas, radius);

    canvas.rotate(-heading * pi / 180);
    _drawTickMarks(canvas, radius);
    _drawLabels(canvas, radius);

    canvas.restore();

    _drawQiblaArrow(canvas, size, radius, qiblaAngle);
    _drawCenterDot(canvas, size);
  }

  void _drawCompassRing(Canvas canvas, double radius) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = isDark ? Colors.white38 : Colors.black38;
    canvas.drawCircle(Offset.zero, radius, paint);
  }

  void _drawTickMarks(Canvas canvas, double radius) {
    for (int i = 0; i < 360; i += 5) {
      final angle = i * pi / 180;
      final isMajor = i % 30 == 0;
      final isMid = i % 15 == 0 && !isMajor;

      double innerR;
      final paint = Paint()..style = PaintingStyle.stroke;

      if (isMajor) {
        innerR = radius * 0.82;
        paint
          ..color = isDark ? Colors.white70 : Colors.black54
          ..strokeWidth = 2.5;
      } else if (isMid) {
        innerR = radius * 0.88;
        paint
          ..color = isDark ? Colors.white38 : Colors.black26
          ..strokeWidth = 1.5;
      } else {
        innerR = radius * 0.92;
        paint
          ..color = isDark ? Colors.white24 : Colors.black12
          ..strokeWidth = 1;
      }

      canvas.drawLine(
        Offset(innerR * sin(angle), -innerR * cos(angle)),
        Offset(radius * sin(angle), -radius * cos(angle)),
        paint,
      );
    }
  }

  void _drawLabels(Canvas canvas, double radius) {
    _drawLabel(canvas, 'U', 0, radius, true);
    _drawLabel(canvas, 'S', pi, radius, false);
    _drawLabel(canvas, 'T', pi / 2, radius, false);
    _drawLabel(canvas, 'B', -pi / 2, radius, false);
  }

  void _drawLabel(Canvas canvas, String text, double angle, double radius, bool isNorth) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: isNorth
              ? Colors.redAccent
              : (isDark ? Colors.white70 : Colors.black54),
          fontSize: 22,
          fontWeight: isNorth ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final x = (radius * 0.7) * sin(angle) - tp.width / 2;
    final y = -(radius * 0.7) * cos(angle) - tp.height / 2;
    tp.paint(canvas, Offset(x, y));
  }

  void _drawQiblaArrow(Canvas canvas, Size size, double radius, double qiblaAngle) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(qiblaAngle * pi / 180);

    final arrowPaint = Paint()
      ..color = Colors.amber.shade600
      ..style = PaintingStyle.fill;

    final stemPaint = Paint()
      ..color = Colors.amber.shade600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final arrowLen = radius * 0.7;
    final headSize = 18.0;

    final path = Path();
    path.moveTo(0, -arrowLen);
    path.lineTo(-headSize, -arrowLen + headSize + 10);
    path.lineTo(0, -arrowLen + headSize);
    path.lineTo(headSize, -arrowLen + headSize + 10);
    path.close();

    canvas.drawPath(path, arrowPaint);
    canvas.drawLine(
      Offset(0, -arrowLen + headSize),
      Offset(0, radius * 0.15),
      stemPaint,
    );

    canvas.restore();
  }

  void _drawCenterDot(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final paint = Paint()
      ..color = Colors.amber.shade600
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), 8, paint);
  }

  @override
  bool shouldRepaint(_CompassPainter oldDelegate) =>
      (oldDelegate.heading - heading).abs() > 0.5 ||
      (oldDelegate.qiblaAngle - qiblaAngle).abs() > 0.5 ||
      oldDelegate.isDark != isDark;
}

double calculateQiblaDirection(double lat, double lng) {
  const kaabaLat = 21.422487;
  const kaabaLng = 39.826206;

  final phiK = kaabaLat * pi / 180;
  final lambdaK = kaabaLng * pi / 180;
  final phi = lat * pi / 180;
  final lambda = lng * pi / 180;

  final y = sin(lambdaK - lambda);
  final x = cos(phi) * tan(phiK) - sin(phi) * cos(lambdaK - lambda);
  final bearing = atan2(y, x) * 180 / pi;

  return (bearing + 360) % 360;
}
