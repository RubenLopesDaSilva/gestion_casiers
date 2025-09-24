import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/data/student_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/domain.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/student_inner_item.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class SimpleLockerItem extends StatelessWidget {
  const SimpleLockerItem({
    required this.studentRef,
    required this.lockerRef,
    required this.locker,
    required this.student,
    required this.profile,
    super.key,
  });

  final StudentRepository studentRef;
  final LockerRepository lockerRef;
  final Locker locker;
  final Function student;
  final Function profile;

  @override
  Widget build(BuildContext context) {
    Student? currentUser = studentRef.findStudentBy(id: locker.studentId);
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.all(Radius.elliptical(75, 50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(flex: 2, child: Center(child: StyledHeadline(locker.place))),
          gapW12,
          Expanded(child: Center(child: StyledText(locker.floor))),
          gapW12,
          // Expanded(child: Center(child: StyledText(locker.responsable))),
          // gapW12,
          Expanded(child: Center(child: StyledHeadline('${locker.number}'))),
          gapW12,
          Expanded(
            flex: 10,
            child: StudentInnerItem(
              student: currentUser,
              onTap: () => student(locker, lockerRef),
            ),
          ),
          gapW12,
          // Expanded(child: Center(child: StyledText('${locker.deposit}'))),
          // gapW12,
          // Expanded(child: Center(child: StyledText('${locker.keyCount}'))),
          // gapW12,
          Expanded(
            child: Center(child: StyledHeadline('${locker.lockNumber}')),
          ),
          gapW12,
          IconButton(
            onPressed: () => profile(locker),
            icon: Icon(Icons.arrow_forward_ios, color: AppColors.primaryAccent),
          ),
        ],
      ),
    );
  }
}
