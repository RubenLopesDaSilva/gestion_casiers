import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:hive/hive.dart';

class StudentRepository extends Notifier<List<Student>> {
  static final Box<Student> studentsBox = Hive.box('students');
  List<Student> students = [];

  void setStudents(List<Student> students) {
    studentsBox.deleteAll(studentsBox.keys);

    for (Student student in students) {
      studentsBox.put(student.id, student);
    }
  }

  List<Student> fetchStudents() {
    if (students.length < studentsBox.length) {
      for (int i = 0; i < studentsBox.length; i++) {
        final Student? student = studentsBox.getAt(i);

        if (student != null) {
          students.add(student);
        }
      }
    }

    return List.from(students);
  }

  void addStudent(Student student) {
    studentsBox.put(student.id, student);
  }

  void removeStudent(String id) {
    studentsBox.delete(id);
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

  List<Student> getStudentsFrom(int year) {
    return fetchStudents().where((student) => student.year == year).toList();
  }

  List<Student> searchStudents({String? value}) {
    if (value case String name) {
      if (name == '') return [];
      name = name.toLowerCase();
      return fetchStudents().where((student) {
        final firstName = student.firstName.toLowerCase();
        final lastName = student.lastName.toLowerCase();
        return firstName.contains(name) ||
            name.contains(firstName) ||
            lastName.toLowerCase().contains(name) ||
            name.contains(lastName);
      }).toList();
    }
    return [];
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
