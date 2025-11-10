import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/features/dashboard/presentation/widgets/legend.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Legend(color: Colors.tealAccent, text: 'Casiers libres'.hardcoded),
          Legend(color: Colors.pink, text: 'Casiers occupés'.hardcoded),
          Legend(
            color: Colors.deepOrangeAccent,
            text: 'Casiers inaccessibles'.hardcoded,
          ),
        ],
      ),
    );
  }
}
