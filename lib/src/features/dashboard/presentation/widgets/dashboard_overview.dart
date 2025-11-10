import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/dashboard/presentation/widgets/indicator.dart';
import 'package:pie_chart/pie_chart.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsGeometry.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 250,
            child: PieChart(
              legendOptions: LegendOptions(showLegends: false),
              chartType: ChartType.ring,
              dataMap: {
                'Casiers libres': 34,
                'Casiers occupés': 9,
                'Casiers inaccessibles': 0,
              },
              centerWidget: StyledTitle('60'),
              ringStrokeWidth: 40,
              colorList: [
                Colors.tealAccent,
                Colors.pink,
                Colors.deepOrangeAccent,
              ],
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                decimalPlaces: 0,
              ),
            ),
          ),
          gapH64,
          Indicator(),
        ],
      ),
    );
  }
}
