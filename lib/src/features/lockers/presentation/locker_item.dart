import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/expand_center.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/students/data/student_repository.dart';
import 'package:gestion_casiers/src/features/students/presentation/student_inner_item.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerItem extends StatelessWidget {
  const LockerItem({
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
    late Student? currentUser;
    try {
      currentUser = studentRef.findStudentBy(id: locker.studentId);
    } catch (e) {
      currentUser = null;
    }
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.all(Radius.elliptical(75, 50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ExpandCenter(flex: 2, child: StyledHeadline(locker.place)),
          exGapW12,
          ExpandCenter(child: StyledHeadline('${locker.number}')),
          exGapW12,
          ExpandCenter(
            flex: 3,
            child: StudentInnerItem(
              student: currentUser,
              onTap: () => student(locker, lockerRef),
            ),
          ),
          exGapW12,
          ExpandCenter(child: StyledHeadline('${locker.lockNumber}')),
          exGapW12,
          ExpandCenter(
            child: IconButton(
              onPressed: () => profile(locker),
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
