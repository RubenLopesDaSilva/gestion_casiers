import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({required this.student, required this.profile, super.key});

  final Student student;
  final Function profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.all(Radius.elliptical(75, 50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          exGapW12,
          ExpandCenter(child: StyledHeadline(student.login)),
          exGapW12,
          ExpandCenter(child: StyledText(student.firstName)),
          exGapW12,
          ExpandCenter(child: StyledText(student.lastName)),
          exGapW12,
          ExpandCenter(child: StyledHeadline(student.job)),
          exGapW12,
          ExpandCenter(
            child: IconButton(
              onPressed: () => profile(student),
              icon: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
