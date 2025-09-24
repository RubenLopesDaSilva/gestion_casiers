import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class StudentItemTitles extends StatelessWidget {
  const StudentItemTitles({super.key});

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
          Expanded(child: Center(child: StyledHeadline('Login'.hardcoded))),
          gapW12,
          Expanded(
            child: Center(child: StyledHeadline('First Name'.hardcoded)),
          ),
          gapW12,
          Expanded(child: Center(child: StyledHeadline('Last Name'.hardcoded))),
          gapW12,
          Expanded(child: Center(child: StyledHeadline('Job'.hardcoded))),
        ],
      ),
    );
  }
}
