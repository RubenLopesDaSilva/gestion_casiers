import 'package:gestion_casiers/src/features/lockers/presentation/locker_profile.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_screen.dart';
import 'package:gestion_casiers/src/features/students/presentation/student_profile.dart';
import 'package:gestion_casiers/src/features/students/presentation/student_screen.dart';
import 'package:gestion_casiers/src/features/students/presentation/student_selection_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute { home, simple, student, students, lockerprofile, studentprofile }

final goRouter = GoRouter(
  initialLocation: '/locker',
  routes: [
    GoRoute(
      path: '/locker',
      name: AppRoute.simple.name,
      builder: (context, state) {
        return const LockerScreen();
      },
      routes: [
        GoRoute(
          path: '/profile/:lock',
          name: AppRoute.lockerprofile.name,
          builder: (context, state) {
            final lock = state.pathParameters['lock'];
            return LockerProfile(lock);
          },
        ),
        GoRoute(
          path: '/students',
          name: AppRoute.students.name,
          builder: (context, state) {
            return const StudentSelectionScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/student',
      name: AppRoute.student.name,
      builder: (context, state) {
        return const StudentScreen();
      },
      routes: [
        GoRoute(
          path: '/profile/:id',
          name: AppRoute.studentprofile.name,
          builder: (context, state) {
            final studentId = state.pathParameters['id'];
            return StudentProfile(studentId);
          },
        ),
      ],
    ),
  ],
);
