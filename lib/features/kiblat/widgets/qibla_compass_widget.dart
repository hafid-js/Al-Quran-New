import 'dart:math';
import 'package:flutter/material.dart';

class QiblaCompassWidget extends StatelessWidget {
  final double heading;
  final double qiblaDirection;
  final bool compassAvailable;

  const QiblaCompassWidget({
    super.key,
    required this.heading,
    required this.qiblaDirection,
    this.compassAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = min(constraints.maxWidth, constraints.maxHeight);
        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(size, size),
                  painter: _CompassPainter(
                    heading: heading,
                    qiblaDirection: qiblaDirection,
                    compassAvailable: compassAvailable,
                  ),
                ),
                if (!compassAvailable)
                  Positioned(
                    bottom: size * 0.15,
                    child: Text(
                      "Kompas tidak tersedia",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CompassPainter extends CustomPainter {
  final double heading;
  final double qiblaDirection;
  final bool compassAvailable;

  _CompassPainter({
    required this.heading,
    required this.qiblaDirection,
    this.compassAvailable = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2 - 10;
    Offset center = Offset(centerX, centerY);

    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(-heading * pi / 180);
    canvas.translate(-centerX, -centerY);

    _drawOuterRing(canvas, center, radius);
    _drawDegreeMarkers(canvas, center, radius);
    _drawCardinalLabels(canvas, center, radius);
    _drawQiblaIndicator(canvas, center, radius);

    canvas.restore();

    _drawNorthNeedle(canvas, center, radius);
    _drawCenterCircle(canvas, center);
  }

  void _drawOuterRing(Canvas canvas, Offset center, double radius) {
    Paint ringPaint = Paint()
      ..color = const Color(0xFF2dc8b9).withAlpha(30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(center, radius, ringPaint);

    Paint innerRingPaint = Paint()
      ..color = const Color(0xFF2dc8b9).withAlpha(15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 15, innerRingPaint);
  }

  void _drawDegreeMarkers(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 360; i += 30) {
      double rad = (i - 90) * pi / 180;
      double innerR = (i % 90 == 0) ? radius - 20 : radius - 12;
      double x1 = center.dx + innerR * cos(rad);
      double y1 = center.dy + innerR * sin(rad);
      double x2 = center.dx + (radius - 5) * cos(rad);
      double y2 = center.dy + (radius - 5) * sin(rad);

      Paint linePaint = Paint()
        ..color = (i % 90 == 0)
            ? const Color(0xFF2dc8b9).withAlpha(120)
            : const Color(0xFF5a7b8a).withAlpha(80)
        ..strokeWidth = (i % 90 == 0) ? 2 : 1;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
    }
  }

  void _drawCardinalLabels(Canvas canvas, Offset center, double radius) {
    double labelRadius = radius - 30;

    List<_CardinalLabel> labels = [
      _CardinalLabel("U", 0, const Color(0xFFE53935)),
      _CardinalLabel("S", 180, Colors.white70),
      _CardinalLabel("B", 90, Colors.white70),
      _CardinalLabel("T", 270, Colors.white70),
    ];

    for (var label in labels) {
      double rad = (label.angle - 90) * pi / 180;
      double x = center.dx + labelRadius * cos(rad);
      double y = center.dy + labelRadius * sin(rad);

      TextPainter tp = TextPainter(
        text: TextSpan(
          text: label.text,
          style: TextStyle(
            color: label.color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }
  }

  void _drawQiblaIndicator(Canvas canvas, Offset center, double radius) {
    double qiblaRad = (qiblaDirection - 90) * pi / 180;

    double lineLength = radius - 35;
    double x = center.dx + lineLength * cos(qiblaRad);
    double y = center.dy + lineLength * sin(qiblaRad);

    Paint qiblaPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawLine(center, Offset(x, y), qiblaPaint);

    Paint qiblaCircle = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(x, y), 6, qiblaCircle);

    TextPainter tp = TextPainter(
      text: const TextSpan(
        text: "",
        style: TextStyle(
          color: Color(0xFFFFD700),
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    tp.layout();
    tp.paint(
      canvas,
      Offset(
        x - tp.width / 2,
        y - tp.height / 2 - 4,
      ),
    );
  }

  void _drawNorthNeedle(Canvas canvas, Offset center, double radius) {
    double needleLength = radius - 15;

    Paint northPaint = Paint()
      ..color = const Color(0xFFE53935)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      center,
      Offset(center.dx, center.dy - needleLength),
      northPaint,
    );

    Paint northFill = Paint()
      ..color = const Color(0xFFE53935)
      ..style = PaintingStyle.fill;

    Path trianglePath = Path()
      ..moveTo(center.dx, center.dy - needleLength - 12)
      ..lineTo(center.dx - 8, center.dy - needleLength + 2)
      ..lineTo(center.dx + 8, center.dy - needleLength + 2)
      ..close();

    canvas.drawPath(trianglePath, northFill);
  }

  void _drawCenterCircle(Canvas canvas, Offset center) {
    Paint centerPaint = Paint()
      ..color = const Color(0xFF2dc8b9)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 6, centerPaint);

    Paint centerBorder = Paint()
      ..color = Colors.white.withAlpha(80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(center, 10, centerBorder);
  }

  @override
  bool shouldRepaint(covariant _CompassPainter oldDelegate) {
    return oldDelegate.heading != heading ||
        oldDelegate.qiblaDirection != qiblaDirection;
  }
}

class _CardinalLabel {
  final String text;
  final double angle;
  final Color color;

  _CardinalLabel(this.text, this.angle, this.color);
}
