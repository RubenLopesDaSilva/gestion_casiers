import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/student_inner_item.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_service.dart';
import 'package:gestion_casiers/src/features/students/data/student_service.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class SimpleLockerItem extends StatelessWidget {
  const SimpleLockerItem({
    required this.studentRef,
    required this.lockerRef,
    required this.locker,
    required this.studentDetail,
    required this.profile,
    super.key,
  });

  final StudentService studentRef;
  final LockerService lockerRef;
  final Locker locker;
  final Function studentDetail;
  final Function profile;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Student?>(
      future: studentRef.findStudentById(locker.studentId),
      builder: (context, asyncSnapshot) {
        return Container(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.all(Radius.elliptical(75, 50)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Center(child: StyledHeadline(locker.place)),
              ),
              gapW12,
              Expanded(child: Center(child: StyledText(locker.floor))),
              gapW12,
              // Expanded(child: Center(child: StyledText(locker.responsable))),
              // gapW12,
              Expanded(
                child: Center(child: StyledHeadline('${locker.number}')),
              ),
              gapW12,
              Expanded(
                flex: 10,
                child: StudentInnerItem(
                  student: asyncSnapshot.data,
                  onTap: () => studentDetail(locker, lockerRef),
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
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primaryAccent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
