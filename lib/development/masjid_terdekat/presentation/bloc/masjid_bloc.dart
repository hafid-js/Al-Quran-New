import 'package:alquran_new/development/masjid_terdekat/domain/usecases/get_masjids_terdekat.dart';
import 'package:alquran_new/development/masjid_terdekat/presentation/bloc/masjid_event.dart';
import 'package:alquran_new/development/masjid_terdekat/presentation/bloc/masjid_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class MasjidBloc extends Bloc<MasjidEvent, MasjidState> {
  final GetMasjidsTerdekat getMasjidsTerdekat;

  int _requestId = 0;

  MasjidBloc({required this.getMasjidsTerdekat})
    : super(const MasjidState.initial()) {
    on<FetchMasjidEvent>((event, emit) async {
      final requestId = ++_requestId;
      emit(const MasjidState.loading());
      try {
        final position = Position(
          longitude: event.lng,
          latitude: event.lat,
          timestamp: DateTime.now(),
          accuracy: 1.0,
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          headingAccuracy: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
        );

        final masjids = await getMasjidsTerdekat(
          event.lat,
          event.lng,
          event.radius,
        );
        if (isClosed || requestId != _requestId) return;
        emit(MasjidState.loaded(masjids: masjids, userPosition: position));
      } catch (e) {
        if (isClosed || requestId != _requestId) return;
        emit(MasjidState.error(message: _cleanErrorMessage(e)));
      }
    });
  }

  String _cleanErrorMessage(Object error) {
    final message = error.toString();
    return message.startsWith('Exception: ')
        ? message.replaceFirst('Exception: ', '')
        : message;
  }
}
