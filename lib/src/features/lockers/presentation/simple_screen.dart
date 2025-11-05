import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/simple_locker_item.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/simple_locker_item_titles.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';
import 'package:gestion_casiers/src/features/lockers/data/locker_service.dart';
import 'package:gestion_casiers/src/features/students/data/student_service.dart';
import 'package:gestion_casiers/src/theme/theme.dart';
import 'package:gestion_casiers/utils/import_excel.dart';
import 'package:go_router/go_router.dart';

class SimpleScreen extends StatefulWidget {
  const SimpleScreen({super.key});

  @override
  State<SimpleScreen> createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  List<Locker>? lockers = [];

  Future<void> changeStudent(Locker locker, LockerService repository) async {
    final result = await context.pushNamed<(bool error, String? id)?>(
      AppRoute.students.name,
    );

    if (result != null) {
      if (result.$1) {
        return;
      } else {
        final update = Locker(
          id: locker.id,
          studentId: result.$2,
          number: locker.number,
          floor: locker.floor,
          keyCount: locker.keyCount,
          lockNumber: locker.lockNumber,
          responsable: locker.responsable,
          lockerCondition: locker.lockerCondition,
          place: locker.place,
        );

        await repository.patchLocker(update);
        setState(() {});
      }
    }
  }

  void lockerProfile(Locker locker) async {
    await context.pushNamed(
      AppRoute.lockerprofile.name,
      pathParameters: {'id': locker.id},
    );
    setState(() {});
  }

  Future<void> studentScreen() async {
    context.goNamed(AppRoute.student.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: StyledTitle('Simple Screen'.hardcoded)),
      body: SizedBox(
        width: double.infinity,
        child: Consumer(
          builder: (context, value, child) {
            final studentProvider = value.watch(studentService.notifier);
            final lockerProvider = value.watch(lockerService.notifier);
            return FutureBuilder<List<Locker>>(
              future: lockerProvider.fetchLockers(),
              builder: (context, asyncSnapshot) {
                lockers = asyncSnapshot.data;
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
                              final datas = await importLockersFrom(
                                Excel.decodeBytes(
                                  result.files.single.bytes!.toList(),
                                ),
                              );
                              for (Locker locker in datas) {
                                await lockerProvider.addLocker(locker);
                              }
                              final data = asyncSnapshot.data;
                              setState(() {
                                lockers = data;
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
                            const SimpleLockerItemTitles(),
                            gapH24,
                            Expanded(
                              child: lockers != null
                                  ? ListView.separated(
                                      padding: const EdgeInsets.all(30),
                                      itemCount: lockers!.length,
                                      scrollDirection: Axis.vertical,
                                      separatorBuilder: (context, index) =>
                                          gapH24,
                                      itemBuilder: (context, index) {
                                        Locker locker = lockers![index];
                                        return SimpleLockerItem(
                                          studentRef: studentProvider,
                                          lockerRef: lockerProvider,
                                          locker: locker,
                                          studentDetail: changeStudent,
                                          profile: lockerProfile,
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
