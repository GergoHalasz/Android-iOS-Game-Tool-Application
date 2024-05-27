import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wowtalentcalculator/DetailsScreen/classes_screen.dart';
import 'package:wowtalentcalculator/DetailsScreen/drawer_screen.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/api/purchase_api.dart';
import 'package:wowtalentcalculator/utils/routestyle.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:wowtalentcalculator/ad_manager.dart';

class ExpansionsScreen extends StatefulWidget {
  const ExpansionsScreen({Key? key}) : super(key: key);

  @override
  State<ExpansionsScreen> createState() => _ExpansionsScreenState();
}

class _ExpansionsScreenState extends State<ExpansionsScreen> {
  List<String> expansions = ['vanilla', 'tbc', 'wotlk', 'cata'];
  List<String> expansionsTitle = ['SoD', 'TBC', 'WotLK', 'Cata'];

  List<String> images = [
    "hunter_marksmanship",
    "hunter_survival",
    "deathknight_unholy",
    "priest_discipline",
    "rogue_assassination",
    "rogue_combat",
    "shaman_restoration",
    "warrior_arms",
    "mage_frost",
    "rogue_combat",
    "shaman_restoration",
    "deathknight_blood",
    "deathknight_frost",
    "druid_balance",
    "hunter_beast",
    "priest_holy",
    "rogue_subtlety",
    "warlock_affliction",
    "warrior_protection",
    "mage_arcane"
  ];

  String image = "";
  List<String> imagesList = [];
  bool firstTimeAdInit = true;

  @override
  void initState() {
    image = "assets/background/${images[Random().nextInt(images.length)]}.png";
    imagesList.add(
        "assets/background/${images[Random().nextInt(images.length)]}.png");
    imagesList.add(
        "assets/background/${images[Random().nextInt(images.length)]}.png");
    imagesList.add(
        "assets/background/${images[Random().nextInt(images.length)]}.png");
    imagesList.add(
        "assets/background/${images[Random().nextInt(images.length)]}.png");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final adState = Provider.of<AdState>(context);

    if (firstTimeAdInit) {
      adState.initializeInterstitialAds();
      firstTimeAdInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final adState = Provider.of<AdState>(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff2E6171),
          title:
              Text("Talent Calculator", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        drawer: Drawer(child: DrawerScreen()),
        floatingActionButton: !adState.isAdFreeVersion
            ? GestureDetector(
                onTap: () async {
                  final adState = Provider.of<AdState>(context, listen: false);
                  if (!adState.isAdFreeVersion) {
                    final offerings = await PurchaseApi.fetchOffers();
                    final isSuccess = await Purchases.purchasePackage(
                        offerings[0].availablePackages[0]);
                    if (isSuccess.allPurchasedProductIdentifiers.length == 1) {
                      adState.changeToAdFreeVersion();
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xff2E6171),
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.not_interested, color: Colors.red),
                      Text(
                        'Remove Ads',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            : null,
        bottomNavigationBar: !adState.isAdFreeVersion
            ? Container(
                decoration: BoxDecoration(color: Color(0xff2E6171)),
                child: SafeArea(
                  child: Container(
                      height: 52,
                      color: Colors.black,
                      child: MaxAdView(
                          adUnitId: bannerAdId,
                          adFormat: AdFormat.banner,
                          listener: AdViewAdListener(
                              onAdLoadedCallback: (ad) {},
                              onAdLoadFailedCallback: (adUnitId, error) {},
                              onAdClickedCallback: (ad) {},
                              onAdExpandedCallback: (ad) {},
                              onAdCollapsedCallback: (ad) {}))),
                ),
              )
            : null,
        body: Container(
            decoration: BoxDecoration(color: Color(0xff2E6171)),
            child: SafeArea(
              top: false,
              child: Container(
                  child: Stack(fit: StackFit.expand, children: [
                Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...expansions.asMap().entries.map((entry) {
                            return Container(
                                width: SizeConfig.cellSize / 0.8,
                                height: SizeConfig.cellSize / 0.8,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/Class/${entry.value}.png"),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Container(
                                      child: InkWell(
                                        onTap: () async {
                                          adState.initializeInterstitialAds();
                                          if (entry.value == 'Cata') {
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return Text(
                                                      'Cata Coming Soon!');
                                                }));
                                          }
                                          Navigator.push(
                                              context,
                                              buildPageRoute(ClassesScreen(
                                                expansion: entry.value,
                                                backgroundImagePath:
                                                    imagesList[entry.key],
                                              )));
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ));
                          })
                        ])),
              ])),
            )));
  }
}
