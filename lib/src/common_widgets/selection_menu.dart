import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class SelectionMenu extends StatefulWidget {
  const SelectionMenu({
    required this.options,
    required this.select,
    required this.children,
    this.color,
    super.key,
  });

  final Map<String, GlobalKey> options;
  final void Function(GlobalKey?) select;
  final Widget Function(String) children;
  final Color? color;

  @override
  State<SelectionMenu> createState() =>
      _SelectionMenuState<String, GlobalKey>();
}

class _SelectionMenuState<KeyType, ValueType> extends State<SelectionMenu> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: widget.color ?? AppColors.primaryAccent,
      child: Row(
        children: [
          for (String value in widget.options.keys)
            GestureDetector(
              onTap: () => widget.select(widget.options[value]),
              child: widget.children(value),
            ),
        ],
      ),
    );
  }
}
