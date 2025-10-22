import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/features/dashboard/widgets/info_card_element.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InfoCardElement(
              iconData: Icons.lock,
              text: 'Nombre total de casiers'.hardcoded,
              number: 43,
            ),
            gapW24,
            InfoCardElement(
              iconData: Icons.school,
              text: 'Nombre total d\'élèves'.hardcoded,
              number: 32,
            ),
            gapW24,
            InfoCardElement(
              iconData: Icons.school,
              text: 'Nombre d\'élèves sans casiers'.hardcoded,
              number: 23,
            ),
          ],
        ),
        gapH24,
        Row(
          children: [
            InfoCardElement(
              iconData: Icons.lock,
              text: 'Nombre de casiers libres'.hardcoded,
              number: 34,
            ),
            gapW24,
            InfoCardElement(
              iconData: Icons.key,
              text: 'Nombre de casiers défectueux'.hardcoded,
              number: 0,
            ),
            gapW24,
            InfoCardElement(
              iconData: Icons.lock,
              text: 'Nombre de casiers avec clés manquantes'.hardcoded,
              number: 5,
            ),
          ],
        ),
      ],
    );
  }
}
