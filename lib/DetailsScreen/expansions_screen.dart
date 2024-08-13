import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wowtalentcalculator/DetailsScreen/classes_screen.dart';
import 'package:wowtalentcalculator/DetailsScreen/drawer_screen.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/api/purchase_api.dart';
import 'package:wowtalentcalculator/utils/routestyle.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';

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
  late BannerAd banner;
  bool isConnectedToInternet = false;

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
      // adState.initializeInterstitialAds();
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
      if (!adState.isAdFreeVersion) checkInternetConnection();
    }
    super.didChangeDependencies();
  }

  void checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                checkInternetConnection();
              },
              child: const Text('Connected'),
            )
          ],
          content: Text(
              'Please connect to the internet to proceed further. Click on the \"Connected\" button if you did connect to the internet.'),
          title: Text("No internet connection"),
        ),
      );
    }
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
              child: Padding(
                padding: EdgeInsets.only(top: 16),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...expansions.asMap().entries.map((entry) {
                        if (entry.value == 'vanilla') {
                          return Column(
                            children: [
                              Container(
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
                                            // adState.initializeInterstitialAds();

                                            Navigator.push(
                                                context,
                                                buildPageRoute(ClassesScreen(
                                                  expansion: entry.value,
                                                  backgroundImagePath:
                                                      imagesList[entry.key],
                                                )));
                                          },
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  )),
                              Text(
                                'SoD & Vanilla',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          );
                        }
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
                                      // adState.initializeInterstitialAds();
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
                    ]),
              )),
        ])));
  }
}
