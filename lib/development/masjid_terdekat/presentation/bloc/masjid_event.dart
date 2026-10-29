import 'package:equatable/equatable.dart';

abstract class MasjidEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMasjidEvent extends MasjidEvent {
  final double lat;
  final double lng;
  final int radius;

  FetchMasjidEvent({
    required this.lat,
    required this.lng,
    required this.radius,
  });

  @override
  List<Object?> get props => [lat, lng, radius];
}
