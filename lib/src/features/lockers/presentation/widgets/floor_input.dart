import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

enum Floor { B, C, D, E }

Floor? getFloor(String? floor) {
  for (var value in Floor.values) {
    if (value.name == floor?.toUpperCase()) return value;
  }
  return null;
}

class FloorInput extends StatelessWidget {
  const FloorInput({this.floor, required this.onChanged, super.key});

  final Floor? floor;
  final Function(Floor?) onChanged;

  @override
  Widget build(BuildContext context) {
    final items = floor == null
        ? <DropdownMenuItem<Floor>>[]
        : [
            DropdownMenuItem(
              value: floor,
              alignment: AlignmentGeometry.center,
              child: StyledHeadline('${'Étage'.hardcoded} ${floor?.name}'),
            ),
          ];
    for (final value in Floor.values) {
      if (value != floor) {
        items.add(
          DropdownMenuItem<Floor>(
            value: value,
            alignment: AlignmentGeometry.center,
            child: StyledHeadline(' ${value.name}'),
          ),
        );
      }
    }
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton(
            items: items,
            onChanged: onChanged,
            value: floor,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
            isExpanded: true,
            dropdownColor: AppColors.primaryColor,
            hint: StyledHeadline(
              'Selectionner un étage pour votre casier'.hardcoded,
              color: AppColors.alertColor,
            ),
            disabledHint: floor == null
                ? StyledHeadline(
                    'Vous ne pouvez pas modifier'.hardcoded,
                    color: AppColors.alertColor,
                  )
                : DropdownMenuItem(
                    value: floor,
                    alignment: AlignmentGeometry.center,
                    child: StyledHeadline(
                      '${'Étage'.hardcoded} ${floor?.name}',
                    ),
                  ),
          ),
        ),
        Divider(color: AppColors.titleColor),
      ],
    );
  }
}
