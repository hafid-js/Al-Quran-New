import 'package:alquran_new/development/masjid_terdekat/domain/entities/masjid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'masjid_state.freezed.dart';

@freezed
sealed class MasjidState with _$MasjidState {
  const factory MasjidState.initial() = MasjidInitial;

  const factory MasjidState.loading() = MasjidLoading;

  const factory MasjidState.loaded({
    required List<Masjid> masjids,
    required Position userPosition
  }) = MasjidLoaded;

  const factory MasjidState.error({
    required String message,
  }) = MasjidError;
}