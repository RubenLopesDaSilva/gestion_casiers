import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class StudentItemTitles extends StatelessWidget {
  const StudentItemTitles({required this.onPressed, super.key});

  final VoidCallback onPressed;

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
          exGapW12,
          ExpandCenter(child: StyledHeadline('Login'.hardcoded)),
          exGapW12,
          ExpandCenter(child: StyledHeadline('First Name'.hardcoded)),
          exGapW12,
          ExpandCenter(child: StyledHeadline('Last Name'.hardcoded)),
          exGapW12,
          ExpandCenter(child: StyledHeadline('Job'.hardcoded)),
          exGapW12,
          ExpandCenter(
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.add, color: AppColors.primaryAccent),
            ),
          ),
        ],
      ),
    );
  }
}
