typedef StudentID = String;

class Student {
  final StudentID? id;
  final String firstName;
  final String lastName;
  final String job;
  final int year;
  final String title;
  final String login;
  final int deposit;

  const Student({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.job,
    required this.login,
    required this.year,
    required this.title,
    required this.deposit,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      job: json['job'],
      login: json['login'],
      year: json['year'],
      title: json['title'],
      deposit: json['deposit'],
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'job': job,
    'login': login,
    'year': year,
    'title': title,
    'deposit': deposit,
  };

  @override
  String toString() {
    return 'Student{id: $id, firstName: $firstName, lastName: $lastName, job: $job, login: $login, year: $year, title: $title, deposit: $deposit}';
  }

  Student copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? job,
    String? title,
    String? login,
    int? year,
    int? deposit,
  }) {
    return Student(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      job: job ?? this.job,
      login: login ?? this.login,
      year: year ?? this.year,
      title: title ?? this.title,
      deposit: deposit ?? this.deposit,
    );
  }
}
