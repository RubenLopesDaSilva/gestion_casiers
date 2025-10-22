import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CommonBody(
        location: AppRoute.students,
        body: Placeholder(),
        panel: Column(),
      ),
    );
  }
}
