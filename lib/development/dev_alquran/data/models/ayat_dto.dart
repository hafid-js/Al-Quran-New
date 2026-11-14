import 'package:alquran_new/development/dev_alquran/domain/entities/ayat.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ayat_dto.freezed.dart';
part 'ayat_dto.g.dart';

@freezed
abstract class AyatDto with _$AyatDto {
  const factory AyatDto({
    @Default(0) int nomorAyat,
    @Default('') String teksArab,
    @Default('') String teksLatin,
    @Default('') String teksIndonesia,
    @Default(<String, String>{}) Map<String, String> audio,
  }) = _AyatDto;

  factory AyatDto.fromJson(Map<String, dynamic> json) =>
      _$AyatDtoFromJson(json);
}

extension AyatDtoX on AyatDto {
  Ayat toEntity() {
    return Ayat(
      nomorAyat: nomorAyat,
      teksArab: teksArab,
      teksLatin: teksLatin,
      teksIndonesia: teksIndonesia,
      audio: audio,
    );
  }
}
