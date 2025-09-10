import 'package:hive_flutter/adapters.dart';

part 'student.g.dart';

@HiveType(typeId: 1)
class Student {

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String job;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.job,
  });

  Student copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? job,
  }) {
    return Student(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      job: job ?? this.job,
    );
  }
}
