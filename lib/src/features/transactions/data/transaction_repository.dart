import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/transactions/domain/transaction.dart';
import 'package:hive/hive.dart';

class TransactionRepository extends Notifier<List<Transaction>> {
  static final Box<Transaction> transactionsBox = Hive.box('transactions');

  void saveTransactions(TransactionType type, String lockerId, Locker value) {
    transactionsBox.add(Transaction(type, lockerId, value));

    if (transactionsBox.length > 10) {
      transactionsBox.deleteAt(0);
    }
  }

  void restoreLastTransaction() {
    if (transactionsBox.isEmpty) return;

    final transaction = transactionsBox.getAt(-1);

    final locker = LockerRepository.lockersBox.get(
      (locker) => locker.number == transaction!.lockerId,
    );

    switch (transaction!.type) {
      case TransactionType.add:
        LockerRepository.lockersBox.delete(transaction.value);
        break;
      case TransactionType.remove:
        LockerRepository.lockersBox.put(locker!.id, transaction.value);
        break;
      case TransactionType.edit:
        LockerRepository.lockersBox.put(locker!.id, transaction.value);
        break;
    }

    transactionsBox.deleteAt(-1);
  }

  @override
  build() {
    return [];
  }
}

final transactionRepositoryProvider =
    NotifierProvider<TransactionRepository, List<Transaction>>(() {
      return TransactionRepository();
    });
