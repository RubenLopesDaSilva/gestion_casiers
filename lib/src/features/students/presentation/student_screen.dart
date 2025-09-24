import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/student_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/domain.dart';
import 'package:gestion_casiers/src/features/students/presentation/student_item.dart';
import 'package:gestion_casiers/src/features/students/presentation/student_item_titles.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:gestion_casiers/utils/import_excel.dart';
import 'package:go_router/go_router.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  void studentProfile(Student student) async {
    await context.pushNamed(
      AppRoute.studentprofile.name,
      pathParameters: {'id': student.id},
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<void> lockerScreen() async {
      context.goNamed(AppRoute.simple.name);
    }

    return Scaffold(
      appBar: AppBar(title: StyledTitle('Student Screen'.hardcoded)),
      body: SizedBox(
        width: double.infinity,
        child: Consumer(
          builder: (context, value, child) {
            final ref = value.watch(studentsRepositoryProvider.notifier);
            final students = StudentRepository.studentsBox.values.toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapH12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StyledButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles();
                        if (result != null) {
                          setState(() {
                            ref.setStudents(
                              importStudentsFrom(
                                Excel.decodeBytes(
                                  result.files.single.bytes!.toList(),
                                ),
                              ),
                            );
                          });
                        }
                      },
                      child: const StyledHeadline('Import Students'),
                    ),
                    gapW16,
                    StyledButton(
                      onPressed: lockerScreen,
                      child: const StyledHeadline('Go to lockers'),
                    ),
                  ],
                ),
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
                      color: AppColors.primaryAccent,
                      borderRadius: const BorderRadius.all(
                        Radius.elliptical(60, 40),
                      ),
                    ),
                    child: Column(
                      children: [
                        const StudentItemTitles(),
                        gapH24,
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(30),
                            itemCount: students.length,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) => gapH24,
                            itemBuilder: (context, index) {
                              Student student = students[index];
                              return StudentItem(
                                student: student,
                                profile: studentProfile,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
