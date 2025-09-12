import 'package:excel/excel.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/domain.dart';
import 'package:uuid/uuid.dart';

final uuid = const Uuid();

List<Locker> importLockersFrom(Excel excel) {
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

      for (Student studentValue in LockerRepository().students) {
        Student student = LockerRepository().students.firstWhere(
          (student) => student.id == studentValue.id,
        );

        if (student.lastName == results[3] && student.firstName == results[4]) {
          id = student.id;
        }
      }

      lockers.add(
        Locker(
          floor: floor.replaceAll('Etage ', ''),
          place: results[0],
          number: int.parse(results[2]),
          responsable: results[3],
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

List<Student> importStudentsFrom(Excel excel) {
  final students = <Student>[];

  final sheet = excel[excel.sheets.keys.first];

  var cell = sheet.cell(CellIndex.indexByString('A1'));
  int row = 1;

  while (cell.value != null) {
    final results = [];
    for (int i = 0; i < 25; i++) {
      results.add(cell.value?.toString() ?? '');
      cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: i, rowIndex: row),
      );
    }

    students.add(
      Student(
        id: uuid.v4(),
        firstName: results[6],
        title: results[3],
        lastName: results[5],
        login: results[11],
        year: int.parse(results[18]),
        job: results[13],
      ),
    );

    cell = sheet.cell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: ++row),
    );
  }

  return students;
}

void importFile(Excel excel) {
  bool doImportLockers = false;

  for (String sheet in excel.sheets.keys) {
    if (sheet.contains('Etage')) {
      doImportLockers = true;
      break;
    }
  }

  if (doImportLockers) {
    LockerRepository().setLockers(importLockersFrom(excel));
  } else {
    LockerRepository().setStudents(importStudentsFrom(excel));
  }
}
