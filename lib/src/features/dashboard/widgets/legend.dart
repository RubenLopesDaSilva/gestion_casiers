import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';

class Legend extends StatelessWidget {
  const Legend({required this.color, required this.text, super.key});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: Sizes.p24, height: Sizes.p24, color: color),
        gapW8,
        StyledHeadline(text),
      ],
    );
  }
}
