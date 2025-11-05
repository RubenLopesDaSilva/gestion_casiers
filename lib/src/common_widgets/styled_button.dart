import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    this.width,
    this.height,
    this.color,
    required this.onPressed,
    required this.child,
  });

  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 320,
      height: height ?? 44,
      color: color ?? AppColors.primaryAccent,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.resolveWith(
            (states) => Colors.transparent,
          ),
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
