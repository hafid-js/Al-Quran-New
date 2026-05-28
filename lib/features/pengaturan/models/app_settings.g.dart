// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 1;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings()
      ..qariSelected = fields[0] as int
      ..fontSelected = fields[1] as int
      ..modeSelected = fields[2] as int
      ..colorSelected = fields[3] as int
      ..customColor = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.qariSelected)
      ..writeByte(1)
      ..write(obj.fontSelected)
      ..writeByte(2)
      ..write(obj.modeSelected)
      ..writeByte(3)
      ..write(obj.colorSelected)
      ..writeByte(4)
      ..write(obj.customColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
