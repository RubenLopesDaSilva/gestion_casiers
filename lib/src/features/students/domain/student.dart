import 'package:hive_flutter/adapters.dart';

part 'student.g.dart';

typedef StudentID = String;

@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  final StudentID id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String job;
  @HiveField(4)
  final int year;
  @HiveField(5)
  final String title;
  @HiveField(6)
  final String login;

  const Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.job,
    required this.login,
    required this.year,
    required this.title,
  });

  Student copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? job,
    String? title,
    String? login,
    int? year,
  }) {
    return Student(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      job: job ?? this.job,
      login: login ?? this.login,
      year: year ?? this.year,
      title: title ?? this.title,
    );
  }
}
