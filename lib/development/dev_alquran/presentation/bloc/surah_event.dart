import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah_event.freezed.dart';

@freezed
sealed class SurahEvent with _$SurahEvent {
  const factory SurahEvent.fetch() = FetchSurahList;

  const factory SurahEvent.refresh() = RefreshSurahList;
}