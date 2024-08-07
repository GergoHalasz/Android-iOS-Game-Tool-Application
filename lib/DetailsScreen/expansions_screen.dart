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
