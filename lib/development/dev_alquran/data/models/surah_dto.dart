import 'package:alquran_new/development/dev_alquran/data/models/tempat_turun_mapper.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah_dto.freezed.dart';
part 'surah_dto.g.dart';

@freezed
abstract class SurahDto with _$SurahDto {
  const factory SurahDto({
    @Default(0) int nomor,
    @Default('') String nama,
    @Default('') String namaLatin,
    @Default(0) int jumlahAyat,
    @Default('') String tempatTurun,
    @Default('') String arti,
    @Default('') String deskripsi,
    @Default(<String, String>{}) Map<String, String> audioFull,
  }) = _SurahDto;

  factory SurahDto.fromJson(Map<String, dynamic> json) =>
      _$SurahDtoFromJson(json);
}

extension SurahDtoX on SurahDto {
  Surah toEntity() {
    return Surah(
      nomor: nomor,
      nama: nama,
      namaLatin: namaLatin,
      jumlahAyat: jumlahAyat,
      tempatTurun: tempatTurunFromString(tempatTurun),
      arti: arti,
      deskripsi: deskripsi,
      audioFull: audioFull,
    );
  }
}
