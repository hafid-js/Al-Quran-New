// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AyatDto _$AyatDtoFromJson(Map<String, dynamic> json) => _AyatDto(
  nomorAyat: (json['nomorAyat'] as num?)?.toInt() ?? 0,
  teksArab: json['teksArab'] as String? ?? '',
  teksLatin: json['teksLatin'] as String? ?? '',
  teksIndonesia: json['teksIndonesia'] as String? ?? '',
  audio:
      (json['audio'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
);

Map<String, dynamic> _$AyatDtoToJson(_AyatDto instance) => <String, dynamic>{
  'nomorAyat': instance.nomorAyat,
  'teksArab': instance.teksArab,
  'teksLatin': instance.teksLatin,
  'teksIndonesia': instance.teksIndonesia,
  'audio': instance.audio,
};
