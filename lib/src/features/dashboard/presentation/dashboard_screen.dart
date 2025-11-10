import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/dashboard/presentation/widgets/dashboard_overview.dart';
import 'package:gestion_casiers/src/features/dashboard/presentation/widgets/info_card.dart';
import 'package:gestion_casiers/src/features/dashboard/presentation/widgets/output_panel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const CommonBody(
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: [
            gapH24,
            Expanded(
              flex: 8,
              child: Row(children: [DashboardOverview(), gapW64, InfoCard()]),
            ),
            gapH24,
            Expanded(flex: 7, child: OutputPanel()),
          ],
        ),
      ),
      panel: Column(),
    );
  }
}
