
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:alquran_new/development/masjid_terdekat/domain/entities/masjid.dart';

part 'masjid_model.freezed.dart';

@freezed
abstract class MasjidModel with _$MasjidModel {
  const MasjidModel._();

  const factory MasjidModel({
    @Default('') String id,
    @Default('Tanpa nama') String name,
    @Default('Alamat tidak tersedia') String address,
    @Default(0.0) double longitude,
    @Default(0.0) double latitude,
    double? rating,
  }) = _MasjidModel;

  factory MasjidModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map?;

    final displayName = json['displayName'] as Map?;

    return MasjidModel(
      id: json['id']?.toString() ?? '',
      name: displayName?['text']?.toString() ?? 'Tanpa nama',
      address: json['formattedAddress']?.toString() ??
          'Alamat tidak tersedia',
      latitude: (location?['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (location?['longitude'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  factory MasjidModel.fromEntity(Masjid masjid) {
    return MasjidModel(
      id: masjid.id,
      name: masjid.name,
      address: masjid.address,
      latitude: masjid.latitude,
      longitude: masjid.longitude,
      rating: masjid.rating,
    );
  }

  Masjid toEntity() {
    return Masjid(
      id: id,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      rating: rating,
    );
  }
}
