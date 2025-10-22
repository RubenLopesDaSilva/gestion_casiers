import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/navbar_button.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatelessWidget {
  const Navbar(this.location, {super.key});

  final AppRoute location;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black)),
            ),
            child: const Placeholder(),
          ),
          gapH8,
          NavbarButton(
            onTap: () {
              context.goNamed(AppRoute.dashboard.name);
            },
            actif: location == AppRoute.dashboard,
            iconData: Icons.dashboard,
            text: 'Dashboard',
          ),
          NavbarButton(
            onTap: () {
              context.goNamed(AppRoute.lockers.name);
            },
            actif: location == AppRoute.lockers,
            iconData: Icons.lock,
            text: 'Casier',
          ),
          NavbarButton(
            onTap: () {
              context.goNamed(AppRoute.students.name);
            },
            actif: location == AppRoute.students,
            iconData: Icons.school,
            text: 'Élèves',
          ),
          NavbarButton(
            onTap: () {
              context.goNamed(AppRoute.assignment.name);
            },
            actif: location == AppRoute.assignment,
            iconData: Icons.link,
            text: 'Attributions',
          ),
          const Expanded(child: SizedBox()),
          const Text('ceff - 2023', style: TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }
}
