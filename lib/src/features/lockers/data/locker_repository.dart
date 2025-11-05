import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/transactions/data/transaction_repository.dart';
import 'package:gestion_casiers/src/features/transactions/domain/transaction.dart';
import 'package:hive_flutter/adapters.dart';

class LockerRepository extends Notifier<List<Locker>> {
  static final Box<Locker> lockersBox = Hive.box('lockers');
  void setLockers(List<Locker> lockers) {
    lockersBox.deleteAll(lockersBox.keys);

    for (Locker locker in lockers) {
      lockersBox.put(locker.id, locker);
    }
  }

  List<Locker> fetchLockersList() {
    final lockers = <Locker>[];

    for (int i = 0; i > lockersBox.length; i++) {
      final Locker? locker = lockersBox.getAt(i);

      if (locker != null) {
        lockers.add(locker);
      }
    }

    return lockers;
  }

  List<Locker> fetchFreeLockerList() {
    final lockers = <Locker>[];
    for (int i = 0; i < lockersBox.length; i++) {
      Locker? locker = lockersBox.getAt(i);
      if (locker != null && locker.studentId == null) {
        lockers.add(locker);
      }
    }
    return lockers;
  }

  void addLocker(Locker locker) {
    lockersBox.put(locker.id, locker);

    TransactionRepository().saveTransactions(
      TransactionType.add,
      locker.id,
      locker,
    );
  }

  void removeLocker(Locker locker) {
    lockersBox.delete(locker.id);

    TransactionRepository().saveTransactions(
      TransactionType.remove,
      locker.id,
      locker,
    );
  }

  Locker getLockerBy(String id) {
    final Locker locker = lockersBox.values.firstWhere(
      (locker) => locker.id == id,
    );
    return locker;
  }

  void editLocker(String id, Locker editLocker) {
    lockersBox.put(id, editLocker);

    TransactionRepository().saveTransactions(
      TransactionType.edit,
      id,
      editLocker,
    );
  }

  @override
  build() {
    return [];
  }
}

final lockersRepositoryProvider =
    NotifierProvider<LockerRepository, List<Locker>>(() => LockerRepository());
