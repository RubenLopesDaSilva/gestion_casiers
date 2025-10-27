import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_search_bar.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/common_widgets/csv_import.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker_condition.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/locker_adder.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/locker_section.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerScreen extends StatefulWidget {
  const LockerScreen({super.key});

  final List<Locker> fakeDatas = const [
    Locker(
      number: 123,
      floor: 'd',
      keyCount: 21,
      lockNumber: 243234,
      responsable: 'JAB',
      lockerCondition: LockerCondition(true),
      place: 'batiment old',
    ),
    Locker(
      number: 234,
      floor: 'a',
      keyCount: 0,
      lockNumber: 243234,
      responsable: 'JAB',
      lockerCondition: LockerCondition(true),
      place: 'batiment old',
    ),
    Locker(
      number: 45,
      floor: 'o',
      keyCount: 4,
      lockNumber: 435,
      responsable: 'JAB',
      lockerCondition: LockerCondition(true),
      place: 'batiment old',
    ),
  ];

  @override
  State<LockerScreen> createState() => _LockerScreenState();
}

class _LockerScreenState extends State<LockerScreen> {
  List<Locker> researchDatas = [];
  List<Locker> floorDatas = [];

  @override
  Widget build(BuildContext context) {
    researchDatas = widget.fakeDatas;
    floorDatas = widget.fakeDatas;
    return Scaffold(
      body: CommonBody(
        location: AppRoute.lockers,
        body: Container(
          padding: const EdgeInsets.all(12.0),
          color: AppColors.primaryColor,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            // children: Column(
            children: [
              LockerSection(
                title: '${'Résultats de recherche'.hardcoded} (0)',
                lockers: researchDatas,
              ),
              LockerSection(
                title: '${'Tous les casiers de l\'étage '.hardcoded}A',
                lockers: floorDatas,
              ),
              LockerSection(
                title: '${'Tous les casiers de l\'étage '.hardcoded}B',
                lockers: floorDatas,
              ),
              LockerSection(
                title: '${'Tous les casiers de l\'étage '.hardcoded}C',
                lockers: floorDatas,
              ),
              LockerSection(
                title: '${'Tous les casiers de l\'étage '.hardcoded}D',
                lockers: floorDatas,
              ),
              LockerSection(
                title: '${'Tous les casiers de l\'étage '.hardcoded}E',
                lockers: floorDatas,
              ),
              LockerSection(
                title: '${'Tous les casiers de l\'étage '.hardcoded}F',
                lockers: floorDatas,
              ),
            ],
            // ),
          ),
        ),
        panel: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CommonSearchBar(
                title: 'Rechercher un casier'.hardcoded,
                research: (text) {
                  print(text.toString());
                },
              ),
              const Divider(indent: 24.0, endIndent: 24.0, height: 40),
              const LockerAdder(),
              gapH12,
              CsvImport((platformFile) {
                print(platformFile?.name);
                // setState(() {
                //   lockerRef.setLockers(
                //     importLockersFrom(
                //       Excel.decodeBytes(result.files.single.bytes!.toList()),
                //     ),
                //   );
                // });
              }),
              Center(child: StyledText('Change Floor'.hardcoded)),
            ],
          ),
        ),
      ),
    );
  }
}
