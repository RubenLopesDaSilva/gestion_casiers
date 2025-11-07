import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_search_bar.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/common_widgets/import_plateform_file.dart';
import 'package:gestion_casiers/src/common_widgets/selection_menu.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/floor_input.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/locker_adder.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/locker_section.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:gestion_casiers/src/utils/import_excel.dart';

class LockerScreen extends ConsumerStatefulWidget {
  const LockerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LockerScreenState();
}

class _LockerScreenState extends ConsumerState<LockerScreen> {
  final List<Widget> children = [];
  String? searchText;

  @override
  Widget build(BuildContext context) {
    Map<String, GlobalKey> map = {};
    final lockerRef = ref.watch(lockersRepositoryProvider.notifier);
    final searchResult = lockerRef.searchLockers(searchText);
    children.clear();
    if (searchResult.isNotEmpty) {
      GlobalKey key = GlobalKey();
      map['?'] = key;
      children.add(
        LockerSection(
          key: key,
          title:
              '${'Résultats de recherche'.hardcoded} (${searchResult.length})',
          lockers: searchResult,
        ),
      );
    }
    children.add(
      searchResult.isNotEmpty
          ? LockerSection(
              title:
                  '${'Résultats de recherche'.hardcoded} (${searchResult.length})',
              lockers: searchResult,
            )
          : const SizedBox(),
    );
    for (Floor value in Floor.values) {
      GlobalKey key = GlobalKey();
      map[value.name] = key;
      children.add(
        LockerSection(
          key: key,
          title: '${'Tous les casiers de l\'étage '.hardcoded}${value.name}',
          lockers: lockerRef.getLockerFrom(value.name),
        ),
      );
    }

    return Scaffold(
      body: CommonBody(
        body: Container(
          padding: const EdgeInsets.all(12.0),
          color: AppColors.primaryColor,
          child: Column(
            children: [
              SelectionMenu(
                options: map,
                select: (key) {
                  print(
                    'click \n key: $key \n context: ${key?.currentContext}',
                  );
                  if (key?.currentContext case BuildContext context) {
                    Scrollable.ensureVisible(
                      context,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  }
                },
                children: (a) {
                  print('$a');
                  return Center(child: StyledText(a));
                },
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: children,
                  // children: [
                  //   searchResult.isNotEmpty
                  //       ? LockerSection(
                  //           title:
                  //               '${'Résultats de recherche'.hardcoded} (${searchResult.length})',
                  //           lockers: searchResult,
                  //         )
                  //       : const SizedBox(),
                  //   LockerSection(
                  //     title: '${'Tous les casiers de l\'étage '.hardcoded}B',
                  //     lockers: lockerRef.getLockerFrom('b'),
                  //   ),
                  //   LockerSection(
                  //     title: '${'Tous les casiers de l\'étage '.hardcoded}C',
                  //     lockers: lockerRef.getLockerFrom('c'),
                  //   ),
                  //   LockerSection(
                  //     title: '${'Tous les casiers de l\'étage '.hardcoded}D',
                  //     lockers: lockerRef.getLockerFrom('d'),
                  //   ),
                  //   LockerSection(
                  //     title: '${'Tous les casiers de l\'étage '.hardcoded}E',
                  //     lockers: lockerRef.getLockerFrom('e'),
                  //   ),
                  // ],
                ),
              ),
            ],
          ),
        ),
        panel: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CommonSearchBar(
                title: 'Rechercher un casier'.hardcoded,
                research: (text) {
                  setState(() {
                    searchText = text;
                  });
                },
              ),
              const Divider(indent: 24.0, endIndent: 24.0, height: 40),
              const LockerAdder(),
              gapH12,
              ImportPlatformFile((platformFile) {
                setState(() {
                  if (platformFile?.bytes case Uint8List datas) {
                    lockerRef.setLockers(
                      importLockersFrom(Excel.decodeBytes(datas.toList())),
                    );
                  }
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
