import 'package:flutter/material.dart';

class StyledTextfield extends StatelessWidget {
  const StyledTextfield({
    required this.controller,
    this.readOnly,
    this.textInputType,
    this.prefixIcon,
    this.color,
    this.child,
    super.key,
  });

  final TextEditingController controller;
  final bool? readOnly;
  final TextInputType? textInputType;
  final Icon? prefixIcon;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly ?? false,
      keyboardType: textInputType,
      cursorColor: color,
      decoration: InputDecoration(prefixIcon: prefixIcon, label: child),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
    );
  }
}
