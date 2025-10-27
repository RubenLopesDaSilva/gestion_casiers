import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/common_widgets.dart';
import 'package:gestion_casiers/src/constants/app_sizes.dart';
import 'package:gestion_casiers/src/localization/string_hardcoded.dart';
import 'package:gestion_casiers/src/theme/theme.dart';

class CsvImport extends StatefulWidget {
  const CsvImport(this.import, {super.key});

  final Function(PlatformFile?) import;

  @override
  State<CsvImport> createState() => _CsvImportState();
}

class _CsvImportState extends State<CsvImport> {
  PlatformFile? platformFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledHeadline('Importer un fichier CSV'.hardcoded),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles();
                  if (result != null) {
                    setState(() {
                      platformFile = result.files.single;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.file_upload_outlined,
                      color: AppColors.titleColor,
                    ),
                    gapW8,
                    SizedBox(
                      width: 160,
                      child: StyledHeadline(
                        platformFile == null
                            ? 'Choisir...'.hardcoded
                            : '${platformFile?.name}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: gapW12),
              StyledButton(
                width: 120,
                onPressed: () => widget.import(platformFile),
                child: StyledText('Importer'.hardcoded),
              ),
            ],
          ),
          const Divider(endIndent: 140),
        ],
      ),
    );
  }
}
