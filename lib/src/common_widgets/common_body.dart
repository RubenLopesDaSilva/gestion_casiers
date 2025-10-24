import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/routing/app_router.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class CommonBody extends StatelessWidget {
  const CommonBody({
    required this.location,
    required this.body,
    required this.panel,
    super.key,
  });

  final AppRoute location;
  final Widget body;
  final Widget panel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Navbar(location),
        Expanded(child: body),
        Container(width: 400, color: AppColors.secondaryColor, child: panel),
      ],
    );
  }
}
