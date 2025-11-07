import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/students/data/student_repository.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/features/students/presentation/widgets/year_input.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class StudentUpdate extends ConsumerStatefulWidget {
  const StudentUpdate(this.student, {super.key});

  final Student student;

  @override
  ConsumerState<StudentUpdate> createState() => _LockerUpdateState();
}

class _LockerUpdateState extends ConsumerState<StudentUpdate> {
  final TextEditingController firstNameControl = TextEditingController();
  final TextEditingController lastNameControl = TextEditingController();
  final TextEditingController depositControl = TextEditingController();
  final TextEditingController loginControl = TextEditingController();
  final TextEditingController jobControl = TextEditingController();
  final TextEditingController titleControl = TextEditingController();

  int year = 0;

  bool editing = false;

  @override
  void initState() {
    super.initState();
    setControllers();
  }

  @override
  void dispose() {
    firstNameControl.dispose();
    lastNameControl.dispose();
    loginControl.dispose();
    jobControl.dispose();
    titleControl.dispose();

    super.dispose();
  }

  void setControllers() {
    firstNameControl.text = widget.student.firstName;
    lastNameControl.text = widget.student.lastName;
    loginControl.text = widget.student.login;
    depositControl.text = widget.student.deposit.toString();
    jobControl.text = widget.student.job;
    titleControl.text = widget.student.title;
    year = widget.student.year;
  }

  void annulate() async {
    setControllers();
    setState(() {});
  }

  void delete() {
    final studentRef = ref.read(studentsRepositoryProvider.notifier);
    studentRef.removeStudent(widget.student.id);
  }

  void save() {
    final studentRef = ref.read(studentsRepositoryProvider.notifier);

    Student update = widget.student.copyWith();
    studentRef.editStudent(widget.student.id, update);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double commonW = 280;
    final double commonH = 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: firstNameControl,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.lock_outline),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: lastNameControl,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.abc),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: YearInput(
                year: getYear(year),
                onChanged: (value) {
                  setState(() {
                    year = value?.value ?? 0;
                  });
                },
              ),
            ),
          ],
        ),
        gapH24,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: loginControl,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.lock_outline),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: jobControl,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.abc),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: titleControl,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.place_outlined),
              ),
            ),
          ],
        ),
        gapH24,
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledButton(
              color: AppColors.secondaryAccent,
              onPressed: editing ? annulate : delete,
              child: StyledText(
                (editing ? 'Annuler' : 'Delete').hardcoded,
                color: AppColors.primaryColor,
              ),
            ),
            gapW24,
            StyledButton(
              color: AppColors.secondaryAccent,
              onPressed: save,
              child: StyledText(
                'Enregistrer'.hardcoded,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
