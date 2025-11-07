import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

enum Year {
  first(1),
  second(2),
  third(3),
  fourth(4);

  const Year(this.value);
  final int value;
}

Year? getYear(int? year) {
  for (var value in Year.values) {
    if (value.value == year) return value;
  }
  return null;
}

class YearInput extends StatelessWidget {
  const YearInput({this.year, required this.onChanged, super.key});

  final Year? year;
  final Function(Year?) onChanged;

  @override
  Widget build(BuildContext context) {
    final items = year == null
        ? <DropdownMenuItem<Year>>[]
        : [
            DropdownMenuItem(
              value: year,
              alignment: AlignmentGeometry.center,
              child: StyledHeadline('${'Year'.hardcoded} ${year?.value}'),
            ),
          ];
    for (final value in Year.values) {
      if (value != year) {
        items.add(
          DropdownMenuItem<Year>(
            value: value,
            alignment: AlignmentGeometry.center,
            child: StyledHeadline(' ${value.value}'),
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
            value: year,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
            isExpanded: true,
            dropdownColor: AppColors.primaryColor,
            hint: StyledHeadline(
              'Veuillez choisir une anné pour votre élève'.hardcoded,
              color: AppColors.alertColor,
            ),
            disabledHint: year == null
                ? StyledHeadline(
                    'Vous ne pouvez pas modifier'.hardcoded,
                    color: AppColors.alertColor,
                  )
                : DropdownMenuItem(
                    value: year,
                    alignment: AlignmentGeometry.center,
                    child: StyledHeadline('${'Anné'.hardcoded} ${year?.value}'),
                  ),
          ),
        ),
        Divider(color: AppColors.titleColor),
      ],
    );
  }
}
