import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
import 'home_screen.dart';

class LoadHomeScreen extends StatefulWidget {
  LoadHomeScreen({Key? key}) : super(key: key);

  @override
  State<LoadHomeScreen> createState() => _LoadHomeScreenState();
}

class _LoadHomeScreenState extends State<LoadHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      expansion: getExpansion(),
      druidTalentTrees: loadTalentString('druid', 'start'),
    );
  }

  // List<Widget> actionsBuilderAndroid(BuildContext context) =>
  //     [buildCancelButton(), buildRemindButton(), buildOkButton()];

  // Widget buildRemindButton() {
  //   return RateMyAppLaterButton(rateMyApp, text: 'LATER');
  // }
}
