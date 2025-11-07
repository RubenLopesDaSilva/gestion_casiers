import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/features/students/presentation/widgets/student_item.dart';

class StudentSection extends StatelessWidget {
  const StudentSection({
    required this.title,
    this.students = const [],
    super.key,
  });

  final String title;
  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: StyledHeadline(title),
      shape: const Border(),
      tilePadding: const EdgeInsets.all(8.0),
      childrenPadding: const EdgeInsets.all(8.0),
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: students.length,
          itemBuilder: (context, index) {
            Student locker = students[index];
            return StudentItem(locker);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ],
    );
  }
}
