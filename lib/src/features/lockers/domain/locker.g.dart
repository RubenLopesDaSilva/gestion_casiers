// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LockerAdapter extends TypeAdapter<Locker> {
  @override
  final int typeId = 0;

  @override
  Locker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Locker(
      number: fields[0] as int,
      floor: fields[1] as String,
      keyCount: fields[2] as int,
      lockNumber: fields[3] as int,
      responsable: fields[4] as String,
      lockerCondition: fields[5] as LockerCondition,
      place: fields[7] as String,
      studentId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Locker obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.floor)
      ..writeByte(2)
      ..write(obj.keyCount)
      ..writeByte(3)
      ..write(obj.lockNumber)
      ..writeByte(4)
      ..write(obj.responsable)
      ..writeByte(5)
      ..write(obj.lockerCondition)
      ..writeByte(6)
      ..write(obj.studentId)
      ..writeByte(7)
      ..write(obj.place);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LockerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
