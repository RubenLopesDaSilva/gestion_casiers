import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBody(
        body: Container(
          padding: const EdgeInsets.all(8.0),
          color: AppColors.primaryColor,
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(value: false, onChanged: (able) {}),
                  const Text('Selectionner tout'),
                ],
              ),
              Expanded(child: ListView(children: [])),
            ],
          ),
        ),
        panel: const Column(),
      ),
    );
  }
}
