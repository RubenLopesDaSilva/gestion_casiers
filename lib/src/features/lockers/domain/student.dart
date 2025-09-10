class Student {
  final String id;
  final String firstName;
  final String lastName;
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
