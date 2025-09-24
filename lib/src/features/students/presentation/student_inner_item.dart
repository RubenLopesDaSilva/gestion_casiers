import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class StudentInnerItem extends StatelessWidget {
  const StudentInnerItem({
    required this.student,
    required this.onTap,
    super.key,
  });

  final Student? student;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.primaryAccent,
          borderRadius: const BorderRadius.all(Radius.elliptical(45, 30)),
        ),
        child: Row(
          children: student == null
              ? [
                  Expanded(
                    child: Center(child: StyledHeadline('None'.hardcoded)),
                  ),
                ]
              : [
                  Expanded(
                    flex: 6,
                    child: Center(child: StyledText(student!.firstName)),
                  ),
                  gapW12,
                  Expanded(
                    flex: 4,
                    child: Center(child: StyledHeadline(student!.job)),
                  ),
                  gapW12,
                  Expanded(
                    flex: 6,
                    child: Center(child: StyledText(student!.lastName)),
                  ),
                ],
        ),
      ),
    );
  }
}
