import 'package:hive_flutter/adapters.dart';
import 'package:projet_excel/src/features/lockers/domain/locker_condition.dart';
import 'package:projet_excel/src/features/lockers/domain/student.dart';

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
  final Student? student;

  const Locker({
    required this.number,
    required this.floor,
    required this.deposit,
    required this.keyCount,
    required this.lockNumber,
    required this.responsable,
    required this.lockerCondition,
    this.student,
  });

  Locker copyWith({
    String? floor,
    int? number,
    String? responsable,
    Student? student,
    int? deposit,
    int? keyCount,
    int? lockNumber,
    LockerCondition? lockerCondition,
  }) {
    return Locker(
      floor: floor ?? this.floor,
      number: number ?? this.number,
      responsable: responsable ?? this.responsable,
      student: student ?? this.student,
      deposit: deposit ?? this.deposit,
      keyCount: keyCount ?? this.keyCount,
      lockNumber: lockNumber ?? this.lockNumber,
      lockerCondition: lockerCondition ?? this.lockerCondition,
    );
  }
}
