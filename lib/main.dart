import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/app.dart';
import 'package:gestion_casiers/src/features/lockers/domain/domain.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(LockerAdapter());
  Hive.registerAdapter(LockerConditionAdapter());
  Hive.registerAdapter(StudentAdapter());

  await Hive.openBox<Locker>('Lockers');
  await Hive.openBox<Student>('Students');
  await Hive.openBox<Transaction>('Transactions');

  runApp(const ProviderScope(child: MyApp()));
}
