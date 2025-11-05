import 'package:gestion_casiers/src/features/lockers/domain/locker_condition.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';

class Locker {
  final String id;
  final int number;
  final String floor;
  final int keyCount;
  final int lockNumber;
  final String responsable;
  final LockerCondition lockerCondition;
  final StudentID? studentId;
  final String place;

  const Locker({
    required this.id,
    required this.number,
    required this.floor,
    required this.keyCount,
    required this.lockNumber,
    required this.responsable,
    required this.lockerCondition,
    required this.place,
    this.studentId,
  });

  factory Locker.fromJson(Map<String, dynamic> json) {
    return Locker(
      id: json['_id'],
      number: json['number'],
      floor: json['floor'],
      keyCount: json['keyCount'],
      lockNumber: json['lockNumber'],
      studentId: json['studentId'],
      responsable: json['responsable'],
      lockerCondition: LockerCondition.fromJson(json['lockerCondition']),
      place: json['place'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'number': number,
    'floor': floor,
    'place': place,
    'responsable': responsable,
    'studentId': studentId,
    'keyCount': keyCount,
    'lockNumber': lockNumber,
    'lockerCondition': lockerCondition.toJson(),
  };

  @override
  String toString() {
    return 'Locker{id: $id, number:$number, floor:$floor, place:$place, responsable: $responsable, studentId: $studentId, keyCount:$keyCount, lockNumber:$lockNumber, lockerCondition: ${lockerCondition.toString()}';
  }

  Locker copyWith({
    String? id,
    String? floor,
    int? number,
    String? responsable,
    StudentID? studentId,
    int? keyCount,
    int? lockNumber,
    LockerCondition? lockerCondition,
    String? place,
  }) {
    return Locker(
      id: id ?? this.id,
      floor: floor ?? this.floor,
      number: number ?? this.number,
      responsable: responsable ?? this.responsable,
      studentId: studentId ?? this.studentId,
      keyCount: keyCount ?? this.keyCount,
      lockNumber: lockNumber ?? this.lockNumber,
      lockerCondition: lockerCondition ?? this.lockerCondition,
      place: place ?? this.place,
    );
  }
}
