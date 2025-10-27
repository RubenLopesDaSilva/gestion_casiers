import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/locker_item.dart';

class LockerSection extends StatelessWidget {
  const LockerSection({
    required this.title,
    this.lockers = const [],
    super.key,
  });

  final String title;
  final List<Locker> lockers;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: StyledHeadline(title),
      shape: const Border(),
      tilePadding: const EdgeInsets.all(8.0),
      childrenPadding: const EdgeInsets.all(8.0),
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: lockers.length,
          itemBuilder: (context, index) {
            Locker locker = lockers[index];
            return LockerItem(locker);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ],
    );
  }
}
