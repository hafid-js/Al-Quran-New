// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahCacheAdapter extends TypeAdapter<SurahCache> {
  @override
  final int typeId = 2;

  @override
  SurahCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurahCache()
      ..nomor = fields[0] as int
      ..namaLatin = fields[1] as String
      ..nama = fields[2] as String
      ..jumlahAyat = fields[3] as int
      ..tempatTurun = fields[4] as String
      ..arti = fields[5] as String
      ..deskripsi = fields[6] as String
      ..audioUrl = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, SurahCache obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.nomor)
      ..writeByte(1)
      ..write(obj.namaLatin)
      ..writeByte(2)
      ..write(obj.nama)
      ..writeByte(3)
      ..write(obj.jumlahAyat)
      ..writeByte(4)
      ..write(obj.tempatTurun)
      ..writeByte(5)
      ..write(obj.arti)
      ..writeByte(6)
      ..write(obj.deskripsi)
      ..writeByte(7)
      ..write(obj.audioUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
