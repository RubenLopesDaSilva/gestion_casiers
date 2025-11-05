import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_service.dart';
import 'package:gestion_casiers/src/features/students/data/student_service.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';

final lockerDetailsProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, lockerId) async {
      final lockerRepository = ref.watch(lockerService.notifier);
      final studentReposiotry = ref.watch(studentService.notifier);

      final locker = await lockerRepository.findLockerById(lockerId);

      Student? student;
      if (locker.studentId != null) {
        student = await studentReposiotry.findStudentById(locker.studentId);
      }

      return {'locker': locker, 'student': student};
    });
