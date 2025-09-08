// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle, ByteData;
import 'package:logger/logger.dart';
import 'package:projet_excel/src/common_widgets/common_widgets.dart';
import 'package:projet_excel/src/features/lockers/domain/locker.dart';
import 'package:projet_excel/src/features/lockers/domain/student.dart';
import 'package:projet_excel/src/localization/string_harcoded.dart';

class ExcelImportScreen extends StatefulWidget {
  const ExcelImportScreen({super.key});

  @override
  State<ExcelImportScreen> createState() => _ExcelImportScreenState();
}

class _ExcelImportScreenState extends State<ExcelImportScreen> {
  List<Locker> _lockers = [];
  List<Student> _students = [];
  int i = 0;
  final logger = Logger();

  Future<void> readExcelFile() async {
    try {
      ByteData data = await rootBundle.load(
        'Vestiaires_apprentis_en_cours.xlsx',
      );
      var bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      var excel = Excel.decodeBytes(bytes);

      List<Locker> lockers = [];
      List<Student>? students = [];

      for (var table in excel.tables.keys) {
        for (var i = 0; i < excel.tables[table]!.rows.length; i++) {
          if (table == 'Total') {
            break;
          }
          var row = excel.tables[table]!.rows[i];
          if (i == 0) continue;

          String? firstcellValue = row[0]?.value?.toString();

          List<String> filteredRow;
          if (firstcellValue == 'Total vestiaire') continue;

          if (firstcellValue == 'Lieu' ||
              firstcellValue == 'Ancien bâtiment' ||
              firstcellValue == 'Nouveau bâtiment' ||
              firstcellValue == 'Sous-sol' ||
              firstcellValue == '2ème étage') {
            filteredRow = row
                .skip(1)
                .where((cell) => cell != null && cell.value != null)
                .map((cell) => cell!.value.toString())
                .toList();
          } else {
            filteredRow = row
                .where((cell) => cell != null && cell.value != null)
                .map((cell) => cell!.value.toString())
                .toList();
          }
          if (filteredRow.length <= 2) break;
          if (filteredRow.isNotEmpty) {
            lockers.add(Locker.fromExcel(filteredRow));
            if (filteredRow.length >= 6) {
              students.add(Student.fromExcel(filteredRow));
            }
          }
        }
      }
      setState(() {
        _lockers = lockers;
        _students = students;
      });
    } catch (e) {
      logger.e(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors du chargement du fichier")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projet Casiers'), centerTitle: true),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: readExcelFile,
            child: StyledText('Import Excel File'.hardcoded),
          ),
          Expanded(
            child: _lockers.isEmpty
                ? Center(child: Text('No data Loaded'.hardcoded))
                : ListView.builder(
                    itemCount: _lockers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: StyledText("Locker ${_lockers[index].id}"),
                        subtitle: StyledText(
                          "Etage: ${_lockers[index].floor}, Statut: ${_lockers[index].isAvailable ? 'Occupé' : 'Disponible'}",
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
