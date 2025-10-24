import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:gestion_casiers/src/features/lockers/widgets/locker_item.dart';

class LockerSection extends StatelessWidget {
  const LockerSection(
    this.isOpen, {
    required this.open,
    required this.title,
    this.selectedIndex,
    required this.select,
    this.lockers = const [],
    super.key,
  });

  final bool isOpen;
  final VoidCallback open;
  final String title;
  final int? selectedIndex;
  final void Function(int) select;
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
            return LockerItem(
              locker: locker,
              isOpen: index == selectedIndex,
              open: () => select(index),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ],
    );
    // return Expanded(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.max,
    //     children: isOpen
    //         ? [
    //             Row(
    //               children: [
    //                 Expanded(child: StyledHeadline(title)),
    //                 IconButton(
    //                   onPressed: open,
    //                   icon: const Icon(Icons.keyboard_arrow_up),
    //                 ),
    //               ],
    //             ),
    //             Expanded(
    //               child: ListView.separated(
    //                 itemCount: lockers.length,
    //                 itemBuilder: (context, index) {
    //                   Locker locker = lockers[index];
    //                   return LockerItem(
    //                     locker: locker,
    //                     isOpen: index == selectedIndex,
    //                     open: () => select(index),
    //                   );
    //                 },
    //                 separatorBuilder: (context, index) {
    //                   return const Divider();
    //                 },
    //               ),
    //             ),
    //           ]
    //         : [
    //             Row(
    //               children: [
    //                 Expanded(child: StyledHeadline(title)),
    //                 IconButton(
    //                   onPressed: open,
    //                   icon: const Icon(Icons.keyboard_arrow_down),
    //                 ),
    //               ],
    //             ),
    //           ],
    //   ),
    // );
  }
}
