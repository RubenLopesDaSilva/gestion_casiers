import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';

enum TransactionType {
  add,
  edit,
  remove,
}

class Transaction {
  const Transaction(this.type, this.lockerId, this.value);

  final TransactionType type;

  final String lockerId;
  final Locker value;

  Transaction copyWith({
    TransactionType? type,
    String? lockerId,
    Locker? value,
  }) {
    return Transaction(
      type ?? this.type,
      lockerId ?? this.lockerId,
      value ?? this.value,
    );
  }
}
