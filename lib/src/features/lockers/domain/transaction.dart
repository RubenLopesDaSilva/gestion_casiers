import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:hive_flutter/adapters.dart';

part 'transaction.g.dart';

enum TransactionType { add, edit, remove }

@HiveType(typeId: 3)
class Transaction {
  const Transaction(this.type, this.lockerId, this.value);

  @HiveField(0)
  final TransactionType type;
  @HiveField(1)
  final int lockerId;
  @HiveField(2)
  final Locker value;

  Transaction copyWith({TransactionType? type, int? lockerId, Locker? value}) {
    return Transaction(
      type ?? this.type,
      lockerId ?? this.lockerId,
      value ?? this.value,
    );
  }
}
