// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hizb_ayat_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HizbAyatCacheAdapter extends TypeAdapter<HizbAyatCache> {
  @override
  final int typeId = 10;

  @override
  HizbAyatCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HizbAyatCache()
      ..hizbNumber = fields[0] as int
      ..ayatJson = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, HizbAyatCache obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hizbNumber)
      ..writeByte(1)
      ..write(obj.ayatJson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HizbAyatCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
