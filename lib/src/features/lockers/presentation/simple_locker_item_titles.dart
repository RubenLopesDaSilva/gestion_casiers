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
          Expanded(child: Center(child: StyledHeadline('place'.hardcoded))),
          gapW12,
          Expanded(child: Center(child: StyledHeadline('floor'.hardcoded))),
          gapW12,
          Expanded(
            child: Center(child: StyledHeadline('responsible'.hardcoded)),
          ),
          gapW12,
          Expanded(child: Center(child: StyledHeadline('number'.hardcoded))),
          gapW12,
          Expanded(child: Center(child: StyledHeadline('Student'.hardcoded))),
          gapW12,
          const Expanded(child: Center(child: StyledHeadline('caution'))),
          gapW12,
          const Expanded(child: Center(child: StyledHeadline('numberKeys'))),
          gapW12,
          const Expanded(child: Center(child: StyledHeadline('lockerNumber'))),
        ],
      ),
    );
  }
}
