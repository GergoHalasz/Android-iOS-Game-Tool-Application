import 'dart:io';
import 'package:wowtalentcalculator/RateMyAppCustomClasses/minimum_app_launches_condition.dart';

import '../RateMyAppCustomClasses/do_not_open_again_condition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
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
    remindDays: 1,
    remindLaunches: 3,
    googlePlayIdentifier: 'com.fissher.wowtalentcalculator',
    appStoreIdentifier: '1593368066',
  );

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      CustomDoNotOpenAgainCondition condition = CustomDoNotOpenAgainCondition();
      CustomMinimumAppLaunchesCondition minimumAppLaunchesCondition =
          CustomMinimumAppLaunchesCondition(minLaunches: 2, remindLaunches: 3);
      rateMyApp.conditions.add(condition);
      rateMyApp.conditions.add(minimumAppLaunchesCondition);
      await rateMyApp.init();
      if (mounted && rateMyApp.shouldOpenDialog) {
        if (Platform.isAndroid) {
          rateMyApp.showRateDialog(context,
              title: 'Rate This App',
              message: 'Do you like this app? Please leave a rating!',
              actionsBuilder: actionsBuilderAndroid);
        } else {
          rateMyApp.showStarRateDialog(context,
              title: 'Rate This App',
              message: 'Do you like this app? Please leave a rating!',
              actionsBuilder: actionsBuilderIOS);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return HomeScreen(
      druidTalentTrees: loadTalentString('druid', 'tbc'),
    );
  }

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool("key_is_first_loaded");
    if (isFirstLoaded == null) {
      prefs.setBool("key_is_first_loaded", true);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          if (Platform.isAndroid)
            return AlertDialog(
              title: new Text("Welcome"),
              content: new Text(
                  "Swipe up to increase rank\nSwipe down to decrease rank\nLong press on talent to increase to the max level\nOn the top right corner you can save your build\nDelete the build by swiping the saved build to left"),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          else
            return CupertinoAlertDialog(
              title: const Text('Welcome'),
              content: const Text(
                  'Swipe up to increase rank\nSwipe down to decrease rank\nLong press on talent to increase to the max level\nOn the top right corner you can save your build\nDelete the build by swiping the saved build to left'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
        },
      );
    }
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
