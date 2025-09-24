import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/student_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/domain.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_profile_item.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_profile_part.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:go_router/go_router.dart';

class StudentProfile extends ConsumerStatefulWidget {
  const StudentProfile(this.id, {super.key});

  final String? id;

  @override
  ConsumerState<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends ConsumerState<StudentProfile> {
  final _loginController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _jobController = TextEditingController();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();

  void update(Student student, StudentRepository repository) {
    int? year = int.tryParse(_yearController.text);
    Student update = student.copyWith(
      login: _loginController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      job: _jobController.text,
      title: _titleController.text,
      year: year,
    );
    setState(() {
      repository.editStudent(student.id, update);
    });
    context.pop();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _jobController.dispose();
    _titleController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: StyledTitle('Student Profile'.hardcoded)),
      body: Consumer(
        builder: (context, ref, child) {
          final repository = ref.watch(studentsRepositoryProvider.notifier);
          final student = StudentRepository.studentsBox.values.firstWhere(
            (element) => widget.id == element.id,
          );
          Student studentCopy = student.copyWith();
          // late Locker? locker = repository.findStudentBy(
          //   id: studentCopy.studentId,
          // );
          _loginController.text = studentCopy.login;
          _firstNameController.text = studentCopy.firstName;
          _lastNameController.text = studentCopy.lastName;
          _jobController.text = studentCopy.job;
          _titleController.text = studentCopy.title;
          _yearController.text = studentCopy.year.toString();

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsGeometry.all(30),
                  child: Column(
                    children: [
                      LockerProfileItem(
                        children: [
                          LockerProfilePart(
                            title: 'Job'.hardcoded,
                            controller: _jobController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.titleColor,
                            ),
                            description:
                                'The initial of the job this student is learning'
                                    .hardcoded,
                          ),
                          gapW32,
                          LockerProfilePart(
                            title: 'Login'.hardcoded,
                            controller: _loginController,
                            prefixIcon: Icon(
                              Icons.place,
                              color: AppColors.titleColor,
                            ),
                            description:
                                'The login of the actual student'.hardcoded,
                          ),
                          gapW32,
                          LockerProfilePart(
                            title: 'Year'.hardcoded,
                            controller: _yearController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.titleColor,
                            ),
                            description: 'The actual year'.hardcoded,
                          ),
                          gapW32,
                        ],
                      ),
                      gapH24,
                      LockerProfileItem(
                        children: [
                          gapW32,
                          LockerProfilePart(
                            title: 'Title'.hardcoded,
                            controller: _titleController,
                            readOnly: true,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.titleColor,
                            ),
                            description: 'The genre of the student'.hardcoded,
                          ),
                          gapW32,
                          LockerProfilePart(
                            title: 'First Name'.hardcoded,
                            controller: _firstNameController,
                            prefixIcon: Icon(
                              Icons.flood,
                              color: AppColors.titleColor,
                            ),
                            description: 'His name'.hardcoded,
                          ),
                          gapW32,
                          LockerProfilePart(
                            title: 'Last Name'.hardcoded,
                            controller: _lastNameController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.titleColor,
                            ),
                            description: 'His family name'.hardcoded,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              StyledButton(
                onPressed: () => update(studentCopy, repository),
                child: StyledHeadline('Save'.hardcoded),
              ),
              gapH24,
            ],
          );
        },
      ),
    );
  }
}
