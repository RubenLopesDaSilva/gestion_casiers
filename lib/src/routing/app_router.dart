import 'package:gestion_casiers/src/features/lockers/presentation/simple_locker_profile.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/simple_screen.dart';
import 'package:gestion_casiers/src/features/students/presentation/student_selection_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute { home, simple, students, lockerprofile }

final goRouter = GoRouter(
  initialLocation: '/locker',
  routes: [
    GoRoute(
      path: '/locker',
      name: AppRoute.simple.name,
      builder: (context, state) {
        return const SimpleScreen();
      },
      routes: [
        GoRoute(
          path: '/students',
          name: AppRoute.students.name,
          builder: (context, state) {
            return const StudentSelectionScreen();
          },
        ),
        GoRoute(
          path: '/profile/:lock',
          name: AppRoute.lockerprofile.name,
          builder: (context, state) {
            final lock = state.pathParameters['lock'];
            return SimpleLockerProfile(lock);
          },
        ),
      ],
    ),
  ],
);
