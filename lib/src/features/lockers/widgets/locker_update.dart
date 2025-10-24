import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';

class LockerUpdate extends StatefulWidget {
  const LockerUpdate(this.locker, {this.student, super.key});

  final Locker locker;
  final Student? student;

  @override
  State<LockerUpdate> createState() => _LockerUpdateState();
}

class _LockerUpdateState extends State<LockerUpdate> {
  final TextEditingController lockerController = TextEditingController();
  final TextEditingController lockController = TextEditingController();
  final MenuController floorController = MenuController();
  final TextEditingController keysController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  final TextEditingController studentnameController = TextEditingController();
  final TextEditingController studentjobController = TextEditingController();
  final TextEditingController cautionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            StyledTextfield(
              controller: lockerController,
              textInputType: const TextInputType.numberWithOptions(),
              prefixIcon: const Icon(Icons.lock_outline),
              child: const Placeholder(),
            ),
            gapW24,
            StyledTextfield(
              controller: lockController,
              textInputType: const TextInputType.numberWithOptions(),
              prefixIcon: const Icon(Icons.abc),
              child: const Placeholder(),
            ),
            gapW24,
            const StyledText('floor'),
          ],
        ),
        Row(
          children: [
            StyledTextfield(
              controller: keysController,
              textInputType: const TextInputType.numberWithOptions(),
              prefixIcon: const Icon(Icons.lock_outline),
              child: const Placeholder(),
            ),
            gapW24,
            StyledTextfield(
              controller: jobController,
              textInputType: const TextInputType.numberWithOptions(),
              prefixIcon: const Icon(Icons.abc),
              child: const Placeholder(),
            ),
            gapW24,
            StyledTextfield(
              controller: detailController,
              textInputType: const TextInputType.numberWithOptions(),
              prefixIcon: const Icon(Icons.place_outlined),
              child: const Placeholder(),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(onPressed: annulate, child: Text('Annuler'.hardcoded)),
            gapW24,
            TextButton(onPressed: save, child: Text('Enregistrer'.hardcoded)),
          ],
        ),
        Row(
          children: widget.student == null
              ? [const StyledHeadline('None')]
              : [
                  StyledTextfield(controller: studentnameController),
                  gapW24,
                  StyledTextfield(controller: studentjobController),
                  gapW24,
                  StyledTextfield(controller: cautionController),
                ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    lockerController.dispose();
    lockController.dispose();
    keysController.dispose();
    jobController.dispose();
    detailController.dispose();

    studentnameController.dispose();
    studentjobController.dispose();
    cautionController.dispose();
    super.dispose();
  }

  void annulate() async {}

  void save() {}
}
