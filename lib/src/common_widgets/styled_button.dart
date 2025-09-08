import 'package:flutter/material.dart';
import 'package:projet_excel/src/constants/app_sizes.dart';
import 'package:projet_excel/src/features/theme/theme.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.onPressed, required this.child});
  final VoidCallback onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.p12,
          horizontal: Sizes.p20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.primaryAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.p4)),
        ),
        child: child,
      ),
    );
  }
}
