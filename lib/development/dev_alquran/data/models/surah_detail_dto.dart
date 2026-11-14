import 'package:alquran_new/development/dev_alquran/data/models/ayat_dto.dart';
import 'package:alquran_new/development/dev_alquran/data/models/surah_dto.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah_detail_dto.freezed.dart';


@freezed
abstract class SurahDetailDto with _$SurahDetailDto {
  const factory SurahDetailDto({
    required SurahDto surah,
    @Default(<AyatDto>[]) List<AyatDto> ayat,
  }) = _SurahDetailDto;


  factory SurahDetailDto.fromJson(Map<String, dynamic> json) {
    final rawAyat = json['ayat'];

    return SurahDetailDto(
      surah: SurahDto.fromJson(json),
      ayat: rawAyat is List ? rawAyat.map((e) => AyatDto.fromJson(Map<String, dynamic>.from(e as Map))).toList() : const <AyatDto>[]
    );
  }
}

extension SurahDetailDtoX on SurahDetailDto {
  SurahDetail toEntity() {
    return SurahDetail(
      surah: surah.toEntity(),
      ayat: ayat.map((e) => e.toEntity()).toList()
    );

  }
}