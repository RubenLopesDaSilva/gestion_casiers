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
      deposit: fields[2] as int,
      keyCount: fields[3] as int,
      lockNumber: fields[4] as int,
      responsable: fields[5] as String,
      lockerCondition: fields[6] as LockerCondition,
      place: fields[8] as String,
      studentId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Locker obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.floor)
      ..writeByte(2)
      ..write(obj.deposit)
      ..writeByte(3)
      ..write(obj.keyCount)
      ..writeByte(4)
      ..write(obj.lockNumber)
      ..writeByte(5)
      ..write(obj.responsable)
      ..writeByte(6)
      ..write(obj.lockerCondition)
      ..writeByte(7)
      ..write(obj.studentId)
      ..writeByte(8)
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
