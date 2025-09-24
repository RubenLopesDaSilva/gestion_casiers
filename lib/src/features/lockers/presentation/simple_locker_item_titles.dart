import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class SimpleLockerItemTitles extends StatelessWidget {
  const SimpleLockerItemTitles({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.all(Radius.elliptical(75, 50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          //TODO mettre expanded plutôt entre les info avec des gap et l'info apart
          Expanded(child: Center(child: StyledHeadline('Place'.hardcoded))),
          gapW12,
          Expanded(child: Center(child: StyledHeadline('Floor'.hardcoded))),
          gapW12,
          // Expanded(
          //   child: Center(child: StyledHeadline('Responsible'.hardcoded)),
          // ),
          // gapW12,
          Expanded(child: Center(child: StyledHeadline('Locker'.hardcoded))),
          gapW12,
          Expanded(
            flex: 5,
            child: Center(child: StyledHeadline('Student'.hardcoded)),
          ),
          gapW12,
          // const Expanded(child: Center(child: StyledHeadline('Caution'))),
          // gapW12,
          // const Expanded(child: Center(child: StyledHeadline('Keys'))),
          // gapW12,
          const Expanded(child: Center(child: StyledHeadline('Lock'))),
        ],
      ),
    );
  }
}
