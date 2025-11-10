import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/navbar_button.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatefulWidget {
  const Navbar(this.initialLocation, {super.key});

  final AppRoute initialLocation;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  AppRoute? location;

  @override
  void initState() {
    super.initState();
    location = widget.initialLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
      color: AppColors.primaryAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Placeholder(fallbackHeight: 200),
          ),
          gapH8,
          const Divider(),
          gapH8,
          NavbarButton(
            onTap: () {
              setState(() {
                location = AppRoute.dashboard;
                context.goNamed(AppRoute.dashboard.name);
              });
            },
            actif: location == AppRoute.dashboard,
            iconData: Icons.dashboard,
            text: 'Dashboard',
          ),
          NavbarButton(
            onTap: () {
              setState(() {
                location = AppRoute.lockers;
                context.goNamed(AppRoute.lockers.name);
              });
            },
            actif: location == AppRoute.lockers,
            iconData: Icons.lock,
            text: 'Casier',
          ),
          NavbarButton(
            onTap: () {
              setState(() {
                location = AppRoute.students;
                context.goNamed(AppRoute.students.name);
              });
            },
            actif: location == AppRoute.students,
            iconData: Icons.school,
            text: 'Élèves',
          ),
          NavbarButton(
            onTap: () {
              setState(() {
                location = AppRoute.assignment;
                context.goNamed(AppRoute.assignment.name);
              });
            },
            actif: location == AppRoute.assignment,
            iconData: Icons.link,
            text: 'Attributions',
          ),
          const Expanded(child: SizedBox()),
          Text('Ceff - 2025', style: TextStyle(color: AppColors.securColor)),
        ],
      ),
    );
  }
}
