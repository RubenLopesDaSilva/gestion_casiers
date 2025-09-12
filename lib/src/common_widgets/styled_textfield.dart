import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class StyledTextfield extends StatelessWidget {
  const StyledTextfield({
    required this.controller,
    this.readOnly,
    this.textInputType,
    this.prefixIcon,
    required this.child,
    super.key,
  });

  final TextEditingController controller;
  final bool? readOnly;
  final TextInputType? textInputType;
  final Icon? prefixIcon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly ?? false,
      keyboardType: textInputType,
      cursorColor: AppColors.textColor,
      decoration: InputDecoration(prefixIcon: prefixIcon, label: child),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
