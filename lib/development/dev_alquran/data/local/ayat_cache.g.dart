// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayat_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AyatCacheAdapter extends TypeAdapter<AyatCache> {
  @override
  final typeId = 21;

  @override
  AyatCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AyatCache()
      ..surahNomor = (fields[0] as num).toInt()
      ..nomorAyat = (fields[1] as num).toInt()
      ..teksArab = fields[2] as String
      ..teksLatin = fields[3] as String
      ..teksIndonesia = fields[4] as String
      ..audioJson = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, AyatCache obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.surahNomor)
      ..writeByte(1)
      ..write(obj.nomorAyat)
      ..writeByte(2)
      ..write(obj.teksArab)
      ..writeByte(3)
      ..write(obj.teksLatin)
      ..writeByte(4)
      ..write(obj.teksIndonesia)
      ..writeByte(5)
      ..write(obj.audioJson);
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
