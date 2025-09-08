import 'package:uuid/uuid.dart';

class Student {
  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.lockerId,
    required this.job,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String lockerId;
  final String job;

  factory Student.fromExcel(List<String> rowData) {
    String safeGet(int index) {
      return (index < rowData.length) ? rowData[index] : '';
    }

    return Student(
      id: uuid.v8(),
      lastName: safeGet(4),
      firstName: safeGet(5),
      lockerId: safeGet(1),
      job: safeGet(3),
    );
  }
}

final uuid = Uuid();
