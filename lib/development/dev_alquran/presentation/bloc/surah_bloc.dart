import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_alquran/domain/usecases/get_all_surah.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/surah_event.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/surah_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final GetAllSurah _getAllSurah;

  int _requestId = 0;

  SurahBloc({required GetAllSurah getAllSurah})
    : _getAllSurah = getAllSurah,
      super(const SurahState.initial()) {
    on<FetchSurahList>(_onFetch);
    on<RefreshSurahList>(_onRefresh);
  }

  Future<void> _onFetch(FetchSurahList event, Emitter<SurahState> emit) async {
    final requestId = ++_requestId;

    emit(const SurahState.loading());
    await _load(requestId, emit);
  }

  Future<void> _onRefresh(
    RefreshSurahList event,
    Emitter<SurahState> emit,
  ) async {
    final requestId = ++_requestId;
    final current = state;

    if (current is SurahLoaded) {
      emit(SurahState.refreshing(surahs: current.surahs));
    } else {
      emit(const SurahState.loading());
    }

    await _load(requestId, emit);
  }

  Future<void> _load(int requestId, Emitter<SurahState> emit) async {
    final result = await _getAllSurah();

    if (isClosed || requestId != _requestId) return;

    result.when(
      success: (surahs) => emit(SurahState.loaded(surahs: surahs)),
      failure: (message, _) => emit(SurahState.failure(message: message)),
    );
  }
}
