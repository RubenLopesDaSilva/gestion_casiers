import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_profile_item.dart';
import 'package:gestion_casiers/src/features/students/data/student_repository.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:go_router/go_router.dart';

class LockerProfile extends StatefulWidget {
  const LockerProfile(this.lock, {super.key});

  final String? lock;

  @override
  State<LockerProfile> createState() => _LockerProfileState();
}

class _LockerProfileState extends State<LockerProfile> {
  final _placeController = TextEditingController();
  final _floorController = TextEditingController();
  final _numberController = TextEditingController();
  final _responsibleController = TextEditingController();
  final _ownerController = TextEditingController();
  final _keysController = TextEditingController();
  final _lockController = TextEditingController();

  void delete(Locker locker, LockerRepository repository) {
    repository.removeLocker(locker);
    context.pop();
  }

  void update(Locker locker, LockerRepository repository) {
    final number = int.tryParse(_numberController.text);
    final keyCount = int.tryParse(_keysController.text);
    final lock = int.tryParse(_lockController.text);
    Locker update = locker.copyWith(
      floor: _floorController.text,
      number: number,
      responsable: _responsibleController.text,
      keyCount: keyCount,
      lockNumber: lock,
      place: _placeController.text,
    );
    setState(() {
      repository.editLocker(locker.number, update);
      context.pop();
    });
  }

  @override
  void dispose() {
    _placeController.dispose();
    _floorController.dispose();
    _numberController.dispose();
    _responsibleController.dispose();
    _ownerController.dispose();
    _keysController.dispose();
    _lockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: StyledTitle('Locker Profile'.hardcoded)),
      body: Consumer(
        builder: (context, ref, child) {
          final repository = ref.watch(lockersRepositoryProvider.notifier);
          final studentRepository = ref.watch(
            studentsRepositoryProvider.notifier,
          );
          final locker = LockerRepository.lockersBox.values.firstWhere(
            (element) => widget.lock == element.lockNumber.toString(),
          );
          Locker lockerCopy = locker.copyWith();
          late Student? student = studentRepository.findStudentBy(
            id: lockerCopy.studentId,
          );
          _placeController.text = lockerCopy.place;
          _floorController.text = lockerCopy.floor;
          _numberController.text = lockerCopy.number.toString();
          _responsibleController.text = lockerCopy.responsable;
          _ownerController.text = student == null
              ? 'None'
              : '${student.firstName} ${student.lastName}';
          _keysController.text = lockerCopy.keyCount.toString();
          _lockController.text = lockerCopy.lockNumber.toString();
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsGeometry.all(30),
                  child: Column(
                    children: [
                      LockerProfileItem(
                        children: [
                          gapW32,
                          ProfilePart(
                            title: 'Location'.hardcoded,
                            controller: _placeController,
                            prefixIcon: Icon(
                              // Icons.place,
                              // Icons.location_city,
                              Icons.apartment,
                              color: AppColors.titleColor,
                            ),
                            description:
                                'In which batiment the locker is located'
                                    .hardcoded,
                          ),
                          gapW32,
                          ProfilePart(
                            title: 'Floor'.hardcoded,
                            controller: _floorController,
                            prefixIcon: Icon(
                              // Icons.layers,
                              Icons.stairs,
                              color: AppColors.titleColor,
                            ),
                            description: 'In which floor this locker is located'
                                .hardcoded,
                          ),
                          gapW32,
                          ProfilePart(
                            title: 'Number'.hardcoded,
                            controller: _numberController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              // Icons.inventory,
                              // Icons.inventory_2,
                              Icons.dns,
                              color: AppColors.titleColor,
                            ),
                            description:
                                'The number written on the locker'.hardcoded,
                          ),
                          gapW32,
                        ],
                      ),
                      gapH24,
                      LockerProfileItem(
                        children: [
                          gapW32,
                          ProfilePart(
                            title: 'Responsible'.hardcoded,
                            controller: _responsibleController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              // Icons.person,
                              // Icons.person_2,
                              // Icons.person_3,
                              // Icons.person_4,
                              Icons.badge,
                              color: AppColors.titleColor,
                            ),
                            description: 'Manager of the locker'.hardcoded,
                          ),
                          gapW32,
                          ProfilePart(
                            title: 'Owner'.hardcoded,
                            controller: _ownerController,
                            readOnly: true,
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColors.titleColor,
                            ),
                            description: 'He uses the locker'.hardcoded,
                          ),
                          gapW32,
                        ],
                      ),
                      gapH24,
                      LockerProfileItem(
                        children: [
                          gapW32,
                          ProfilePart(
                            title: 'Keys'.hardcoded,
                            controller: _keysController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              Icons.key,
                              color: AppColors.titleColor,
                            ),
                            description:
                                'the number of keys available for this lock in storage'
                                    .hardcoded,
                          ),
                          gapW32,
                          ProfilePart(
                            title: 'Lock'.hardcoded,
                            controller: _lockController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              // Icons.lock_open,
                              Icons.lock,
                              color: AppColors.titleColor,
                            ),
                            description: 'the key model reference for this lock'
                                .hardcoded,
                          ),
                          gapW32,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gapW12,
                  ExpandCenter(
                    child: StyledButton(
                      onPressed: () => delete(lockerCopy, repository),
                      child: StyledHeadline('Delete'.hardcoded),
                    ),
                  ),
                  gapW12,
                  ExpandCenter(
                    child: StyledButton(
                      onPressed: () => update(lockerCopy, repository),
                      child: StyledHeadline('Save'.hardcoded),
                    ),
                  ),
                  gapW12,
                ],
              ),
              gapH24,
            ],
          );
        },
      ),
    );
  }
}
