import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/features/lockers/domain/domain.dart';
import 'package:hive/hive.dart';

class StudentRepository extends Notifier<List<Student>> {
  static final Box<Student> studentsBox = Hive.box('students');

  void setStudents(List<Student> students) {
    studentsBox.deleteAll(studentsBox.keys);

    for (Student student in students) {
      studentsBox.put(student.id, student);
    }
  }

  List<Student> fetchStudents() {
    final students = <Student>[];

    return students;
  }

  void addStudent(Student student) {
    studentsBox.put(student.id, student);
  }

  void removeStudent(String id) {
    final studentIndex = studentsBox.keys.firstWhere(
      (studentId) => studentId == id,
      orElse: () => null,
    );

    studentsBox.deleteAt(studentIndex);
  }

  void editStudent(String id, Student editedStudent) {
    final studentIndex = studentsBox.keys.firstWhere(
      (studentId) => studentId == id,
      orElse: () => null,
    );
    studentsBox.put(studentIndex, editedStudent);
  }

  Student? findStudentBy({required StudentID? id}) {
    return id == null
        ? null
        : studentsBox.values.firstWhere((student) => student.id == id);
  }

  @override
  build() {
    return [];
  }
}

final studentsRepositoryProvider =
    NotifierProvider<StudentRepository, List<Student>>(() {
      return StudentRepository();
    });
