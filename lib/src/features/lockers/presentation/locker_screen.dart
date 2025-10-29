import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_search_bar.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/common_widgets/csv_import.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/locker_adder.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/locker_section.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerScreen extends StatefulWidget {
  const LockerScreen({super.key});

  @override
  State<LockerScreen> createState() => _LockerScreenState();
}

class _LockerScreenState extends State<LockerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBody(
        body: Container(
          padding: const EdgeInsets.all(12.0),
          color: AppColors.primaryColor,
          child: Consumer(
            builder: (context, ref, child) {
              final lockerRef = ref.watch(lockersRepositoryProvider.notifier);
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  LockerSection(
                    title: '${'Résultats de recherche'.hardcoded} (0)',
                    lockers: lockerRef.getLockerFrom('a'),
                  ),
                  LockerSection(
                    title: '${'Tous les casiers de l\'étage '.hardcoded}A',
                    lockers: lockerRef.getLockerFrom('a'),
                  ),
                  LockerSection(
                    title: '${'Tous les casiers de l\'étage '.hardcoded}B',
                    lockers: lockerRef.getLockerFrom('b'),
                  ),
                  LockerSection(
                    title: '${'Tous les casiers de l\'étage '.hardcoded}C',
                    lockers: lockerRef.getLockerFrom('c'),
                  ),
                  LockerSection(
                    title: '${'Tous les casiers de l\'étage '.hardcoded}D',
                    lockers: lockerRef.getLockerFrom('d'),
                  ),
                  LockerSection(
                    title: '${'Tous les casiers de l\'étage '.hardcoded}E',
                    lockers: lockerRef.getLockerFrom('e'),
                  ),
                  LockerSection(
                    title: '${'Tous les casiers de l\'étage '.hardcoded}F',
                    lockers: lockerRef.getLockerFrom('f'),
                  ),
                ],
              );
            },
          ),
        ),
        panel: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CommonSearchBar(
                title: 'Rechercher un casier'.hardcoded,
                research: (text) {
                  //TODO : Research
                },
              ),
              const Divider(indent: 24.0, endIndent: 24.0, height: 40),
              const LockerAdder(),
              gapH12,
              CsvImport((platformFile) {
                //TODO : import excel
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
