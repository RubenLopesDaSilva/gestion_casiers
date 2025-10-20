import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_item.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/locker_item_titles.dart';
import 'package:gestion_casiers/src/features/students/data/student_repository.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:gestion_casiers/utils/import_excel.dart';
import 'package:go_router/go_router.dart';

class LockerScreen extends ConsumerStatefulWidget {
  const LockerScreen({super.key});

  @override
  ConsumerState<LockerScreen> createState() => _LockerScreenState();
}

class _LockerScreenState extends ConsumerState<LockerScreen> {
  Future<void> studentScreen() async {
    context.goNamed(AppRoute.student.name);
    setState(() {});
  }

  Future<void> changeStudent(Locker locker, LockerRepository repository) async {
    final result = await context.pushNamed<(bool error, String? id)?>(
      AppRoute.students.name,
    );

    if (result != null) {
      if (result.$1) {
      } else {
        final update = Locker(
          studentId: result.$2,
          number: locker.number,
          floor: locker.floor,
          keyCount: locker.keyCount,
          lockNumber: locker.lockNumber,
          responsable: locker.responsable,
          lockerCondition: locker.lockerCondition,
          place: locker.place,
        );
        repository.editLocker(locker.number, update);
        setState(() {});
      }
    }
  }

  void lockerProfile(Locker locker) async {
    await context.pushNamed(
      AppRoute.lockerprofile.name,
      pathParameters: {'lock': locker.lockNumber.toString()},
    );
    setState(() {});
  }

  void addLocker() async {
    await context.pushNamed(AppRoute.lockerAdd.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: StyledTitle('Lockers'.hardcoded)),
      body: SizedBox(
        width: double.infinity,
        child: Consumer(
          builder: (context, value, child) {
            final lockerRef = value.watch(lockersRepositoryProvider.notifier);
            final studentRef = value.watch(studentsRepositoryProvider.notifier);
            final lockers = LockerRepository.lockersBox.values.toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapH12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StyledButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles();
                        if (result != null) {
                          setState(() {
                            lockerRef.setLockers(
                              importLockersFrom(
                                Excel.decodeBytes(
                                  result.files.single.bytes!.toList(),
                                ),
                              ),
                            );
                          });
                        }
                      },
                      child: const StyledHeadline('Import Lockers'),
                    ),
                    gapW16,
                    StyledButton(
                      onPressed: studentScreen,
                      child: const StyledHeadline('Go to students'),
                    ),
                  ],
                ),
                gapH16,
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      bottom: 40.0,
                    ),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent,
                      borderRadius: const BorderRadius.all(
                        Radius.elliptical(60, 40),
                      ),
                    ),
                    child: Column(
                      children: [
                        LockerItemTitles(onPressed: addLocker),
                        gapH24,
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(30),
                            itemCount: lockers.length,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) => gapH24,
                            itemBuilder: (context, index) {
                              Locker locker = lockers[index];
                              return LockerItem(
                                studentRef: studentRef,
                                lockerRef: lockerRef,
                                locker: locker,
                                student: changeStudent,
                                profile: lockerProfile,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
