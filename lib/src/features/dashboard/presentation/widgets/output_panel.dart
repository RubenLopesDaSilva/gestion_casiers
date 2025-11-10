import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class OutputPanel extends StatefulWidget {
  const OutputPanel({super.key});

  @override
  State<OutputPanel> createState() => _OutputPanelState();
}

class _OutputPanelState extends State<OutputPanel> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryAccent,
      child: Column(
        children: [
          Row(
            children: [
              gapW24,
              TextButton(
                onPressed: () {
                  setState(() {
                    index = index == 1 ? 0 : 1;
                  });
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: index == 1
                        ? StyledText('Casier libre'.hardcoded)
                        : StyledHeadline('Casier libre'.hardcoded),
                  ),
                ),
              ),
              gapW24,
              TextButton(
                onPressed: () {
                  setState(() {
                    index = index == 2 ? 0 : 2;
                  });
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: index == 2
                        ? StyledText('Casier sans clé'.hardcoded)
                        : StyledHeadline('Casier sans clé'.hardcoded),
                  ),
                ),
              ),
              gapW24,
              TextButton(
                onPressed: () {
                  setState(() {
                    index = index == 3 ? 0 : 3;
                  });
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: index == 3
                        ? StyledText('Casier défectueux'.hardcoded)
                        : StyledHeadline('Casier défectueux'.hardcoded),
                  ),
                ),
              ),
              gapW24,
              TextButton(
                onPressed: () {
                  setState(() {
                    index = index == 4 ? 0 : 4;
                  });
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: index == 4
                        ? StyledText('Élèves sans casier'.hardcoded)
                        : StyledHeadline('Élèves sans casier'.hardcoded),
                  ),
                ),
              ),
            ],
          ),
          Divider(color: AppColors.titleColor, height: 0),
          const Expanded(child: Column(children: [Row()])),
        ],
      ),
    );
  }
}
