// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doa_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoaCacheAdapter extends TypeAdapter<DoaCache> {
  @override
  final int typeId = 5;

  @override
  DoaCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoaCache()
      ..doaId = fields[0] as int
      ..grup = fields[1] as String
      ..nama = fields[2] as String
      ..ar = fields[3] as String
      ..tr = fields[4] as String
      ..idn = fields[5] as String
      ..tentang = fields[6] as String
      ..tagJson = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, DoaCache obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.doaId)
      ..writeByte(1)
      ..write(obj.grup)
      ..writeByte(2)
      ..write(obj.nama)
      ..writeByte(3)
      ..write(obj.ar)
      ..writeByte(4)
      ..write(obj.tr)
      ..writeByte(5)
      ..write(obj.idn)
      ..writeByte(6)
      ..write(obj.tentang)
      ..writeByte(7)
      ..write(obj.tagJson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoaCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
