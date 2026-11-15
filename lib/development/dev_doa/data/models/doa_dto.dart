import 'package:alquran_new/development/dev_doa/domain/entities/doa.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'doa_dto.freezed.dart';
part 'doa_dto.g.dart';

@freezed
abstract class DoaDto with _$DoaDto {
  const factory DoaDto({
    @Default(0) int id,
    @Default('') String grup,
    @Default('') String nama,
    @Default('') String ar,
    @Default('') String tr,
    @Default('') String idn,
    @Default('') String tentang,
    @Default([]) List<String> tag,
  }) = _DoaDto;

  factory DoaDto.fromJson(Map<String, dynamic> json) => _$DoaDtoFromJson(json);
}

extension DoaDtoX on DoaDto {
  Doa toEntity() {
    return Doa(
      id: id,
      grup: grup,
      nama: nama,
      ar: ar,
      tr: tr,
      idn: idn,
      tentang: tentang,
      tag: tag
    );
  }
}