// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tafsir_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TafsirCacheAdapter extends TypeAdapter<TafsirCache> {
  @override
  final int typeId = 4;

  @override
  TafsirCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TafsirCache()
      ..nomorSurah = fields[0] as int
      ..nomorAyat = fields[1] as int
      ..tafsir = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, TafsirCache obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nomorSurah)
      ..writeByte(1)
      ..write(obj.nomorAyat)
      ..writeByte(2)
      ..write(obj.tafsir);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TafsirCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
