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
  bool? saved;

  @override
  void initState() {
    super.initState();
    saved = false;
    lockerController.text = widget.locker.number.toString();
    lockController.text = widget.locker.lockNumber.toString();
    // floorController.text = widget.locker.lockNumber.toString();
    keysController.text = widget.locker.keyCount.toString();
    jobController.text = widget.locker.responsable.toString();
    cautionController.text = widget.locker.studentId.toString();
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
              child: StyledTextfield(
                controller: lockerController,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.lock_outline),
                child: null,
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: lockController,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.abc),
                child: null,
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: TextEditingController(),
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.abc),
                child: null,
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
              child: StyledTextfield(
                controller: keysController,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.lock_outline),
                child: null,
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: jobController,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.abc),
                child: null,
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: detailController,
                textInputType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(Icons.place_outlined),
                child: null,
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
              onPressed: annulate,
              child: StyledText('Annuler'.hardcoded),
            ),
            gapW24,
            StyledButton(
              onPressed: save,
              child: StyledText('Enregistrer'.hardcoded),
            ),
          ],
        ),
        gapH24,
        Row(
          mainAxisSize: MainAxisSize.min,
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
    if (lockerController.text != widget.locker.number.toString() ||
        lockController.text != widget.locker.lockNumber.toString() ||
        // floorController.text != widget.locker.lockNumber.toString() ||
        keysController.text != widget.locker.keyCount.toString() ||
        jobController.text != widget.locker.responsable.toString() ||
        cautionController.text != widget.locker.studentId.toString()) {
      if (!(saved ?? true)) {
        print('are you sure');
      } else {
        print('already saved');
      }
    } else {
      print('no modifications');
    }

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

  void annulate() async {
    print('annulate');
  }

  void save() {
    saved = true;
    print('save');
  }
}
