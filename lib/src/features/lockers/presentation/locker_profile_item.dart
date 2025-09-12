import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerProfileItem extends StatelessWidget {
  const LockerProfileItem({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: AppColors.primaryAccent,
        child: Row(children: children),
      ),
    );
  }
}
