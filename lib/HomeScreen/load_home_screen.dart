import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
import 'home_screen.dart';

class LoadHomeScreen extends StatefulWidget {
  LoadHomeScreen({Key? key, required this.rateMyApp}) : super(key: key);

  RateMyApp? rateMyApp;
  @override
  State<LoadHomeScreen> createState() => _LoadHomeScreenState();
}

class _LoadHomeScreenState extends State<LoadHomeScreen> {
  @override
  void initState() {
    widget.rateMyApp?.showStarRateDialog(context,
        title: 'Rate This App',
        message: 'Do you like this app? Please leave a rating',
        starRatingOptions: StarRatingOptions(initialRating: 4),
        actionsBuilder: actionsBuilder
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      expansion: getExpansion(),
      druidTalentTrees: loadTalentString('druid', 'start'),
    );
  }

  List<Widget> actionsBuilder(BuildContext context, double? stars) =>
      stars == null
          ? [buildCancelButton()]
          : [buildOkButton(), buildCancelButton()];

  // List<Widget> actionsBuilderAndroid(BuildContext context) =>
  //     [buildCancelButton(), buildRemindButton(), buildOkButton()];

  Widget buildOkButton() {
    return RateMyAppRateButton(widget.rateMyApp!, text: 'OK');
  }

  Widget buildCancelButton() {
    return RateMyAppNoButton(widget.rateMyApp!, text: 'CANCEL');
  }

  // Widget buildRemindButton() {
  //   return RateMyAppLaterButton(rateMyApp, text: 'LATER');
  // }
}
