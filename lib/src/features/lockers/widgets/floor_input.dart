import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';

// TODO : voire si possibilité d'étage null

enum Floor {
  none(''),
  b('b'),
  c('c'),
  d('d'),
  e('e');

  const Floor(this.value);
  final String value;
}

Floor getFloor(String? floor) {
  return Floor.values.toList().firstWhere(
    (value) => value.name == floor,
    orElse: () => Floor.none,
  );
}

class FloorInput extends StatelessWidget {
  const FloorInput({required this.floor, required this.onChanged, super.key});

  final Floor floor;
  final Function(Floor?) onChanged;

  @override
  Widget build(BuildContext context) {
    final items = [
      DropdownMenuItem(
        value: floor,
        child: StyledHeadline('Étage ${floor.name}'),
      ),
    ];
    for (final value in Floor.values) {
      if (value != floor) {
        items.add(
          DropdownMenuItem<Floor>(
            value: value,
            child: StyledHeadline('Étage ${value.name}'),
          ),
        );
      }
    }
    return DropdownButton(items: items, onChanged: onChanged, value: floor);
  }
}
