import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_repository.dart';
import 'package:gestion_casiers/src/features/lockers/domain/domain.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/simple_locker_item.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/simple_locker_item_titles.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:gestion_casiers/src/utils/import_excel.dart';
import 'package:go_router/go_router.dart';

class SimpleScreen extends ConsumerStatefulWidget {
  const SimpleScreen({super.key});

  @override
  ConsumerState<SimpleScreen> createState() => _SimpleScreenState();
}

class _SimpleScreenState extends ConsumerState<SimpleScreen> {
  // final data = lockers;

  Future<void> changeStudent(Locker locker) async {
    //TODO (bool error, string? id)? indication de cas qu'on on annule ca retourne null, comme quand on veut vider un casier
    final studentId = await context.pushNamed<String?>(AppRoute.students.name);

    if (studentId != null) {
      // Student selectedStudent = students.firstWhere(
      //   (student) => studentId == student.id,
      // );
    } else {}
  }

  Future<void> lockerProfile(Locker locker) async {
    final result = await context.pushNamed<Locker?>(
      AppRoute.lockerprofile.name,
      pathParameters: {'lock': locker.lockNumber.toString()},
    );
  }

  @override
  Widget build(BuildContext context) {
    // final data = LockerRepository().lockers;
    return Scaffold(
      //TODO ajouter style au titre
      appBar: AppBar(title: StyledTitle('SimpleScreen'.hardcoded)),
      body: SizedBox(
        width: double.infinity,
        child: Consumer(
          builder: (context, value, child) {
            final ref = value.watch(lockersRepositoryProvider);
            final lockers = ref.lockers;
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
                          ref.setLockers(
                            importLockersFrom(
                              Excel.decodeBytes(
                                result.files.single.bytes!.toList(),
                              ),
                              ref.students,
                            ),
                          );
                        }
                      },
                      child: const StyledHeadline('Import Lockers'),
                    ),
                    gapW16,
                    StyledButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles();
                        if (result != null) {
                          ref.setStudents(
                            importStudentsFrom(
                              Excel.decodeBytes(
                                result.files.single.bytes!.toList(),
                              ),
                            ),
                          );
                        }
                      },
                      child: const StyledHeadline('Import Students'),
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
                        const SimpleLockerItemTitles(),
                        gapH24,
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(30),
                            itemCount: lockers.length,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) => gapH24,
                            itemBuilder: (context, index) {
                              Locker locker = lockers[index];
                              return SimpleLockerItem(
                                ref: ref,
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
