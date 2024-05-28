import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/RateMyAppCustomClasses/do_not_open_again_condition.dart';
import 'package:wowtalentcalculator/RateMyAppCustomClasses/minimum_app_launches_condition.dart';
import 'home_screen.dart';

class LoadHomeScreen extends StatefulWidget {
  @override
  State<LoadHomeScreen> createState() => _LoadHomeScreenState();
}

class _LoadHomeScreenState extends State<LoadHomeScreen> {
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 0,
    remindDays: 1,
    remindLaunches: 4,
    googlePlayIdentifier: 'com.chickencowstudios.talentcalculator',
    appStoreIdentifier: '1593368066',
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      CustomDoNotOpenAgainCondition condition = CustomDoNotOpenAgainCondition();
      CustomMinimumAppLaunchesCondition minimumAppLaunchesCondition =
          CustomMinimumAppLaunchesCondition(minLaunches: 4, remindLaunches: 5);
      rateMyApp.conditions.add(condition);
      rateMyApp.conditions.add(minimumAppLaunchesCondition);
      await rateMyApp.init();
      if (mounted && rateMyApp.shouldOpenDialog) {
        if (Platform.isAndroid) {
          rateMyApp.showRateDialog(context,
              title: 'Rate This App',
              message: 'Hey Classic Peep, if you like the app leave a rating! :)',
              actionsBuilder: actionsBuilderAndroid);
        } else {
          rateMyApp.showStarRateDialog(context,
              title: 'Enjoying WoW Talent Calculator?',
              message: 'Hey Classic Peep, if you like the app leave a rating! :)',
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
          ? [buildOkButton()]
          : [buildCancelButton(), buildRemindButton(), buildOkButton()];

  List<Widget> actionsBuilderAndroid(BuildContext context) =>
      [buildCancelButton(), buildRemindButton(), buildOkButton()];

  Widget buildOkButton() {
    return RateMyAppRateButton(rateMyApp, text: 'RATE');
  }

  Widget buildCancelButton() {
    return RateMyAppNoButton(rateMyApp, text: 'CANCEL');
  }

  Widget buildRemindButton() {
    return RateMyAppLaterButton(rateMyApp, text: 'LATER');
  }
}
