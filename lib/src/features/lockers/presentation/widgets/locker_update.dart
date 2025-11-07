import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/common_widgets/input_error.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/widgets/floor_input.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerUpdate extends ConsumerStatefulWidget {
  const LockerUpdate(this.locker, {this.student, super.key});

  final Locker locker;
  final Student? student;

  @override
  ConsumerState<LockerUpdate> createState() => _LockerUpdateState();
}

class _LockerUpdateState extends ConsumerState<LockerUpdate> {
  final TextEditingController lockerController = TextEditingController();
  final TextEditingController lockController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController keysController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  final TextEditingController studentnameController = TextEditingController();
  final TextEditingController studentjobController = TextEditingController();
  final TextEditingController cautionController = TextEditingController();

  final error = InputError<String, String?>();

  String floor = '';

  bool editing = false;

  @override
  void initState() {
    super.initState();
    setControllers();
    studentnameController.text = widget.student?.firstName ?? '';
    studentjobController.text = widget.student?.job ?? '';
    cautionController.text = widget.student?.deposit.toString() ?? '';
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

  void setControllers() {
    error.clear();
    lockerController.text = widget.locker.number.toString();
    lockerController.addListener(changeMode);
    lockController.text = widget.locker.lockNumber.toString();
    lockController.addListener(changeMode);
    keysController.text = widget.locker.keyCount.toString();
    keysController.addListener(changeMode);
    jobController.text = widget.locker.responsable.toString();
    jobController.addListener(changeMode);
    detailController.text = widget.locker.lockerCondition.problems ?? '';
    detailController.addListener(changeMode);
    floor = widget.locker.floor;
  }

  void annulate() async {
    setControllers();
    setState(() {});
  }

  void changeMode() {
    if (lockerController.text == widget.locker.number.toString() &&
        lockController.text == widget.locker.lockNumber.toString() &&
        keysController.text == widget.locker.keyCount.toString() &&
        jobController.text == widget.locker.responsable.toString() &&
        detailController.text ==
            (widget.locker.lockerCondition.problems ?? '') &&
        floor == widget.locker.floor) {
      if (editing) {
        setState(() {
          editing = false;
        });
      }
    } else {
      if (!editing) {
        setState(() {
          editing = true;
        });
      }
    }
  }

  void delete() {
    final lockerRef = ref.read(lockersRepositoryProvider.notifier);
    lockerRef.removeLocker(widget.locker);
  }

  void save() {
    error.clear();

    final lockerRef = ref.read(lockersRepositoryProvider.notifier);

    final int? number = int.tryParse(lockerController.text);
    final int? keyCount = int.tryParse(keysController.text);
    final int? lock = int.tryParse(lockController.text);

    final condition = widget.locker.lockerCondition;
    final problem = detailController.text;
    final String job = jobController.text;

    if (number == null) {
      error.setEntry(
        'lockerControl',
        'le numeros doit être un nombre'.hardcoded,
      );
    } else if (number < 0) {
      error.setEntry(
        'lockerControl',
        'le numeros du casier doit être positif'.hardcoded,
      );
    }

    if (keyCount == null) {
      error.setEntry('keysControl', 'le numeros doit être un nombre'.hardcoded);
    } else if (keyCount < 0) {
      error.setEntry(
        'keysControl',
        'le numeros du casier doit être positif'.hardcoded,
      );
    }

    if (lock == null) {
      error.setEntry('lockControl', 'le numeros doit être un nombre'.hardcoded);
    } else if (lock < 0) {
      error.setEntry(
        'lockControl',
        'le numeros du casier doit être positif'.hardcoded,
      );
    }

    if (job == '') {
      error.setEntry('jobControl', 'il faut mettre un métier'.hardcoded);
    }

    if (floor == '') {
      error.setEntry(
        'floorControl',
        'l\'étage doit être different de null'.hardcoded,
      );
    }

    if (error.error) {
      setState(() {});
    } else {
      Locker update = widget.locker.copyWith(
        number: number,
        responsable: jobController.text,
        keyCount: keyCount,
        lockNumber: lock,
        lockerCondition: condition.copyWith(problems: problem),
        floor: floor,
      );
      lockerRef.editLocker(widget.locker.number, update);
      setState(() {});
    }
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
                child: error.errorMessage(
                  inputName: 'lockerControl',
                  child: (errorMsg) => StyledHeadline(
                    errorMsg.toString(),
                    color: AppColors.alertColor,
                  ),
                ),
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
                child: error.errorMessage(
                  inputName: 'lockControl',
                  child: (errorMsg) => StyledHeadline(
                    errorMsg.toString(),
                    color: AppColors.alertColor,
                  ),
                ),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: FloorInput(
                floor: getFloor(floor),
                onChanged: (value) {
                  setState(() {
                    floor = value?.name ?? '';
                  });
                },
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
                child: error.errorMessage(
                  inputName: 'keysControl',
                  child: (errorMsg) => StyledHeadline(
                    errorMsg.toString(),
                    color: AppColors.alertColor,
                  ),
                ),
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
                child: error.errorMessage(
                  inputName: 'jobControl',
                  child: (errorMsg) => StyledHeadline(
                    errorMsg.toString(),
                    color: AppColors.alertColor,
                  ),
                ),
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
                child: error.errorMessage(
                  inputName: 'detailControl',
                  child: (errorMsg) => StyledHeadline(
                    errorMsg.toString(),
                    color: AppColors.alertColor,
                  ),
                ),
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
              color: AppColors.secondaryAccent,
              onPressed: editing ? annulate : delete,
              child: StyledText(
                (editing ? 'Annuler' : 'Delete').hardcoded,
                color: AppColors.primaryColor,
              ),
            ),
            gapW24,
            StyledButton(
              color: AppColors.secondaryAccent,
              onPressed: save,
              child: StyledText(
                'Enregistrer'.hardcoded,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        gapH24,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.student == null
              ? [const StyledHeadline('None')]
              : [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: StyledTextfield(controller: studentnameController),
                  ),
                  gapW24,
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: StyledTextfield(controller: studentjobController),
                  ),
                  gapW24,
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: StyledTextfield(
                      controller: cautionController,
                      readOnly: true,
                    ),
                  ),
                ],
        ),
      ],
    );
  }
}
