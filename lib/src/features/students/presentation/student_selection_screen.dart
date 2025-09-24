import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/students/data/student_repository.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/student_inner_item.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';

import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:go_router/go_router.dart';

class StudentSelectionScreen extends StatefulWidget {
  const StudentSelectionScreen({super.key});

  @override
  State<StudentSelectionScreen> createState() => _StudentSelectionScreenState();
}

class _StudentSelectionScreenState extends State<StudentSelectionScreen> {
  Function selectStudent(Student? student) {
    return () {
      context.pop<(bool error, String? id)?>((false, student?.id));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Selection Screen'.hardcoded)),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gapH12,
            StyledHeadline('Students'.hardcoded),
            gapH16,
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 40.0,
                  right: 40.0,
                  bottom: 40.0,
                ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.elliptical(75, 50),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: StudentInnerItem(
                        student: Student(
                          id: 'identification'.hardcoded,
                          firstName: 'firstName'.hardcoded,
                          lastName: 'lastName'.hardcoded,
                          job: 'job'.hardcoded,
                          login: 'login'.hardcoded,
                          year: 0,
                          title: 'title'.hardcoded,
                        ),
                        onTap: () {},
                      ),
                    ),
                    gapH24,
                    Consumer(
                      builder: (context, ref, child) {
                        final students = StudentRepository.studentsBox.values;
                        List<Student?> data = [null, ...students];
                        return Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(30),
                            itemCount: data.length,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) => gapH24,
                            itemBuilder: (context, index) {
                              Student? student = data[index];
                              return StudentInnerItem(
                                student: student,
                                onTap: selectStudent(student),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
