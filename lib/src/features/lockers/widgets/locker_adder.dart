import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/floor_input.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerAdder extends ConsumerStatefulWidget {
  const LockerAdder({super.key});

  @override
  ConsumerState<LockerAdder> createState() => _LockerAdderState();
}

class _LockerAdderState extends ConsumerState<LockerAdder> {
  final TextEditingController lockerController = TextEditingController();
  final TextEditingController lockController = TextEditingController();
  final MenuController floorController = MenuController();
  final TextEditingController keysController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  final TextEditingController studentnameController = TextEditingController();
  final TextEditingController studentjobController = TextEditingController();
  final TextEditingController cautionController = TextEditingController();

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

  void add() {
    //TODO : add
    // final lockerRef = ref.watch(lockersRepositoryProvider.notifier);

    // final int? number = int.tryParse(lockerController.text);
    // final int? keyCount = int.tryParse(keysController.text);
    // final int? lock = int.tryParse(lockController.text);

    // final locker = Locker(number: number, floor: floor, keyCount: keyCount, lockNumber: lock, responsable: jobController.text, lockerCondition: LockerCondition(), place: place)
    // lockerRef.addLocker(locker);
  }

  @override
  Widget build(BuildContext context) {
    final double commonW = 160;
    final double commonH = 40;
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
                child: StyledHeadline('No de Casier'.hardcoded),
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
              child: StyledTextfield(
                controller: lockController,
                color: AppColors.titleColor,
                prefixIcon: const Icon(Icons.tag),
                child: StyledHeadline('No de serrure'.hardcoded),
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
              height: commonH,
              child: FloorInput(
                floor: getFloor(floor),
                onChanged: (value) {
                  setState(() {
                    floor = value?.value ?? floor;
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
                child: StyledHeadline('Remarque (facultatif)'.hardcoded),
              ),
            ),
          ],
        ),
        gapH12,
        StyledButton(onPressed: add, child: StyledText('Ajouter'.hardcoded)),
        gapH24,
      ],
    );
  }
}
