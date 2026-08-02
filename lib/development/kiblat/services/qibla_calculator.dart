import 'dart:math';

class QiblaCalculator {
  static const double kaabaLat = 21.4225;
  static const double kaabaLng = 39.8262;

  static double calculateDirection(double userLat, double userLng) {
    final double latRad = userLat * pi / 180;
    final double kaabaLatRad = kaabaLat * pi / 180;
    final double deltaLng = (kaabaLng - userLng) * pi / 180;

    final double y = sin(deltaLng);
    final double x = cos(latRad) * tan(kaabaLatRad) - sin(latRad) * cos(deltaLng);

    double qibla = atan2(y, x) * 180 / pi;
    return (qibla + 360) % 360;
  }

  static double calculateDistance(double userLat, double userLng) {
    final double latRad = userLat * pi / 180;
    final double kaabaLatRad = kaabaLat * pi / 180;
    final double deltaLat = kaabaLatRad - latRad;
    final double deltaLng = (kaabaLng - userLng) * pi / 180;

    final double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(latRad) * cos(kaabaLatRad) * sin(deltaLng / 2) * sin(deltaLng / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return 6371 * c;
  }

  static String getDirectionName(double degrees) {
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
