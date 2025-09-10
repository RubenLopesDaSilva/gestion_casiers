import 'package:flutter/material.dart';
import 'package:projet_excel/src/features/lockers/domain/locker.dart';
import 'package:projet_excel/src/features/lockers/domain/student.dart';

class LockerProvider with ChangeNotifier {
  final _lockers = <Locker>[];
  final _students = <Student>[];

  List<Locker> get lockers => [..._lockers];
  List<Student> get students => [..._students];

  //Locker
  void setLockers(List<Locker> lockers) {
    _lockers.clear();
    _lockers.addAll(lockers);
    notifyListeners();
  }

  void addLocker(Locker locker) {
    _lockers.add(locker);
    notifyListeners();
  }

  void removeLocker(Locker locker) {
    _lockers.removeWhere((lockerValue) => lockerValue.number == locker.number);
    notifyListeners();
  }

  void editLocker(int lockerNumber, Locker editLocker) {
    _lockers[_lockers.indexWhere((locker) => locker.number == lockerNumber)] =
        editLocker;
    notifyListeners();
  }

  //Student
  void setStudents() {
    _students.clear();

    for (Locker locker in _lockers) {
      if (locker.student != null) {
        _students.add(locker.student!);
      }
    }
    notifyListeners();
  }

  void addStudent(Student student) {
    _students.add(student);
    notifyListeners();
  }

  void removeStudent(String id) {
    final studentIndex = _students.indexWhere(
      (student) => student.id == id,
    );

    _students.removeAt(studentIndex);
    notifyListeners();
  }

  void editStudent(String id,Student editedStudent) {
    final studentIndex = _students.indexWhere(
      (student) => student.id == id,
    );
    _students[studentIndex] = editedStudent;
    notifyListeners();
  }
}
