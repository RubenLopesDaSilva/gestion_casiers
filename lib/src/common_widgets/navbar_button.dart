import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class NavbarButton extends StatelessWidget {
  const NavbarButton({
    required this.onTap,
    required this.actif,
    required this.iconData,
    required this.text,
    super.key,
  });

  final VoidCallback onTap;
  final bool actif;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration: actif
            ? BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(8.0),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: actif
              ? [Icon(iconData), gapW12, StyledHeadline(text.hardcoded)]
              : [Icon(iconData), gapW12, StyledText(text.hardcoded)],
        ),
      ),
    );
  }
}
