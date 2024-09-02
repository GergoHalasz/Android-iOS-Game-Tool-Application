import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LoadHomeScreen extends StatefulWidget {
  @override
  State<LoadHomeScreen> createState() => _LoadHomeScreenState();
}

class _LoadHomeScreenState extends State<LoadHomeScreen> {
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 2,
    remindDays: 0,
    remindLaunches: 2,
    googlePlayIdentifier: 'com.fissher.wowtalentcalculator',
    appStoreIdentifier: 'com.fissher.wowTalentCalculator',
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rateMyApp.init();
      if (mounted && rateMyApp.shouldOpenDialog) {
        if (Platform.isAndroid) {
          rateMyApp.showRateDialog(context,
              title: 'Rate This App',
              message:
                  'Hey Classic Peep, if you like the app leave a rating! :)',
              actionsBuilder: actionsBuilderAndroid);
        } else {
          rateMyApp.showStarRateDialog(context,
              title: 'Rate This App',
              starRatingOptions: StarRatingOptions(initialRating: 4),
              message: 'Do you like this app? Please leave a rating',
              actionsBuilder: actionsBuilderIOS);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }

  List<Widget> actionsBuilderIOS(BuildContext context, double? stars) =>
      stars == null
          ? [buildCancelButton()]
          : [buildCancelButton(), buildRemindButton(), buildOkButton()];

  List<Widget> actionsBuilderAndroid(BuildContext context) =>
      [buildCancelButton(), buildRemindButton(), buildOkButton()];

  Widget buildOkButton() {
    return RateMyAppRateButton(rateMyApp, text: 'OK');
  }

  Widget buildCancelButton() {
    return RateMyAppNoButton(rateMyApp, text: 'CANCEL');
  }

  Widget buildRemindButton() {
    return RateMyAppLaterButton(rateMyApp, text: 'LATER');
  }
}
