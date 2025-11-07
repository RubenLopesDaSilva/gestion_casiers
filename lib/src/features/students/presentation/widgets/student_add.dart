import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/students/data/student_repository.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/features/students/presentation/widgets/year_input.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class StudentAdd extends ConsumerStatefulWidget {
  const StudentAdd({super.key});

  @override
  ConsumerState<StudentAdd> createState() => _StudentAddState();
}

class _StudentAddState extends ConsumerState<StudentAdd> {
  final TextEditingController firstNameControl = TextEditingController();
  final TextEditingController lastNameControl = TextEditingController();
  final TextEditingController depositControl = TextEditingController();
  final TextEditingController loginControl = TextEditingController();
  final TextEditingController jobControl = TextEditingController();

  int year = 0;

  @override
  void dispose() {
    firstNameControl.dispose();
    lastNameControl.dispose();
    depositControl.dispose();
    loginControl.dispose();
    jobControl.dispose();

    super.dispose();
  }

  void annulate() async {
    setControllers();
    setState(() {});
  }

  void setControllers() {
    firstNameControl.text = '';
    lastNameControl.text = '';
    depositControl.text = '';
    loginControl.text = '';
    jobControl.text = '';
    year = 0;
  }

  void add() {
    final studentRef = ref.read(studentsRepositoryProvider.notifier);

    final int deposit = int.tryParse(depositControl.text) ?? 0;

    final student = Student(
      id: 'oid',
      firstName: firstNameControl.text,
      lastName: lastNameControl.text,
      job: jobControl.text,
      login: loginControl.text,
      year: year,
      title: 'M',
      deposit: deposit,
    );
    studentRef.addStudent(student);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double commonW = 160;
    final double commonH = 64;
    return Column(
      children: [
        StyledHeadline('Ajouter un élève'.hardcoded),
        gapH12,
        Row(
          children: [
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: firstNameControl,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.lock_outlined),
                child: StyledHeadline('Nom de \'élève'.hardcoded),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: lastNameControl,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.key),
                child: StyledHeadline('Nom de famille'.hardcoded),
              ),
            ),
          ],
        ),
        gapH12,
        Row(
          children: [
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: depositControl,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.tag),
                child: StyledHeadline('Amont d\'argent'.hardcoded),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: jobControl,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.luggage_outlined),
                child: StyledHeadline('Metier'.hardcoded),
              ),
            ),
          ],
        ),
        gapH12,
        Row(
          children: [
            SizedBox(
              width: commonW,
              height: commonH + 20,
              child: YearInput(
                year: getYear(year),
                onChanged: (value) {
                  setState(() {
                    year = value?.value ?? 0;
                  });
                },
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: loginControl,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.layers_sharp),
                child: StyledHeadline('Login'.hardcoded),
              ),
            ),
          ],
        ),
        gapH12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledButton(
              width: commonW,
              color: AppColors.secondaryAccent,
              onPressed: annulate,
              child: StyledText(
                'Annuler'.hardcoded,
                color: AppColors.primaryColor,
              ),
            ),
            gapW24,
            StyledButton(
              width: commonW,
              color: AppColors.secondaryAccent,
              onPressed: add,
              child: StyledText(
                'Ajouter'.hardcoded,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),

        gapH24,
      ],
    );
  }
}
