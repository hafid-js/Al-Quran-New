// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doa_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DoaDto _$DoaDtoFromJson(Map<String, dynamic> json) => _DoaDto(
  id: (json['id'] as num?)?.toInt() ?? 0,
  grup: json['grup'] as String? ?? '',
  nama: json['nama'] as String? ?? '',
  ar: json['ar'] as String? ?? '',
  tr: json['tr'] as String? ?? '',
  idn: json['idn'] as String? ?? '',
  tentang: json['tentang'] as String? ?? '',
  tag:
      (json['tag'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$DoaDtoToJson(_DoaDto instance) => <String, dynamic>{
  'id': instance.id,
  'grup': instance.grup,
  'nama': instance.nama,
  'ar': instance.ar,
  'tr': instance.tr,
  'idn': instance.idn,
  'tentang': instance.tentang,
  'tag': instance.tag,
};
