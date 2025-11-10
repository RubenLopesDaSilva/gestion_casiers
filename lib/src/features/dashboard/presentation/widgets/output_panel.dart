import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/students/data/student_repository.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class OutputPanel extends ConsumerStatefulWidget {
  const OutputPanel({super.key});

  @override
  ConsumerState<OutputPanel> createState() => _OutputPanelState();
}

class _OutputPanelState extends ConsumerState<OutputPanel> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    final lockerRepository = ref.watch(lockersRepositoryProvider.notifier);
    final studentRepository = ref.watch(studentsRepositoryProvider.notifier);
    final List<Widget> children = [];

    if (index > 0 && index < 4) {
      List<Locker> lockers = [];

      switch (index) {
        case 1:
          lockers = lockerRepository
              .fetchLockersList()
              .where((locker) => locker.studentId == null)
              .toList();
          break;
        case 2:
          lockers = lockerRepository
              .fetchLockersList()
              .where((locker) => locker.keyCount == 0)
              .toList();
          break;
        case 3:
          lockers = lockerRepository
              .fetchLockersList()
              .where((locker) => locker.lockerCondition.problems != null)
              .toList();
          break;
      }

      for (Locker locker in lockers) {
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(children: [gapW24, StyledText('${locker.number}')]),
          ),
        );
      }
    } else if (index > 3 && index < 5) {
      List<Student> students = [];

      switch (index) {
        case 4:
          students = studentRepository.fetchStudents().where((student) {
            for (Locker locker in lockerRepository.fetchLockersList()) {
              if (locker.studentId == student.id) {
                return true;
              }
            }
            return false;
          }).toList();
          break;
      }

      for (Student student in students) {
        children.add(
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(vertical: 12.0),
            child: Row(
              children: [
                gapW24,
                StyledText('${student.firstName} ${student.lastName}'),
              ],
            ),
          ),
        );
      }
    }

    return Container(
      color: AppColors.primaryAccent,
      child: Column(
        children: [
          Row(
            children: [
              gapW24,
              TextButton(
                onPressed: () {
                  setState(() {
                    index = index == 1 ? 0 : 1;
                  });
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: index == 1
                        ? StyledText('Casier libre'.hardcoded)
                        : StyledHeadline('Casier libre'.hardcoded),
                  ),
                ),
              ),
              gapW24,
              TextButton(
                onPressed: () {
                  setState(() {
                    index = index == 2 ? 0 : 2;
                  });
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: index == 2
                        ? StyledText('Casier sans clé'.hardcoded)
                        : StyledHeadline('Casier sans clé'.hardcoded),
                  ),
                ),
              ),
              gapW24,
              TextButton(
                onPressed: () {
                  setState(() {
                    index = index == 3 ? 0 : 3;
                  });
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: index == 3
                        ? StyledText('Casier défectueux'.hardcoded)
                        : StyledHeadline('Casier défectueux'.hardcoded),
                  ),
                ),
              ),
              gapW24,
              TextButton(
                onPressed: () {
                  setState(() {
                    index = index == 4 ? 0 : 4;
                  });
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: index == 4
                        ? StyledText('Élèves sans casier'.hardcoded)
                        : StyledHeadline('Élèves sans casier'.hardcoded),
                  ),
                ),
              ),
            ],
          ),
          Divider(color: AppColors.titleColor, height: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectionArea(child: ListView(children: children)),
            ),
          ),
        ],
      ),
    );
  }
}
