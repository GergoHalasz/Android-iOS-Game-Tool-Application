import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/DetailsScreen/expansions_screen.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
import 'package:wowtalentcalculator/utils/rating_service.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'home_screen.dart';

class LoadHomeScreen extends StatefulWidget {
  LoadHomeScreen({Key? key}) : super(key: key);

  @override
  State<LoadHomeScreen> createState() => _LoadHomeScreenState();
}

class _LoadHomeScreenState extends State<LoadHomeScreen> {
  final RatingService _ratingService = RatingService();

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      late SharedPreferences _prefs;
      _prefs = await SharedPreferences.getInstance();

      if (_prefs.getBool("askAgainRate") == null)
        _ratingService.isSecondTimeOpen().then((secondOpen) {
          if (secondOpen) {
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('Rate this app'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('NO THANKS'),
                        onPressed: () async {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('MAYBE LATER'),
                        onPressed: () async {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('RATE'),
                        onPressed: () async {
                          InAppReview inAppReview = InAppReview.instance;

                          if (await inAppReview.isAvailable()) {
                            inAppReview.openStoreListing(
                                appStoreId: '1593368066');
                          }
                          _prefs.setBool('askAgainRate', false);

                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                });
          }
        });
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
