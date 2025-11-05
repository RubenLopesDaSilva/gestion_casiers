import 'package:excel/excel.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker_condition.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/features/students/data/student_service.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final logger = Logger();

Future<List<Locker>> importLockersFrom(Excel excel) async {
  final lockers = <Locker>[];
  final service = StudentService();
  try {
    for (final floor in excel.sheets.keys.where(
      (key) => key.contains('Etage'),
    )) {
      if (!['Etage B', 'Etage C', 'Etage D', 'Etage E'].contains(floor)) {
        continue;
      }

      String place = excel[floor]
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1))
          .value
          .toString();

      int row = 1;

      if (floor == 'Etage B') {
        row = 81;
      }

      if (floor == 'Etage E') {
        row = 44;
      }

      var cell = excel[floor].cell(
        CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row),
      );
      while (cell.value != null) {
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

        String? id = '';

        final currentStudent = await service.findStudentByName(
          results[4],
          results[3],
        );
        if (currentStudent != null && currentStudent.id != null) {
          id = currentStudent.id;
          await service.patchStudent(currentStudent);
        }
        final locker = Locker(
          id: uuid.v4(),
          floor: floor.replaceAll('Etage ', ''),
          place: place,
          number: int.parse(results[0]),
          responsable: results[1],
          studentId: id,
          keyCount: int.parse(results[6]),
          lockNumber: int.parse(results[7]),
          lockerCondition: LockerCondition.isGood(
            comments: results[8] == 'null' ? null : results[8],
          ),
        );
        lockers.add(locker);
        cell = excel[floor].cell(
          CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: ++row),
        );
      }
    }

    lockers.sort((a, b) => a.number - b.number);
    return lockers;
  } catch (e) {
    return [];
  }
}

List<Student> importStudentsFrom(Excel excel) {
  final students = <Student>[];

  final sheet = excel[excel.sheets.keys.first];

  if (sheet.sheetName != 'ESMA-Export') {
    throw Error();
  }

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
        firstName: results[7],
        title: results[5],
        lastName: results[6],
        login: results[12],
        deposit: 20,
        year: int.parse(results[19]),
        job: results[14],
      ),
    );

    cell = sheet.cell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: ++row),
    );
  }

  return students;
}
