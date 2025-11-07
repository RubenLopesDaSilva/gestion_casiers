import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/features/students/presentation/widgets/student_update.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class StudentItem extends StatelessWidget {
  const StudentItem(this.student, {super.key});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.lock_outline, color: AppColors.alertColor),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText('${student.lastName} ${student.firstName}'),
          StyledText('Aucune remarque'.hardcoded),
        ],
      ),
      shape: const Border(),
      tilePadding: const EdgeInsets.all(8.0),
      childrenPadding: const EdgeInsets.all(8.0),
      children: [StudentUpdate(student)],
    );
  }
}
