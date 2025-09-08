import 'package:flutter/material.dart';
import 'package:projet_excel/src/features/excel_import/excel_import_screen.dart';
// import 'package:projet_excel/src/features/hive/hive_screen.dart';
import 'package:projet_excel/src/features/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: primaryTheme,
      home: ExcelImportScreen(),
    );
  }
}
