import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';

class InfoCardElement extends StatelessWidget {
  const InfoCardElement({
    required this.iconData,
    required this.text,
    required this.number,
    super.key,
  });

  final IconData iconData;
  final String text;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 240,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          Icon(iconData),
          StyledText(text, overflow: null),
          StyledTitle('$number'),
        ],
      ),
    );
  }
}
