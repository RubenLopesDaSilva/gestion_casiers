import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/features/lockers/domain/domain.dart';

class LockerRepository {
  final List<Locker> _lockers = [];
  final List<Student> _students = [];
  final List<Transaction> _transactions = [];

  List<Student> get students => [..._students];
  List<Locker> get lockers => [..._lockers];

  //Transaction
  void saveTransactions(TransactionType type, int lockerId, Locker value) {
    _transactions.add(Transaction(type, lockerId, value));

    if (_transactions.length > 10) {
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
        _lockers.add(transaction.value);
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
  }

  void addLocker(Locker locker) {
    _lockers.add(locker);

    saveTransactions(TransactionType.add, locker.number, locker);
  }

  void removeLocker(Locker locker) {
    _lockers.removeWhere((lockerValue) => lockerValue.number == locker.number);

    saveTransactions(TransactionType.remove, locker.number, locker);
  }

  void editLocker(int lockerNumber, Locker editLocker) {
    _lockers[_lockers.indexWhere((locker) => locker.number == lockerNumber)] =
        editLocker;

    saveTransactions(TransactionType.edit, lockerNumber, editLocker);
  }

  //Student
  void setStudents(List<Student> students) {
    _students.clear();

    for (Student student in students) {
      _students.add(student);
    }
  }

  void addStudent(Student student) {
    _students.add(student);
  }

  void removeStudent(String id) {
    final studentIndex = _students.indexWhere((student) => student.id == id);

    _students.removeAt(studentIndex);
  }

  void editStudent(String id, Student editedStudent) {
    final studentIndex = _students.indexWhere((student) => student.id == id);
    _students[studentIndex] = editedStudent;
  }

  Student? findStudentBy({required StudentID? id}) {
    return id == null
        ? null
        : _students.firstWhere((student) => student.id == id);
  }
}

final lockersRepositoryProvider = Provider<LockerRepository>((ref) {
  return LockerRepository();
});
