// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationCacheAdapter extends TypeAdapter<LocationCache> {
  @override
  final int typeId = 6;

  @override
  LocationCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationCache()
      ..province = fields[0] as String
      ..city = fields[1] as String
      ..updatedAt = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, LocationCache obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.province)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
