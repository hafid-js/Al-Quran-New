import 'package:alquran_new/development/masjid_terdekat/domain/entities/masjid.dart';

class MasjidModel extends Masjid {
  const MasjidModel({
    required super.id,
    required super.name,
    required super.address,
    required super.latitude,
    required super.longitude,
    super.rating,
  });

  factory MasjidModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>?;
    final lat = location?['latitude'] ?? 0.0;
    final lng = location?['longitude'] ?? 0.0;

    final displayName = json['displayName'] as Map<String, dynamic>?;
    final name = displayName?['text'] ?? 'Masjid Tanpa Nama';

    return MasjidModel(
      id: json['id'] as String? ?? '',
      name: name,
      address: json['formattedAddress'] as String? ?? 'Alamat tidak tersedia',
      latitude: (lat as num).toDouble(),
      longitude: (lng as num).toDouble(),

      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
    );
  }
}
