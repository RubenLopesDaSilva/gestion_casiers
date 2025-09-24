import 'package:gestion_casiers/src/features/lockers/domain/locker_condition.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:hive_flutter/adapters.dart';

part 'locker.g.dart';

@HiveType(typeId: 0)
class Locker {
  @HiveField(0)
  final int number;
  @HiveField(1)
  final String floor;
  @HiveField(2)
  final int deposit;
  @HiveField(3)
  final int keyCount;
  @HiveField(4)
  final int lockNumber;
  @HiveField(5)
  final String responsable;
  @HiveField(6)
  final LockerCondition lockerCondition;
  @HiveField(7)
  final StudentID? studentId;
  @HiveField(8)
  final String place;
  @HiveField(9)
  final String id;

  const Locker({
    required this.number,
    required this.floor,
    required this.deposit,
    required this.keyCount,
    required this.lockNumber,
    required this.responsable,
    required this.lockerCondition,
    required this.place,
    required this.id,
    this.studentId,
  });

  Locker copyWith({
    String? floor,
    int? number,
    String? responsable,
    StudentID? studentId,
    int? deposit,
    int? keyCount,
    int? lockNumber,
    LockerCondition? lockerCondition,
    String? place,
    String? id,
  }) {
    return Locker(
      floor: floor ?? this.floor,
      number: number ?? this.number,
      responsable: responsable ?? this.responsable,
      studentId: studentId ?? this.studentId,
      deposit: deposit ?? this.deposit,
      keyCount: keyCount ?? this.keyCount,
      lockNumber: lockNumber ?? this.lockNumber,
      lockerCondition: lockerCondition ?? this.lockerCondition,
      place: place ?? this.place,
      id: id ?? this.id,
    );
  }
}
