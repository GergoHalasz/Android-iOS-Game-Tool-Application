import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/DetailsScreen/classes_screen.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/utils/routestyle.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';

class ExpansionsScreen extends StatefulWidget {
  const ExpansionsScreen({Key? key}) : super(key: key);

  @override
  State<ExpansionsScreen> createState() => _ExpansionsScreenState();
}

class _ExpansionsScreenState extends State<ExpansionsScreen> {
  List<String> expansions = ['vanilla', 'tbc', 'wotlk'];
  List<String> expansionsTitle = ['SoD', 'TBC', 'WotLK'];

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
  BannerAd? banner;

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
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (firstTimeAdInit) {
      final adState = Provider.of<AdState>(context);

      adState.initialization.then((value) {
        setState(() {
          banner = BannerAd(
              adUnitId: adState.bannerAdUnitId,
              size: AdSize.banner,
              request: AdRequest(),
              listener: adState.listener)
            ..load();
          firstTimeAdInit = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final adState = Provider.of<AdState>(context);

    return Scaffold(
      bottomNavigationBar: !adState.isAdFreeVersion
          ? Container(
              height: 52,
              color: Colors.black,
              child: AdWidget(ad: banner!),
            )
          : null,
      body: Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...expansions.asMap().entries.map((entry) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 50),
                      width: 130,
                      height: 100,
                      child: ElevatedButton(
                        child: Text(
                          expansionsTitle[entry.key],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff2E6171),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              buildPageRoute(ClassesScreen(
                                expansion: entry.value,
                                backgroundImagePath: imagesList[entry.key],
                              )));
                        },
                      ),
                    );
                  }),
                ])),
      ])),
    );
  }
}
