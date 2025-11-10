import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class CommonBody extends StatelessWidget {
  const CommonBody({required this.body, required this.panel, super.key});

  final Widget body;
  final Widget panel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: body),
        Container(width: 400, color: AppColors.primaryAccent, child: panel),
      ],
    );
  }
}
