import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerAdder extends StatefulWidget {
  const LockerAdder({super.key});

  @override
  State<LockerAdder> createState() => _LockerAdderState();
}

class _LockerAdderState extends State<LockerAdder> {
  final TextEditingController lockerController = TextEditingController();
  final TextEditingController lockController = TextEditingController();
  final MenuController floorController = MenuController();
  final TextEditingController keysController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  final TextEditingController studentnameController = TextEditingController();
  final TextEditingController studentjobController = TextEditingController();
  final TextEditingController cautionController = TextEditingController();
  bool? added;

  @override
  void initState() {
    super.initState();
    added = false;
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
                color: AppColors.primaryAccent,
                prefixIcon: const Icon(Icons.lock_outlined),
                child: StyledHeadline('No de Casier'.hardcoded),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: lockController,
                color: AppColors.primaryAccent,
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
                controller: TextEditingController(),
                color: AppColors.primaryAccent,
                prefixIcon: const Icon(Icons.tag),
                child: StyledHeadline('No de serrure'.hardcoded),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: keysController,
                color: AppColors.primaryAccent,
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
              child: StyledTextfield(
                controller: jobController,
                color: AppColors.primaryAccent,
                prefixIcon: const Icon(Icons.calendar_today_outlined),
                child: StyledHeadline('Étage...'.hardcoded),
              ),
            ),
            gapW24,
            SizedBox(
              width: commonW,
              height: commonH,
              child: StyledTextfield(
                controller: detailController,
                color: AppColors.primaryAccent,
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

  @override
  void dispose() {
    if (lockerController.text != '' ||
        lockController.text != '' ||
        // floorController.text != '' ||
        keysController.text != '' ||
        jobController.text != '' ||
        cautionController.text != '') {
      if (!(added ?? true)) {
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

  void add() {
    added = true;
    print('add');
  }
}
