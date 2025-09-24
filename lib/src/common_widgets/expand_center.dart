import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';

class ExpandCenter extends StatelessWidget {
  const ExpandCenter({this.flex = 1, this.child, super.key});

  final int flex;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(child: child),
    );
  }
}

const exGapW12 = Expanded(child: gapW12);

const exGapH12 = Expanded(child: gapW12);
