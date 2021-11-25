import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
import 'home_screen.dart';

class LoadHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      druidTalentTrees: loadTalentString('druid', 'tbc'),
    );
  }
}
