// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projet_excel/src/common_widgets/common_widgets.dart';
import 'package:projet_excel/src/features/hive/person.dart';
import 'package:projet_excel/src/localization/string_harcoded.dart';

class HiveScreen extends StatelessWidget {
  const HiveScreen({super.key});

  Future<void> storePerson() async {
    var box = await Hive.openBox('myBox');
    var person = Person(name: 'Dave', age: 22);
    box.add(person);

    final Person newPerson = box.getAt(0);
    print(newPerson.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projet Casiers(Hive)'), centerTitle: true),
      body: Center(
        child: ElevatedButton(
          onPressed: storePerson,
          child: StyledText('Store a Person in DB'.hardcoded),
        ),
      ),
    );
  }
}
