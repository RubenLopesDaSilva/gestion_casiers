import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/presentation/widgets/locker_update.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class LockerItem extends StatelessWidget {
  const LockerItem(this.locker, {super.key});

  final Locker locker;

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
  }
}
