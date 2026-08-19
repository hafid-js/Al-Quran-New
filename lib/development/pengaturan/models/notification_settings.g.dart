// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationSettingsAdapter extends TypeAdapter<NotificationSettings> {
  @override
  final int typeId = 7;

  @override
  NotificationSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationSettings(
      notificationMode: fields[0] as int,
      soundType: fields[1] as String,
      imsakEnabled: fields[2] as bool,
      subuhEnabled: fields[3] as bool,
      dzuhurEnabled: fields[4] as bool,
      asharEnabled: fields[5] as bool,
      maghribEnabled: fields[6] as bool,
      isyaEnabled: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationSettings obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.notificationMode)
      ..writeByte(1)
      ..write(obj.soundType)
      ..writeByte(2)
      ..write(obj.imsakEnabled)
      ..writeByte(3)
      ..write(obj.subuhEnabled)
      ..writeByte(4)
      ..write(obj.dzuhurEnabled)
      ..writeByte(5)
      ..write(obj.asharEnabled)
      ..writeByte(6)
      ..write(obj.maghribEnabled)
      ..writeByte(7)
      ..write(obj.isyaEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
