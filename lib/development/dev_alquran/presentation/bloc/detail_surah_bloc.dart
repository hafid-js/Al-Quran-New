import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_alquran/domain/usecases/get_detail_surah.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/detail_surah_event.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/detail_surah_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailSurahBloc extends Bloc<DetailSurahEvent, DetailSurahState> {
  final GetDetailSurah _getDetailSurah;

  int _requestId = 0;

  DetailSurahBloc({required GetDetailSurah getDetailSurah})
    : _getDetailSurah = getDetailSurah,
      super(const DetailSurahState.initial()) {
    on<FetchDetailSurah>(_onFetch);
  }

  Future<void> _onFetch(
    FetchDetailSurah event,
    Emitter<DetailSurahState> emit,
  ) async {
    final requestId = ++_requestId;

    emit(const DetailSurahState.loading());

    final result = await _getDetailSurah(event.nomor);

    if (isClosed || requestId != _requestId) return;

    result.when(
      success: (detail) => emit(DetailSurahState.loaded(detail: detail)),
      failure: (message, _) => emit(DetailSurahState.failure(message: message)),
    );
  }
}
