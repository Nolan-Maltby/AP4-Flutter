// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisiteAdapter extends TypeAdapter<Visite> {
  @override
  final int typeId = 0;

  @override
  Visite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Visite(
      id: fields[0] as int,
      patient: fields[1] as int,
      datePrevue: fields[2] as String,
      duree: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Visite obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.patient)
      ..writeByte(2)
      ..write(obj.datePrevue)
      ..writeByte(3)
      ..write(obj.duree);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisiteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
