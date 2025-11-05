import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/floor_input.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';

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
  String? floor;

  @override
  void initState() {
    super.initState();
    setControllers();
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

  void annulate() async {
    setControllers();
    setState(() {});
  }

  void save() {
    final lockerRef = ref.watch(lockersRepositoryProvider.notifier);

    final int? number = int.tryParse(lockerController.text);
    final int? keyCount = int.tryParse(keysController.text);
    final int? lock = int.tryParse(lockController.text);

    Locker update = widget.locker.copyWith(
      number: number,
      responsable: jobController.text,
      keyCount: keyCount,
      lockNumber: lock,
      lockerCondition: widget.locker.lockerCondition.copyWith(
        comments: detailController.text,
      ),
      floor: floor,
    );

    lockerRef.editLocker(widget.locker.number, update);
  }

  void setControllers() {
    lockerController.text = widget.locker.number.toString();
    lockController.text = widget.locker.lockNumber.toString();
    keysController.text = widget.locker.keyCount.toString();
    jobController.text = widget.locker.responsable.toString();
    detailController.text = widget.locker.lockerCondition.comments ?? '';
    floor = widget.locker.floor;
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
              child: FloorInput(
                floor: getFloor(floor),
                onChanged: (value) {
                  setState(() {
                    floor = value?.name;
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
}
