import 'package:gestion_casiers/src/common_widgets/common_screen.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/features/assignment/presentation/assignment_screen.dart';
import 'package:gestion_casiers/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_screen.dart';
import 'package:gestion_casiers/src/features/students/presentation/student_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  assignment('/assignment'),
  dashboard('/dashboard'),
  lockers('/lockers'),
  students('/students');

  final String path;
  const AppRoute(this.path);
}

AppRoute getLocation(String? name) {
  return AppRoute.values.firstWhere(
    (route) => route.name == name,
    orElse: () => AppRoute.dashboard,
  );
}

final goRouter = GoRouter(
  initialLocation: AppRoute.dashboard.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return CommonScreen(navBar: const Navbar(), body: child);
      },
      routes: [
        GoRoute(
          path: AppRoute.assignment.path,
          name: AppRoute.assignment.name,
          builder: (context, state) {
            return const AssignmentScreen();
          },
        ),
        GoRoute(
          path: AppRoute.dashboard.path,
          name: AppRoute.dashboard.name,
          builder: (context, state) {
            return const DashboardScreen();
          },
        ),
        GoRoute(
          path: AppRoute.lockers.path,
          name: AppRoute.lockers.name,
          builder: (context, state) {
            return const LockerScreen();
          },
        ),
        GoRoute(
          path: AppRoute.students.path,
          name: AppRoute.students.name,
          builder: (context, state) {
            return const StudentScreen();
          },
        ),
      ],
    ),
  ],
);
