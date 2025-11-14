import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_search_bar.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/common_widgets/import_plateform_file.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/students/data/student_repository.dart';
import 'package:gestion_casiers/src/features/students/presentation/widgets/student_add.dart';
import 'package:gestion_casiers/src/features/students/presentation/widgets/student_section.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:gestion_casiers/src/utils/import_excel.dart';

class StudentScreen extends ConsumerStatefulWidget {
  const StudentScreen({super.key});

  @override
  ConsumerState<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends ConsumerState<StudentScreen> {
  String? searchText;

  @override
  Widget build(BuildContext context) {
    final studentRef = ref.watch(studentsRepositoryProvider.notifier);
    final searchResult = studentRef.searchStudents(value: searchText);
    return Scaffold(
      body: CommonBody(
        body: Container(
          padding: const EdgeInsets.all(12.0),
          color: AppColors.primaryColor,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              searchResult.isNotEmpty
                  ? StudentSection(
                      title:
                          '${'Résultats de recherche'.hardcoded} (${searchResult.length})',
                      students: searchResult,
                    )
                  : const SizedBox(),
              StudentSection(
                title: '${'Tous les élèves de l\'anné'.hardcoded} 1',
                students: studentRef.getStudentsFrom(1),
              ),
              StudentSection(
                title: '${'Tous les élèves de l\'anné'.hardcoded} 2',
                students: studentRef.getStudentsFrom(2),
              ),
              StudentSection(
                title: '${'Tous les élèves de l\'anné'.hardcoded} 3',
                students: studentRef.getStudentsFrom(3),
              ),
              StudentSection(
                title: '${'Tous les élèves de l\'anné'.hardcoded} 4',
                students: studentRef.getStudentsFrom(4),
              ),
            ],
          ),
        ),
        panel: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CommonSearchBar(
                title: 'Rechercher un élève'.hardcoded,
                research: (text) {
                  setState(() {
                    searchText = text;
                  });
                },
              ),
              gapH24,
              const StudentAdd(),
              gapH12,
              ImportPlatformFile((platformFile) {
                setState(() {
                  if (platformFile?.bytes case Uint8List datas) {
                    studentRef.setStudents(
                      importStudentsFrom(Excel.decodeBytes(datas.toList())),
                    );
                  }
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
