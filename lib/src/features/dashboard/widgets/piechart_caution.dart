import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/dashboard/widgets/legend.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';

class PiechartCaution extends StatelessWidget {
  const PiechartCaution({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 280,
            height: 280,
            child: PieChart(
              PieChartData(
                borderData: FlBorderData(show: true),
                centerSpaceRadius: 40,
                sectionsSpace: 24,
                sections: [
                  PieChartSectionData(color: Colors.tealAccent),
                  PieChartSectionData(color: Colors.pink),
                ],
              ),
            ),
          ),
          gapH12,
          Legend(color: Colors.tealAccent, text: 'Cautions payées'.hardcoded),
          gapH12,
          Legend(color: Colors.pink, text: 'Cautions non-payées'.hardcoded),
        ],
      ),
    );
  }
}
