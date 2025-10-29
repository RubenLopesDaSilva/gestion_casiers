import 'package:flutter/material.dart';

class DefaultWidget extends StatelessWidget {
  const DefaultWidget(this.widget, {super.key});

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return widget ?? const SizedBox(width: 0, height: 0);
  }
}
