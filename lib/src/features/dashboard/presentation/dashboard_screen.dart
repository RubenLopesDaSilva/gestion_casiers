import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/dashboard/widgets/barchart.dart';
import 'package:gestion_casiers/src/features/dashboard/widgets/dashboard_overview.dart';
import 'package:gestion_casiers/src/features/dashboard/widgets/info_card.dart';
import 'package:gestion_casiers/src/features/dashboard/widgets/piechart_caution.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CommonBody(
        location: AppRoute.dashboard,
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(children: [DashboardOverview(), gapW24, InfoCard()]),
              gapH24,
              Row(children: [Barchart(), gapW24, PiechartCaution()]),
            ],
          ),
        ),
        panel: Column(),
      ),
    );
  }
}
