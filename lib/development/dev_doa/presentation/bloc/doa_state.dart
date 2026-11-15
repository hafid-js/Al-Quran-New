import 'package:alquran_new/development/dev_doa/domain/entities/doa.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'doa_state.freezed.dart';

@freezed
sealed class DoaState with _$DoaState {
  const factory DoaState.initial() = DoaInitial;

  const factory DoaState.loading() = DoaLoading;

  const factory DoaState.refreshing({required List<Doa> doas}) = DoaRefreshing;

  const factory DoaState.loaded({required List<Doa> doas}) = DoaLoaded;

  const factory DoaState.failure({required String message}) = DoaFailure;
}
