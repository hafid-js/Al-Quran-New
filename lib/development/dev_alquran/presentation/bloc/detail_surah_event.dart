import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_surah_event.freezed.dart';

@freezed
sealed class DetailSurahEvent with _$DetailSurahEvent {
  const factory DetailSurahEvent.fetch({
    required int nomor
  }) = FetchDetailSurah;
}