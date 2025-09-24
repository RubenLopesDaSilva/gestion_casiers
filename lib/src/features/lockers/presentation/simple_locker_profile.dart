import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/styled_button.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/students/data/student_repository.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_profile_item.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_profile_part.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:go_router/go_router.dart';

class SimpleLockerProfile extends StatefulWidget {
  const SimpleLockerProfile(this.lock, {super.key});

  final String? lock;

  @override
  State<SimpleLockerProfile> createState() => _SimpleLockerProfileState();
}

class _SimpleLockerProfileState extends State<SimpleLockerProfile> {
  final _placeController = TextEditingController();
  final _floorController = TextEditingController();
  final _numberController = TextEditingController();
  final _responsibleController = TextEditingController();
  final _ownerController = TextEditingController();
  final _keysController = TextEditingController();
  final _lockController = TextEditingController();

  void update(Locker locker) {
    final number = int.tryParse(_numberController.text);
    final keyCount = int.tryParse(_keysController.text);
    final lock = int.tryParse(_lockController.text);
    Locker update = locker.copyWith(
      floor: _floorController.text,
      number: number,
      responsable: _responsibleController.text,
      keyCount: keyCount,
      lockNumber: lock,
    );

    LockerRepository().editLocker(locker.number, update);
    context.pop();
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
          final repository = ref.watch(studentsRepositoryProvider.notifier);
          final locker = LockerRepository.lockersBox.values.firstWhere(

            (element) => widget.lock == element.lockNumber.toString(),

          );
          Locker lockerCopy = locker.copyWith();
          late Student? student = repository.findStudentBy(
            id: lockerCopy.studentId,
          );
          _placeController.text = lockerCopy.floor;
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
                          LockerProfilePart(
                            title: 'Place'.hardcoded,
                            controller: _placeController,
                            prefixIcon: Icon(
                              Icons.place,
                              color: AppColors.titleColor,
                            ),
                            description: 'Description'.hardcoded,
                          ),
                          gapW32,
                          LockerProfilePart(
                            title: 'Floor'.hardcoded,
                            controller: _floorController,
                            prefixIcon: Icon(
                              Icons.flood,
                              color: AppColors.titleColor,
                            ),
                            description: 'Description'.hardcoded,
                          ),
                          gapW32,
                          LockerProfilePart(
                            title: 'Number'.hardcoded,
                            controller: _numberController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.titleColor,
                            ),
                            description: 'Description'.hardcoded,
                          ),
                          gapW32,
                        ],
                      ),
                      gapH24,
                      LockerProfileItem(
                        children: [
                          gapW32,
                          LockerProfilePart(
                            title: 'Responsible'.hardcoded,
                            controller: _responsibleController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.titleColor,
                            ),
                            description: 'Description'.hardcoded,
                          ),
                          gapW32,
                          LockerProfilePart(
                            title: 'Owner'.hardcoded,
                            controller: _ownerController,
                            readOnly: true,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.titleColor,
                            ),
                            description: 'Description'.hardcoded,
                          ),
                          gapW32,
                        ],
                      ),
                      gapH24,
                      LockerProfileItem(
                        children: [
                          gapW32,
                          LockerProfilePart(
                            title: 'KeysAvaible'.hardcoded,
                            controller: _keysController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.titleColor,
                            ),
                            description: 'Description'.hardcoded,
                          ),
                          gapW32,
                          LockerProfilePart(
                            title: 'LockNumber'.hardcoded,
                            controller: _lockController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.titleColor,
                            ),
                            description: 'Description'.hardcoded,
                          ),
                          gapW32,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              StyledButton(
                onPressed: () => update(lockerCopy),
                child: StyledHeadline('Save'.hardcoded),
              ),
              gapH24,
            ],
          );
        },
      ),
    );
  }
}
