import 'package:freezed_annotation/freezed_annotation.dart';

part 'masjid.freezed.dart';

@freezed
abstract class Masjid with _$Masjid {
  const factory Masjid({
    required String id,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    double? rating,
  }) = _Masjid;
}
