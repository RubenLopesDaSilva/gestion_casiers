import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker_condition.dart';
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
  bool researchOpen = false;
  List<Locker> researchDatas = [];
  String floor = 'd';
  bool floorOpen = false;
  List<Locker> floorDatas = [];
  int? researchIndex;
  int? floorIndex;

  void stateSetter(
    bool? rO,
    List<Locker>? rD,
    String? fl,
    bool? fO,
    List<Locker>? fD,
    int? rI,
    int? fI,
  ) {
    setState(() {
      researchOpen = rO ?? researchOpen;
      researchDatas = rD ?? researchDatas;
      floor = fl ?? floor;
      floorOpen = fO ?? floorOpen;
      floorDatas = fD ?? floorDatas;
      researchIndex = rI ?? researchIndex;
      floorIndex = fI ?? floorIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    researchDatas = widget.fakeDatas;
    floorDatas = widget.fakeDatas
        .where((element) => element.floor == floor)
        .toList();
    return Scaffold(
      body: CommonBody(
        location: AppRoute.lockers,
        body: Container(
          padding: const EdgeInsets.all(12.0),
          color: AppColors.primaryColor,
          child: Column(
            children: [
              LockerSection(
                researchOpen,
                open: () {
                  setState(() {
                    researchOpen = !researchOpen;
                  });
                },
                title: '${'Résultats de recherche'.hardcoded} (0)',
                selectedIndex: researchIndex,
                select: (int index) {
                  setState(() {
                    researchIndex = index;
                  });
                },
                lockers: researchDatas,
              ),
              LockerSection(
                floorOpen,
                open: () {
                  setState(() {
                    floorOpen = !floorOpen;
                  });
                },
                title: '${'Tous les casiers de l\'étage '.hardcoded}A',
                selectedIndex: floorIndex,
                select: (int index) {
                  setState(() {
                    floorIndex = index;
                  });
                },
                lockers: floorDatas,
              ),
              LockerSection(
                floorOpen,
                open: () {
                  setState(() {
                    floorOpen = !floorOpen;
                  });
                },
                title: '${'Tous les casiers de l\'étage '.hardcoded}B',
                selectedIndex: floorIndex,
                select: (int index) {
                  setState(() {
                    floorIndex = index;
                  });
                },
                lockers: floorDatas,
              ),
              // LockerSection(
              //   floorOpen,
              //   open: () {
              //     setState(() {
              //       floorOpen = !floorOpen;
              //     });
              //   },
              //   title: '${'Tous les casiers de l\'étage '.hardcoded}C',
              //   selectedIndex: floorIndex,
              //   select: (int index) {
              //     setState(() {
              //       floorIndex = index;
              //     });
              //   },
              //   lockers: floorDatas,
              // ),
              // LockerSection(
              //   floorOpen,
              //   open: () {
              //     setState(() {
              //       floorOpen = !floorOpen;
              //     });
              //   },
              //   title: '${'Tous les casiers de l\'étage '.hardcoded}D',
              //   selectedIndex: floorIndex,
              //   select: (int index) {
              //     setState(() {
              //       floorIndex = index;
              //     });
              //   },
              //   lockers: floorDatas,
              // ),
              // LockerSection(
              //   floorOpen,
              //   open: () {
              //     setState(() {
              //       floorOpen = !floorOpen;
              //     });
              //   },
              //   title: '${'Tous les casiers de l\'étage '.hardcoded}E',
              //   selectedIndex: floorIndex,
              //   select: (int index) {
              //     setState(() {
              //       floorIndex = index;
              //     });
              //   },
              //   lockers: floorDatas,
              // ),
              // LockerSection(
              //   floorOpen,
              //   open: () {
              //     setState(() {
              //       floorOpen = !floorOpen;
              //     });
              //   },
              //   title: '${'Tous les casiers de l\'étage '.hardcoded}F',
              //   selectedIndex: floorIndex,
              //   select: (int index) {
              //     setState(() {
              //       floorIndex = index;
              //     });
              //   },
              //   lockers: floorDatas,
              // ),
            ],
          ),
        ),
        panel: const Column(),
      ),
    );
  }
}
