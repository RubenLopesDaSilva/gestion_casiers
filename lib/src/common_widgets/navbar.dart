import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/navbar_button.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late AppRoute location;

  setStatter() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GoRouter.of(context).routerDelegate.addListener(setStatter);
  }

  @override
  Widget build(BuildContext context) {
    location = getLocation(GoRouter.of(context).state.name);
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Placeholder(fallbackHeight: 200),
          gapH8,
          const Divider(),
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
          const Text('Ceff - 2025', style: TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    GoRouter.of(context).routerDelegate.removeListener(setStatter);
    super.dispose();
  }
}

// class Navbar extends StatelessWidget {
//   const Navbar(this.location, {super.key});

//   final AppRoute location;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 320,
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Placeholder(fallbackHeight: 200),
//           gapH8,
//           const Divider(),
//           gapH8,
//           NavbarButton(
//             onTap: () {
//               context.goNamed(AppRoute.dashboard.name);
//             },
//             actif: location == AppRoute.dashboard,
//             iconData: Icons.dashboard,
//             text: 'Dashboard',
//           ),
//           NavbarButton(
//             onTap: () {
//               context.goNamed(AppRoute.lockers.name);
//             },
//             actif: location == AppRoute.lockers,
//             iconData: Icons.lock,
//             text: 'Casier',
//           ),
//           NavbarButton(
//             onTap: () {
//               context.goNamed(AppRoute.students.name);
//             },
//             actif: location == AppRoute.students,
//             iconData: Icons.school,
//             text: 'Élèves',
//           ),
//           NavbarButton(
//             onTap: () {
//               context.goNamed(AppRoute.assignment.name);
//             },
//             actif: location == AppRoute.assignment,
//             iconData: Icons.link,
//             text: 'Attributions',
//           ),
//           const Expanded(child: SizedBox()),
//           const Text('Ceff - 2025', style: TextStyle(color: Colors.blue)),
//         ],
//       ),
//     );
//   }
// }
