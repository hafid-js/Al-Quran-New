// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayat_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AyatCacheAdapter extends TypeAdapter<AyatCache> {
  @override
  final int typeId = 3;

  @override
  AyatCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AyatCache()
      ..nomorAyat = fields[0] as int
      ..teksArab = fields[1] as String
      ..teksLatin = fields[2] as String
      ..teksIndonesia = fields[3] as String
      ..audioJson = fields[4] as String
      ..surahNomor = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, AyatCache obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nomorAyat)
      ..writeByte(1)
      ..write(obj.teksArab)
      ..writeByte(2)
      ..write(obj.teksLatin)
      ..writeByte(3)
      ..write(obj.teksIndonesia)
      ..writeByte(4)
      ..write(obj.audioJson)
      ..writeByte(5)
      ..write(obj.surahNomor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AyatCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
