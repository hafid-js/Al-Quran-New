class Masjid {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final double? rating;

  const Masjid({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.rating,
  });
}
