import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
import 'package:wowtalentcalculator/utils/rating_service.dart';
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
    Timer(const Duration(seconds: 2), () {
      _ratingService.isSecondTimeOpen().then((secondOpen) {
        if (secondOpen) {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text('Über diese App'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'StVO 2024',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Version 1.0.0'),
                      SizedBox(height: 16),
                      Text(
                        '',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('Schließen'),
                      onPressed: () async {
                        InAppReview inAppReview = InAppReview.instance;

                        if (await inAppReview.isAvailable()) {
                          inAppReview.openStoreListing(
                              appStoreId: '1593368066');
                        }
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
