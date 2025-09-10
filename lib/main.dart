import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:projet_excel/src/app.dart';
import 'package:projet_excel/src/features/lockers/domain/domain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(LockerAdapter());
  Hive.registerAdapter(LockerConditionAdapter());
  Hive.registerAdapter(StudentAdapter());

  await Hive.openBox<Locker>('Lockers');
  await Hive.openBox<Student>('Students');

  runApp(const MyApp());
}
