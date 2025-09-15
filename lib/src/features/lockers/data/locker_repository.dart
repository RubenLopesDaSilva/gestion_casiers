import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/features/lockers/domain/domain.dart';
import 'package:hive_flutter/adapters.dart';

class LockerRepository {
  final Box<Locker> lockersBox = Hive.box('lockers');
  final Box<Student> studentsBox = Hive.box('Students');
  final Box<Transaction> transactionsBox = Hive.box('Transactions');

  //Transaction
  void saveTransactions(TransactionType type, int lockerId, Locker value) {
    transactionsBox.add(Transaction(type, lockerId, value));

    if (transactionsBox.length > 10) {
      transactionsBox.deleteAt(0);
    }
  }

  void restoreLastTransaction() {
    if (transactionsBox.isEmpty) return;

    final transaction = transactionsBox.get(-1);

    final locker = lockersBox.get(
      (locker) => locker.number == transaction!.lockerId,
    );

    switch (transaction!.type) {
      case TransactionType.add:
        lockersBox.delete(transaction.value);
        break;
      case TransactionType.remove:
        lockersBox.put(locker!.number, transaction.value);
        break;
      case TransactionType.edit:
        lockersBox.put(locker!.number, transaction.value);
        break;
    }

    transactionsBox.deleteAt(-1);
  }

  //Locker
  void setLockers(List<Locker> lockers) {
    lockersBox.deleteAll(lockersBox.keys);

    for (Locker locker in lockers) {
      lockersBox.put(locker.number, locker);
    }
  }

  void addLocker(Locker locker) {
    lockersBox.put(locker.number, locker);

    saveTransactions(TransactionType.add, locker.number, locker);
  }

  void removeLocker(Locker locker) {
    lockersBox.deleteAt(locker.number);

    saveTransactions(TransactionType.remove, locker.number, locker);
  }

  void editLocker(int lockerNumber, Locker editLocker) {
    lockersBox.putAt(lockerNumber, editLocker);

    saveTransactions(TransactionType.edit, lockerNumber, editLocker);
  }

  //Student
  void setStudents(List<Student> students) {
    studentsBox.deleteAll(studentsBox.keys);

    for (Student student in students) {
      studentsBox.put(student.id, student);
    }
  }

  void addStudent(Student student) {
    studentsBox.put(student.id, student);
  }

  void removeStudent(String id) {
    final studentIndex = studentsBox.keys.firstWhere(
      (student) => student.id == id,
    );

    studentsBox.deleteAt(studentIndex);
  }

  void editStudent(String id, Student editedStudent) {
    final studentIndex = studentsBox.keys.firstWhere(
      (student) => student.id == id,
    );
    studentsBox.putAt(studentIndex, editedStudent);
  }


  Student? findStudentBy({required StudentID id}) {
    return (studentsBox.values.firstWhere((student) => student.id == id));
  }
}

final lockersRepositoryProvider = Provider<LockerRepository>((ref) {
  return LockerRepository();
});
