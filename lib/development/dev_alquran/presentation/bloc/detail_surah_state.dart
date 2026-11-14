import 'package:alquran_new/development/dev_alquran/domain/entities/surah_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'detail_surah_state.freezed.dart';

@freezed
sealed class DetailSurahState with _$DetailSurahState {
  const factory DetailSurahState.initial() = DetailSurahInitial;

  const factory DetailSurahState.loading() = DetailSurahLoading;

  const factory DetailSurahState.loaded({
    required SurahDetail detail
  }) = DetailSurahLoaded;

  const factory DetailSurahState.failure({
    required String message
  }) = DetailSurahFailure;
}