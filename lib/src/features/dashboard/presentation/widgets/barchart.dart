import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/dashboard/presentation/widgets/legend.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';

class Barchart extends StatelessWidget {
  const Barchart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 400,
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          SizedBox(
            width: 400,
            height: 280,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                maxY: 30,
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 24,
                        color: Colors.tealAccent,
                        width: Sizes.p24,
                      ),
                      BarChartRodData(
                        toY: 0,
                        color: Colors.pink,
                        width: Sizes.p24,
                      ),
                    ],
                    barsSpace: 10,
                  ),
                  BarChartGroupData(
                    x: 10,
                    barRods: [
                      BarChartRodData(
                        toY: 18,
                        color: Colors.tealAccent,
                        width: Sizes.p24,
                      ),
                      BarChartRodData(
                        toY: 0,
                        color: Colors.pink,
                        width: Sizes.p24,
                      ),
                    ],
                    barsSpace: 10,
                  ),
                  BarChartGroupData(
                    x: 20,
                    barRods: [
                      BarChartRodData(
                        toY: 12,
                        color: Colors.tealAccent,
                        width: Sizes.p24,
                      ),
                      BarChartRodData(
                        toY: 10,
                        color: Colors.pink,
                        width: Sizes.p24,
                      ),
                    ],
                    barsSpace: 10,
                  ),
                  BarChartGroupData(
                    x: 30,
                    barRods: [
                      BarChartRodData(
                        toY: 0,
                        color: Colors.tealAccent,
                        width: Sizes.p24,
                      ),
                      BarChartRodData(
                        toY: 0,
                        color: Colors.pink,
                        width: Sizes.p24,
                      ),
                    ],
                    barsSpace: 10,
                  ),
                ],
                titlesData: const FlTitlesData(
                  topTitles: AxisTitles(),
                  leftTitles: AxisTitles(),
                  rightTitles: AxisTitles(),
                  bottomTitles: AxisTitles(
                    axisNameWidget: Row(
                      children: [
                        gapW64,
                        StyledHeadline('b'),
                        gapW64,
                        StyledHeadline('c'),
                        gapW64,
                        StyledHeadline('d'),
                        gapW64,
                        StyledHeadline('e'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          gapH12,
          Legend(
            color: Colors.tealAccent,
            text: 'Casiers totaux par étage'.hardcoded,
          ),
          gapH12,
          Legend(
            color: Colors.pink,
            text: 'Casiers occupés par étage'.hardcoded,
          ),
        ],
      ),
    );
  }
}
