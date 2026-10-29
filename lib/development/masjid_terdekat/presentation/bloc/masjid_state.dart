import 'package:alquran_new/development/masjid_terdekat/domain/entities/masjid.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class MasjidState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MasjidInitial extends MasjidState {}

class MasjidLoading extends MasjidState {}

class MasjidLoaded extends MasjidState {
  final List<Masjid> masjids;
  final Position userPosition;

  MasjidLoaded({required this.masjids, required this.userPosition});

  @override
  List<Object?> get props => [masjids, userPosition];
}

class MasjidError extends MasjidState {
  final String message;
  MasjidError(this.message);

  @override
  List<Object?> get props => [message];
}
