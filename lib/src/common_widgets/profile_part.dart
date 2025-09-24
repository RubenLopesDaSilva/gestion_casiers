import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/styled_text.dart';
import 'package:gestion_casiers/src/common_widgets/styled_textfield.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';

class ProfilePart extends StatelessWidget {
  const ProfilePart({
    required this.title,
    required this.description,
    required this.controller,
    this.readOnly,
    this.textInputType,
    this.prefixIcon,
    super.key,
  });

  final String title;
  final String description;

  final TextEditingController controller;
  final bool? readOnly;
  final TextInputType? textInputType;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StyledHeadline(title),
          gapH24,
          StyledTextfield(
            controller: controller,
            readOnly: readOnly,
            textInputType: textInputType,
            prefixIcon: prefixIcon,
            // child: StyledHeadline(title),
          ),
          gapH24,
          StyledText(description),
        ],
      ),
    );
  }
}
