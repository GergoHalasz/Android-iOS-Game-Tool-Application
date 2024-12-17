import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/HomeScreen/load_home_screen.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/api/purchase_api.dart';
import 'package:wowtalentcalculator/utils/rating_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PurchaseApi.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final initFuture = MobileAds.instance.initialize();
  loadAd();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AdState>(create: (_) => AdState(initFuture)),
    ],
    child: MyApp(),
  ));
}

AppOpenAd? _appOpenAd;

loadAd() async {
  bool isAdFreeVersion = false;
  final prefs = await SharedPreferences.getInstance();
  bool? isAdFree = prefs.getBool("isAdFreeVersion");
  if (isAdFree != null && isAdFree == true) {
    isAdFreeVersion = true;
  }
  if (!isAdFreeVersion) {
    AppOpenAd.load(
      adUnitId: "ca-app-pub-7574598565891663/9817239401",
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenAd!.show();
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WoW Talent Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LoadHomeScreen());
  }
}
