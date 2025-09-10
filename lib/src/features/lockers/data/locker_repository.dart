import 'package:flutter/material.dart';
import 'package:projet_excel/src/features/lockers/domain/domain.dart';

class LockerProvider with ChangeNotifier {
  static final _lockers = <Locker>[];
  static final _students = <Student>[];

  static List<Locker> get lockers => [..._lockers];
  static List<Student> get students => [..._students];

  final _transactions = <Transaction>[];

  //Transaction
  void saveTransactions(TransactionType type, int lockerId, Locker value) {
    _transactions.add(Transaction(type, lockerId, value));

    if (_transactions.length > 5) {
      _transactions.removeAt(0);
    }
  }

  void restoreLastTransaction() {
    if (_transactions.isEmpty) return;

    final transaction = _transactions.last;

    final locker = _lockers.firstWhere(
      (locker) => locker.number == transaction.lockerId,
    );

    switch (transaction.type) {
      case TransactionType.add:
        _lockers.remove(transaction.value);
        break;
      case TransactionType.remove:
        _lockers.add(transaction.value);
        break;
      case TransactionType.edit:
        _lockers[_lockers.indexOf(locker)] = transaction.value;
        break;
    }

    _transactions.removeLast();
  }

  //Locker
  void setLockers(List<Locker> lockers) {
    _lockers.clear();
    _lockers.addAll(lockers);
    notifyListeners();
  }

  void addLocker(Locker locker) {
    _lockers.add(locker);

    saveTransactions(TransactionType.add, locker.number, locker);
    notifyListeners();
  }

  void removeLocker(Locker locker) {
    _lockers.removeWhere((lockerValue) => lockerValue.number == locker.number);

    saveTransactions(TransactionType.remove, locker.number, locker);
    notifyListeners();
  }

  void editLocker(int lockerNumber, Locker editLocker) {
    _lockers[_lockers.indexWhere((locker) => locker.number == lockerNumber)] =
        editLocker;

    saveTransactions(TransactionType.edit, lockerNumber, editLocker);
    notifyListeners();
  }

  //Student
  void setStudents(List<Student> students) {
    _students.clear();

    for (Student student in students) {
      _students.add(student);
    }

    notifyListeners();
  }

  void addStudent(Student student) {
    _students.add(student);
    notifyListeners();
  }

  void removeStudent(String id) {
    final studentIndex = _students.indexWhere((student) => student.id == id);

    _students.removeAt(studentIndex);
    notifyListeners();
  }

  void editStudent(String id, Student editedStudent) {
    final studentIndex = _students.indexWhere((student) => student.id == id);
    _students[studentIndex] = editedStudent;
    notifyListeners();
  }
}
