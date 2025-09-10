import 'package:projet_excel/src/features/lockers/domain/locker_condition.dart';
import 'package:projet_excel/src/features/lockers/domain/student.dart';

class Locker {
  final int number;
  final String floor;
  final int deposit;
  final int keyCount;
  final int lockNumber;
  final String responsable;
  final LockerCondition lockerCondition;
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
