// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_time_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrayerTimeCacheAdapter extends TypeAdapter<PrayerTimeCache> {
  @override
  final int typeId = 8;

  @override
  PrayerTimeCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrayerTimeCache()
      ..day = fields[0] as int
      ..tanggalLengkap = fields[1] as String
      ..hari = fields[2] as String
      ..imsak = fields[3] as String
      ..subuh = fields[4] as String
      ..terbit = fields[5] as String
      ..dhuha = fields[6] as String
      ..dzuhur = fields[7] as String
      ..ashar = fields[8] as String
      ..maghrib = fields[9] as String
      ..isya = fields[10] as String
      ..province = fields[11] as String?
      ..city = fields[12] as String?;
  }

  @override
  void write(BinaryWriter writer, PrayerTimeCache obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.tanggalLengkap)
      ..writeByte(2)
      ..write(obj.hari)
      ..writeByte(3)
      ..write(obj.imsak)
      ..writeByte(4)
      ..write(obj.subuh)
      ..writeByte(5)
      ..write(obj.terbit)
      ..writeByte(6)
      ..write(obj.dhuha)
      ..writeByte(7)
      ..write(obj.dzuhur)
      ..writeByte(8)
      ..write(obj.ashar)
      ..writeByte(9)
      ..write(obj.maghrib)
      ..writeByte(10)
      ..write(obj.isya)
      ..writeByte(11)
      ..write(obj.province)
      ..writeByte(12)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerTimeCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
