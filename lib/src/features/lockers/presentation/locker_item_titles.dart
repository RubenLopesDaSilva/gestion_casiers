import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/expand_center.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerItemTitles extends StatelessWidget {
  const LockerItemTitles({super.key});

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
          ExpandCenter(flex: 2, child: StyledHeadline('Place'.hardcoded)),
          exGapW12,
          ExpandCenter(child: StyledHeadline('Locker'.hardcoded)),
          exGapW12,
          ExpandCenter(flex: 3, child: StyledHeadline('Student'.hardcoded)),
          exGapW12,
          const ExpandCenter(child: StyledHeadline('Lock')),
          exGapW12,
          ExpandCenter(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add, color: AppColors.primaryAccent),
            ),
          ),
        ],
      ),
    );
  }
}
