import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class CommonSearchBar extends StatefulWidget {
  const CommonSearchBar({
    required this.title,
    required this.research,
    super.key,
  });

  final String title;
  final Function(String) research;

  @override
  State<CommonSearchBar> createState() => _CommonSearchBarState();
}

class _CommonSearchBarState extends State<CommonSearchBar> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    searchController.addListener(() {
      widget.research(searchController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyledHeadline(widget.title),
        gapH8,
        StyledTextfield(
          controller: searchController,
          color: AppColors.primaryAccent,
          prefixIcon: const Icon(Icons.search),
          child: StyledHeadline('Rechercher...'.hardcoded),
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
