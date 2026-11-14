// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SurahDto _$SurahDtoFromJson(Map<String, dynamic> json) => _SurahDto(
  nomor: (json['nomor'] as num?)?.toInt() ?? 0,
  nama: json['nama'] as String? ?? '',
  namaLatin: json['namaLatin'] as String? ?? '',
  jumlahAyat: (json['jumlahAyat'] as num?)?.toInt() ?? 0,
  tempatTurun: json['tempatTurun'] as String? ?? '',
  arti: json['arti'] as String? ?? '',
  deskripsi: json['deskripsi'] as String? ?? '',
  audioFull:
      (json['audioFull'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
);

Map<String, dynamic> _$SurahDtoToJson(_SurahDto instance) => <String, dynamic>{
  'nomor': instance.nomor,
  'nama': instance.nama,
  'namaLatin': instance.namaLatin,
  'jumlahAyat': instance.jumlahAyat,
  'tempatTurun': instance.tempatTurun,
  'arti': instance.arti,
  'deskripsi': instance.deskripsi,
  'audioFull': instance.audioFull,
};
