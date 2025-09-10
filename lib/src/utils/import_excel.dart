import 'package:excel/excel.dart';
import 'package:projet_excel/src/features/lockers/data/locker_repository.dart';
import 'package:projet_excel/src/features/lockers/domain/domain.dart';
import 'package:uuid/uuid.dart';

final uuid = const Uuid();

List<Locker> importIchFromExcelFile(Excel excel) {
  final lockers = <Locker>[];

  for (final floor in excel.sheets.keys.where((key) => key.contains('Etage'))) {
    if (!['Etage B', 'Etage C', 'Etage D', 'Etage E'].contains(floor)) {
      continue;
    }
    int row = 1;
    var cell = excel[floor].cell(
      CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row),
    );

    while (cell.value != null) {
      // bool isLockerEmpty =
      //     excel[floor]
      //         .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
      //         .value ==
      //     null;

      final results = [];

      for (int i = 0; i < 9; i++) {
        var cell = excel[floor].cell(
          CellIndex.indexByColumnRow(columnIndex: 2 + i, rowIndex: row),
        );

        results.add(cell.value.toString());
      }

      if (results[3] == 'null') {
        cell = excel[floor].cell(
          CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: ++row),
        );

        continue;
      }

      String id = '';

      for (Student studentId in LockerProvider.students) {
        Student student = LockerProvider.students.firstWhere(
          (student) => student.id == studentId.id,
        );

        if (student.lastName == results[3] && student.firstName == results[4]) {
          id = studentId.id;
        }
      }

      lockers.add(
        Locker(
          floor: floor.replaceAll('Etage ', ''),

          number: int.parse(results[0]),

          responsable: results[1],

          studentId: id == '' ? null : id,

          deposit: int.tryParse(results[5]) ?? 0,

          keyCount: int.parse(results[6]),

          lockNumber: int.parse(results[7]),

          lockerCondition: LockerCondition.isGood(
            comments: results[8] == 'null' ? null : results[8],
          ),
        ),
      );

      cell = excel[floor].cell(
        CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: ++row),
      );
    }
  }

  lockers.sort((a, b) => a.number - b.number);

  return lockers;
}

bool verifyExcelFile() {
  return true;
}
