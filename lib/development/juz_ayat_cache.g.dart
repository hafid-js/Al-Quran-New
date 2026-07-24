// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_ayat_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JuzAyatCacheAdapter extends TypeAdapter<JuzAyatCache> {
  @override
  final int typeId = 9;

  @override
  JuzAyatCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JuzAyatCache()
      ..juzNumber = fields[0] as int
      ..ayatJson = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, JuzAyatCache obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.juzNumber)
      ..writeByte(1)
      ..write(obj.ayatJson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JuzAyatCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
