import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/common_widgets/input_error.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker_condition.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/widgets/floor_input.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerAdd extends ConsumerStatefulWidget {
  const LockerAdd({super.key});

  @override
  ConsumerState<LockerAdd> createState() => _LockerAdderState();
}

class _LockerAdderState extends ConsumerState<LockerAdd> {
  final TextEditingController lockerController = TextEditingController();
  final TextEditingController lockController = TextEditingController();
  final MenuController floorController = MenuController();
  final TextEditingController keysController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  final TextEditingController studentnameController = TextEditingController();
  final TextEditingController studentjobController = TextEditingController();
  final TextEditingController cautionController = TextEditingController();

  final error = InputError<String, String?>();

  String floor = '';

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

  void setControllers() {
    error.clear();
    lockerController.text = '';
    lockController.text = '';
    keysController.text = '';
    jobController.text = '';
    detailController.text = '';
    floor = '';
  }

  void add() {
    error.clear();

    final lockerRef = ref.read(lockersRepositoryProvider.notifier);

    final int? number = int.tryParse(lockerController.text);
    final int? keyCount = int.tryParse(keysController.text);
    final int? lock = int.tryParse(lockController.text);

    final problem = detailController.text;
    final condition = LockerCondition(true, problems: problem);

    final job = jobController.text;

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
      final locker = Locker(
        number: number!,
        floor: floor,
        keyCount: keyCount!,
        lockNumber: lock!,
        responsable: job,
        lockerCondition: condition,
        place: '',
      );
      lockerRef.addLocker(locker);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final double commonW = 160;
    final double commonH = 64;
    return Column(
      children: [
        StyledHeadline('Ajouter un casier'.hardcoded),
        gapH12,
        Row(
          children: [
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: lockerController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.lock_outlined),
                child:
                    error.errorMessage(
                      inputName: 'lockerControl',
                      child: (errorMsg) => StyledHeadline(
                        errorMsg.toString(),
                        color: AppColors.alertColor,
                      ),
                    ) ??
                    StyledHeadline('No de Casier'.hardcoded),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: keysController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.key),
                child:
                    error.errorMessage(
                      inputName: 'keysControl',
                      child: (errorMsg) => StyledHeadline(
                        errorMsg.toString(),
                        color: AppColors.alertColor,
                      ),
                    ) ??
                    StyledHeadline('Nombre de clé'.hardcoded),
              ),
            ),
          ],
        ),
        gapH12,
        Row(
          children: [
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: lockController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.tag),
                child:
                    error.errorMessage(
                      inputName: 'lockControl',
                      child: (errorMsg) => StyledHeadline(
                        errorMsg.toString(),
                        color: AppColors.alertColor,
                      ),
                    ) ??
                    StyledHeadline('No de serrure'.hardcoded),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: jobController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.luggage_outlined),
                child:
                    error.errorMessage(
                      inputName: 'jobControl',
                      child: (errorMsg) => StyledHeadline(
                        errorMsg.toString(),
                        color: AppColors.alertColor,
                      ),
                    ) ??
                    StyledHeadline('Metier'.hardcoded),
              ),
            ),
          ],
        ),
        gapH12,
        Row(
          children: [
            SizedBox(
              width: commonW,
              height: commonH + 20,
              child: FloorInput(
                floor: getFloor(floor),
                onChanged: (value) {
                  setState(() {
                    floor = value?.name ?? '';
                  });
                },
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: detailController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.layers_sharp),
                child:
                    error.errorMessage(
                      inputName: 'detailControl',
                      child: (errorMsg) => StyledHeadline(
                        errorMsg.toString(),
                        color: AppColors.alertColor,
                      ),
                    ) ??
                    StyledHeadline('Remarque (facultatif)'.hardcoded),
              ),
            ),
          ],
        ),
        gapH12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledButton(
              width: commonW,
              color: AppColors.secondaryAccent,
              onPressed: annulate,
              child: StyledText(
                'Annuler'.hardcoded,
                color: AppColors.primaryColor,
              ),
            ),
            gapW24,
            StyledButton(
              width: commonW,
              color: AppColors.secondaryAccent,
              onPressed: add,
              child: StyledText(
                'Ajouter'.hardcoded,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),

        gapH24,
      ],
    );
  }
}
