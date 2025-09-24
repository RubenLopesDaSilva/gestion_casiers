import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
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
          Expanded(child: Center(child: StyledHeadline(student.login))),
          gapW12,
          Expanded(child: Center(child: StyledText(student.firstName))),
          gapW12,
          Expanded(child: Center(child: StyledText(student.lastName))),
          gapW12,
          Expanded(child: Center(child: StyledHeadline(student.job))),
          gapW12,
          // Expanded(
          //   flex: 10,
          //   child: StudentInnerItem(
          //     student: currentUser,
          //     onTap: () {
          //       student(locker, ref);
          //     },
          //   ),
          // ),
          // gapW12,
          // Expanded(child: Center(child: StyledText(student.title))),
          // gapW12,
          // Expanded(child: Center(child: StyledText(student.id))),
          // gapW12,
          // Expanded(child: Center(child: StyledText('${student.year}'))),
          // gapW12,
          IconButton(
            onPressed: () => profile(student),
            icon: Icon(Icons.arrow_forward_ios, color: AppColors.primaryAccent),
          ),
        ],
      ),
    );
  }
}
