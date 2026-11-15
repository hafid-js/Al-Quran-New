import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_doa/domain/usecases/get_all_doa.dart';
import 'package:alquran_new/development/dev_doa/presentation/bloc/doa_event.dart';
import 'package:alquran_new/development/dev_doa/presentation/bloc/doa_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoaBloc extends Bloc<DoaEvent, DoaState> {
  final GetAllDoa _getAllDoa;

  int _requestId = 0;

  DoaBloc({required GetAllDoa getAllDoa})
    : _getAllDoa = getAllDoa,
      super(const DoaState.initial()) {
    on<FetchDoaList>(_onFetch);
    on<RefreshDoaList>(_onRefresh);
  }

  Future<void> _onFetch(FetchDoaList event, Emitter<DoaState> emit) async {
    final requestId = ++_requestId;

    emit(const DoaState.loading());
    await _load(requestId, emit);
  }

  Future<void> _onRefresh(RefreshDoaList event, Emitter<DoaState> emit) async {
    final requestId = ++_requestId;
    final current = state;

    if (current is DoaLoaded) {
      emit(DoaState.refreshing(doas: current.doas));
    } else {
      emit(const DoaState.loading());
    }

    await _load(requestId, emit);
  }

  Future<void> _load(int requestId, Emitter<DoaState> emit) async {
    final result = await _getAllDoa();

    if (isClosed || requestId != _requestId) return;

    result.when(
      success: (doas) => emit(DoaState.loaded(doas: doas)),
      failure: (message, _) => emit(DoaState.failure(message: message)),
    );
  }
}
