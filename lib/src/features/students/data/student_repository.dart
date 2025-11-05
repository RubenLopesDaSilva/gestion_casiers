import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
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

    for (int i = 0; i < studentsBox.length; i++) {
      final Student? student = studentsBox.getAt(i);
      if (student != null)  students.add(student);
    }
    return students;
  }

  List<Student> fetchStudentNoLockers() {
    final students = <Student>[];

    for (int i = 0; i < studentsBox.length; i++) {
      Student? student = studentsBox.getAt(i);
      if (student != null) {
        if (getLockerBy(student.id!) == null) {
          students.add(student);
        }
      }
    }
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

  Locker? getLockerBy(StudentID id) {
    for (int lockerNumber in LockerRepository.lockersBox.keys) {
      final Locker locker = LockerRepository.lockersBox.get(lockerNumber)!;

      if (locker.studentId == id) {
        return locker;
      }
    }

    return null;
  }

  Student getStudentBy(String id) {
    final Student student = studentsBox.values.firstWhere(
      (student) => student.id == id,
    );
    return student;
  }
}

final studentsRepositoryProvider =
    NotifierProvider<StudentRepository, List<Student>>(() {
      return StudentRepository();
    });
