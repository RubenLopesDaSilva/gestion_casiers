import 'package:excel/excel.dart';
import 'package:projet_excel/src/features/lockers/domain/locker.dart';

List<Locker> importLockersFrom(Excel excel) {
  final lockers = <Locker>[];
  try {
    for (final floor in excel.sheets.keys.where(
      (key) => key.contains('Etage'),
    )) {
      if (floor == 'Etage F') continue;

      
    }

    return lockers;
  } catch (e) {
    rethrow;
  }
}
