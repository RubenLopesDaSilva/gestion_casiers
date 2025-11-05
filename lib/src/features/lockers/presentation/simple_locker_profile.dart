import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_details_provider.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_service.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_presentation.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:go_router/go_router.dart';

class SimpleLockerProfile extends ConsumerStatefulWidget {
  const SimpleLockerProfile(this.id, {super.key});

  final String? id;

  @override
  ConsumerState<SimpleLockerProfile> createState() =>
      _SimpleLockerProfileState();
}

class _SimpleLockerProfileState extends ConsumerState<SimpleLockerProfile> {
  final _placeController = TextEditingController();
  final _floorController = TextEditingController();
  final _numberController = TextEditingController();
  final _responsibleController = TextEditingController();
  final _ownerController = TextEditingController();
  final _keysController = TextEditingController();
  final _lockController = TextEditingController();

  void update(Locker locker, LockerService repository) {
    final number = int.tryParse(_numberController.text);
    final keyCount = int.tryParse(_keysController.text);
    final lock = int.tryParse(_lockController.text);
    Locker update = locker.copyWith(
      id: locker.id,
      floor: _floorController.text,
      number: number,
      responsable: _responsibleController.text,
      keyCount: keyCount,
      lockNumber: lock,
    );
    setState(() {
      repository.patchLocker(update);
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
    final asyncData = ref.watch(lockerDetailsProvider(widget.id!));
    final service = ref.watch(lockerService.notifier);
    return asyncData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Erreur : $error')),
      data: (data) {
        final locker = data['locker'];
        final student = data['student'];
        Locker lockerCopy = locker.copyWith();
        _placeController.text = lockerCopy.place;
        _floorController.text = lockerCopy.floor;
        _numberController.text = lockerCopy.number.toString();
        _responsibleController.text = lockerCopy.responsable;
        _ownerController.text = student == null
            ? 'None'
            : '${student.firstName} ${student.lastName}';
        _keysController.text = lockerCopy.keyCount.toString();
        _lockController.text = lockerCopy.lockNumber.toString();
        return Scaffold(
          appBar: AppBar(title: StyledTitle('Locker Profile'.hardcoded)),
          body: Column(
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
                            title: 'Location'.hardcoded,
                            controller: _placeController,
                            prefixIcon: Icon(
                              Icons.place,
                              color: AppColors.titleColor,
                            ),
                            description:
                                'In which batiment the locker is located'
                                    .hardcoded,
                          ),
                          gapW32,
                          LockerProfilePart(
                            title: 'Floor'.hardcoded,
                            controller: _floorController,
                            prefixIcon: Icon(
                              Icons.flood,
                              color: AppColors.titleColor,
                            ),
                            description: 'In which floor this locker is located'
                                .hardcoded,
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
                            description: 'Manager of the locker'.hardcoded,
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
                            description: 'He uses the locker'.hardcoded,
                          ),
                          gapW32,
                        ],
                      ),
                      gapH24,
                      LockerProfileItem(
                        children: [
                          gapW32,
                          LockerProfilePart(
                            title: 'Keys'.hardcoded,
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
                            description:
                                'the number of keys available for this lock in storage'
                                    .hardcoded,
                          ),
                          gapW32,
                          LockerProfilePart(
                            title: 'Lock'.hardcoded,
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
              StyledButton(
                onPressed: () => update(lockerCopy, service),
                child: StyledHeadline('Save'.hardcoded),
              ),
              gapH24,
            ],
          ),
        );
      },
    );
  }
}
