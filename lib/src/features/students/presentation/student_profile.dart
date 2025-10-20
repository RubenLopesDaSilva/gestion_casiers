import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_profile_item.dart';
import 'package:gestion_casiers/src/features/students/data/student_repository.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:go_router/go_router.dart';

class StudentProfile extends ConsumerStatefulWidget {
  const StudentProfile(this.studentId, {super.key});

  final String? studentId;

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

  void add(StudentRepository repository) {
    int? year = int.tryParse(_yearController.text);
    repository.addStudent(
      Student(
        id: 'id',
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        job: _jobController.text,
        login: _loginController.text,
        year: year!,
        title: _titleController.text,
        deposit: 0,
      ),
    );
    context.pop();
  }

  void delete(Student student, StudentRepository repository) {
    repository.removeStudent(student.id);
    context.pop();
  }

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
          final Student? student = widget.studentId == null
              ? null
              : StudentRepository.studentsBox.values.firstWhere(
                  (element) => widget.studentId == element.id,
                );
          Student? studentCopy = student?.copyWith();
          if (studentCopy == null) {
            _loginController.text = 'THe login of the student'.hardcoded;
            _firstNameController.text = 'He\' first name'.hardcoded;
            _lastNameController.text = 'He\'s family name'.hardcoded;
            _jobController.text = 'What learns the student'.hardcoded;
            _titleController.text = 'Write the title for the student'.hardcoded;
            _yearController.text =
                'How manny years has the student already studied'.hardcoded;
          } else {
            // late Locker? locker = repository.findStudentBy(
            //   id: studentCopy.studentId,
            // );
            _loginController.text = studentCopy.login;
            _firstNameController.text = studentCopy.firstName;
            _lastNameController.text = studentCopy.lastName;
            _jobController.text = studentCopy.job;
            _titleController.text = studentCopy.title;
            _yearController.text = studentCopy.year.toString();
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsGeometry.all(30),
                  child: Column(
                    children: [
                      LockerProfileItem(
                        children: [
                          ProfilePart(
                            title: 'Job'.hardcoded,
                            controller: _jobController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              // Icons.badge,
                              Icons.work,
                              color: AppColors.titleColor,
                            ),
                            description:
                                'The initial of the job this student is learning'
                                    .hardcoded,
                          ),
                          gapW32,
                          ProfilePart(
                            title: 'Login'.hardcoded,
                            controller: _loginController,
                            prefixIcon: Icon(
                              // Icons.person,
                              // Icons.logout,
                              Icons.login,
                              color: AppColors.titleColor,
                            ),
                            description:
                                'The login of the actual student'.hardcoded,
                          ),
                          gapW32,
                          ProfilePart(
                            title: 'Year'.hardcoded,
                            controller: _yearController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              // Icons.hourglass_bottom,
                              // Icons.hourglass_disabled,
                              Icons.hourglass_empty,
                              // Icons.hourglass_full,
                              // Icons.hourglass_top,
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
                          ProfilePart(
                            title: 'Title'.hardcoded,
                            controller: _titleController,
                            readOnly: true,
                            prefixIcon: Icon(
                              // Icons.person,
                              Icons.badge,
                              color: AppColors.titleColor,
                            ),
                            description: 'The genre of the student'.hardcoded,
                          ),
                          gapW32,
                          ProfilePart(
                            title: 'First Name'.hardcoded,
                            controller: _firstNameController,
                            prefixIcon: Icon(
                              // Icons.face,
                              Icons.person,
                              color: AppColors.titleColor,
                            ),
                            description: 'His name'.hardcoded,
                          ),
                          gapW32,
                          ProfilePart(
                            title: 'Last Name'.hardcoded,
                            controller: _lastNameController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              // Icons.person_off,
                              Icons.account_box,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: studentCopy == null
                    ? [
                        ExpandCenter(
                          child: StyledButton(
                            onPressed: () => add(repository),
                            child: StyledHeadline('Add'.hardcoded),
                          ),
                        ),
                      ]
                    : [
                        gapW12,
                        ExpandCenter(
                          child: StyledButton(
                            onPressed: () => delete(studentCopy, repository),
                            child: StyledHeadline('Delete'.hardcoded),
                          ),
                        ),
                        gapW12,
                        ExpandCenter(
                          child: StyledButton(
                            onPressed: () => update(studentCopy, repository),
                            child: StyledHeadline('Save'.hardcoded),
                          ),
                        ),
                        gapW12,
                      ],
              ),
              gapH24,
            ],
          );
        },
      ),
    );
  }
}
