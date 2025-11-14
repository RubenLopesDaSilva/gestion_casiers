import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text_form_field.dart';
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

  String floor = '';

  bool editing = false;

  @override
  void initState() {
    super.initState();
    setControllers();
  }

  @override
  void dispose() {
    lockerController.dispose();
    lockController.dispose();
    keysController.dispose();
    jobController.dispose();
    detailController.dispose();
    super.dispose();
  }

  void annulate() async {
    setControllers();
    setState(() {});
  }

  void changeMode() {
    if (lockerController.text == '' &&
        lockController.text == '' &&
        keysController.text == '' &&
        jobController.text == '' &&
        detailController.text == '' &&
        floor == '') {
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

  void setControllers() {
    lockerController.text = '';
    lockerController.addListener(changeMode);
    lockController.text = '';
    lockController.addListener(changeMode);
    keysController.text = '';
    keysController.addListener(changeMode);
    jobController.text = '';
    jobController.addListener(changeMode);
    detailController.text = '';
    detailController.addListener(changeMode);
    floor = '';
  }

  void add() {
    final lockerRef = ref.read(lockersRepositoryProvider.notifier);

    final int? number = int.tryParse(lockerController.text);
    final int? keyCount = int.tryParse(keysController.text);
    final int? lock = int.tryParse(lockController.text);

    final problem = detailController.text;
    final condition = LockerCondition(true, problems: problem);

    final job = jobController.text;

    if (number == null ||
        number < 0 ||
        keyCount == null ||
        lock == null ||
        job == '' ||
        floor == '') {
      setControllers();
      setState(() {});
    } else {
      final locker = Locker(
        number: number,
        floor: floor,
        keyCount: keyCount,
        lockNumber: lock,
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
              child: StyledTextFormField(
                controller: lockerController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.lock_outlined),
                autovalidateMode: editing
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                validator: (value) {
                  if (editing) {
                    final number = int.tryParse(value ?? '');
                    if (number == null) {
                      return 'Essayez de mettre un nombre'.hardcoded;
                    } else if (number < 0) {
                      return 'Seulement les nombres positif sont accepté'
                          .hardcoded;
                    }
                  }
                  return null;
                },
                child: StyledHeadline('No de Casier'.hardcoded),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextFormField(
                controller: keysController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.key),
                autovalidateMode: editing
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                validator: (value) {
                  final number = int.tryParse(value ?? '');
                  if (number == null) {
                    return 'Essayez de mettre un nombre'.hardcoded;
                  } else if (number < 0) {
                    return 'Seulement les nombres positif sont accepté'
                        .hardcoded;
                  }
                  return null;
                },
                child: StyledHeadline('Nombre de clé'.hardcoded),
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
              child: StyledTextFormField(
                controller: lockController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.tag),
                autovalidateMode: editing
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                validator: (value) {
                  final number = int.tryParse(value ?? '');
                  if (number == null) {
                    return 'Essayez de mettre un nombre'.hardcoded;
                  } else if (number < 0) {
                    return 'Seulement les nombres positif sont accepté'
                        .hardcoded;
                  }
                  return null;
                },
                child: StyledHeadline('No de serrure'.hardcoded),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextFormField(
                controller: jobController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.luggage_outlined),
                autovalidateMode: editing
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Essayez de mettre un metier'.hardcoded;
                  }
                  return null;
                },
                child: StyledHeadline('Metier'.hardcoded),
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
              child: StyledTextFormField(
                controller: detailController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.layers_sharp),
                autovalidateMode: editing
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                validator: (value) => null,
                child: StyledHeadline('Remarque (facultatif)'.hardcoded),
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
