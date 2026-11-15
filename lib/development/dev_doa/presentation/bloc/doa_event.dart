import 'package:freezed_annotation/freezed_annotation.dart';

part 'doa_event.freezed.dart';


@freezed
sealed class DoaEvent with _$DoaEvent {
  const factory DoaEvent.fetch() = FetchDoaList;

  const factory DoaEvent.refresh() = RefreshDoaList;

}