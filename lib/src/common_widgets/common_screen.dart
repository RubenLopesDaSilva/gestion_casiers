import 'package:flutter/material.dart';
import 'package:gestion_casiers/src/common_widgets/default_widget.dart';

class CommonScreen extends StatefulWidget {
  const CommonScreen({this.navBar, this.body, super.key});

  final Widget? navBar;
  final Widget? body;

  @override
  State<CommonScreen> createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          DefaultWidget(widget.navBar),
          Expanded(child: DefaultWidget(widget.body)),
        ],
      ),
    );
  }
}
