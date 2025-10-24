import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/locker_update.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerItem extends StatelessWidget {
  const LockerItem({
    required this.locker,
    this.isOpen = false,
    required this.open,
    super.key,
  });

  final Locker locker;
  final bool isOpen;
  final VoidCallback open;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.lock_outline, color: AppColors.alertColor),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText('${'Casier'.hardcoded} n\'${locker.number}'),
          const StyledText('Aucune remarque'),
        ],
      ),
      shape: const Border(),
      tilePadding: const EdgeInsets.all(8.0),
      childrenPadding: const EdgeInsets.all(8.0),
      children: [LockerUpdate(locker)],
    );
    // return Row(
    //   mainAxisSize: MainAxisSize.max,
    //   children: [
    //     Icon(Icons.lock_outline, color: AppColors.alertColor),
    //     gapW12,
    //     Expanded(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: isOpen
    //             ? [
    //                 StyledText('${'Casier'.hardcoded} n\'${locker.number}'),
    //                 const StyledText('Aucune remarque'),
    //                 LockerUpdate(locker),
    //               ]
    //             : [
    //                 StyledText('${'Casier'.hardcoded} n\'${locker.number}'),
    //                 const StyledText('Aucune remarque'),
    //               ],
    //       ),
    //     ),
    //     IconButton(
    //       onPressed: open,
    //       icon: isOpen
    //           ? const Icon(Icons.keyboard_arrow_up)
    //           : const Icon(Icons.keyboard_arrow_down),
    //     ),
    //   ],
    // );
  }
}
