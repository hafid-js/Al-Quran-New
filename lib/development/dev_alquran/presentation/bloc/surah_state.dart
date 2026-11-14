import 'package:alquran_new/development/dev_alquran/domain/entities/surah.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah_state.freezed.dart';

@freezed
sealed class SurahState with _$SurahState {
  const factory SurahState.initial() = SurahInitial;

  const factory SurahState.loading() = SurahLoading;

  const factory SurahState.refreshing({required List<Surah> surahs}) =
      SurahRefreshing;

  const factory SurahState.loaded({required List<Surah> surahs}) = SurahLoaded;

  const factory SurahState.failure({required String message}) = SurahFailure;
}