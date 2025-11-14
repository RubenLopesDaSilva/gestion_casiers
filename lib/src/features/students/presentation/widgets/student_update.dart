import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text_form_field.dart';
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

    super.dispose();
  }

  void setControllers() {
    firstNameControl.text = widget.student.firstName;
    lastNameControl.text = widget.student.lastName;
    loginControl.text = widget.student.login;
    depositControl.text = widget.student.deposit.toString();
    jobControl.text = widget.student.job;
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

    final firstName = firstNameControl.text;
    final lastName = lastNameControl.text;
    final login = loginControl.text;
    final deposit = int.tryParse(depositControl.text);
    final job = jobControl.text;
    final newYear = year;
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        login.isEmpty ||
        deposit == null ||
        job.isEmpty ||
        newYear == 0) {
    } else {
      Student update = widget.student.copyWith(
        firstName: firstName,
        lastName: lastName,
        login: login,
        deposit: deposit,
        job: job,
        year: newYear,
      );
      studentRef.editStudent(widget.student.id, update);
      setState(() {});
    }
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
              child: StyledTextFormField(
                controller: firstNameControl,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.lock_outline),
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Le champ doit être remplie'.hardcoded;
                  }
                  return null;
                },
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextFormField(
                controller: lastNameControl,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.abc),
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Le champ doit être remplie'.hardcoded;
                  }
                  return null;
                },
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
              child: StyledTextFormField(
                controller: loginControl,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.lock_outline),
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Le champ doit être remplie'.hardcoded;
                  }
                  return null;
                },
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextFormField(
                controller: jobControl,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.abc),
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Le champ doit être remplie'.hardcoded;
                  }
                  return null;
                },
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextFormField(
                controller: depositControl,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.place_outlined),
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  final number = int.tryParse(value ?? '');
                  if (number == null) {
                    return 'Essayez de mettre un nombre'.hardcoded;
                  } else if (number < 0) {
                    return 'Seulement les nombres positif sont accepté'
                        .hardcoded;
                  }
                  return null;
                },
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
