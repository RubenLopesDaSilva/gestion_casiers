import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/features/dashboard/widgets/indicator.dart';
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
              // chartRadius: 240,
              // ringStrokeWidth: 48,
              colorList: [
                Colors.tealAccent,
                Colors.pink,
                Colors.deepOrangeAccent,
              ],
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                // chartValueStyle: TextStyle(color: Colors.white),
                // showChartValuesOutside: true,
                decimalPlaces: 0,
              ),
            ),
          ),
          Indicator(),
        ],
      ),
    );
  }
}
