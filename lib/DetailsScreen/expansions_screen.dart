import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wowtalentcalculator/ArrowWidgets/class_arrow_widget.dart';
import 'package:wowtalentcalculator/DetailsScreen/classes_screen.dart';
import 'package:wowtalentcalculator/DetailsScreen/detail_screen_content.dart';
import 'package:wowtalentcalculator/DetailsScreen/drawer_screen.dart';
import 'package:wowtalentcalculator/HomeScreen/home_screen.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/api/purchase_api.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
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
              onPressed: () async {
                final adState = Provider.of<AdState>(context, listen: false);
                  if (!adState.isAdFreeVersion) {
                    final offerings = await PurchaseApi.fetchOffers();
                    final isSuccess = await Purchases.purchasePackage(
                        offerings[0].availablePackages[0]);
                    if (isSuccess.allPurchasedProductIdentifiers.length == 1) {
                      adState.changeToAdFreeVersion();
                      Navigator.of(context).pop();
                    }
                  }
              },
              child: const Text('Remove Ads'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                checkInternetConnection();
              },
              child: const Text('Connected'),
            )
          ],
          content: Text(
              'Please connect to the internet to proceed further. Click on the \"Connected\" button if you did connect to the internet. Also you can buy the remove ads package and then the app can be used also without internet.'),
          title: Text("No internet connection"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final adState = Provider.of<AdState>(context);

    return Scaffold(
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
        drawer: Drawer(
            child: ChangeNotifierProvider<AdState>.value(
                value: adState, child: DrawerScreen())),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color.fromARGB(255, 57, 57, 57),
        ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'WoW Classic Talent Calculator',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Choose the expansion',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    ...expansions.asMap().entries.map((entry) {
                      if (entry.value == 'vanilla') {
                        return Column(
                          children: [
                            Container(
                                width: SizeConfig.cellSize / 0.9,
                                height: SizeConfig.cellSize / 0.9,
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

                                          // Navigator.push(
                                          //     context,
                                          //     buildPageRoute(HomeScreen(
                                          //       expansion: getExpansion(),
                                          //       druidTalentTrees:
                                          //           loadTalentString(
                                          //               'druid', 'vanilla'),
                                          //     )));

                                          List snapshot =
                                              await loadTalentString(
                                                  'druid', entry.value);
                                          TalentTrees talentTreesObject =
                                              TalentTrees.fromJson(snapshot);
                                          Navigator.push(
                                              context,
                                              buildPageRoute(
                                                  ChangeNotifierProvider<
                                                          TalentProvider>(
                                                      create: (_) {
                                                        return TalentProvider(
                                                            talentTreesObject,
                                                            'druid',
                                                            entry.value,
                                                            [],
                                                            null,
                                                            [null, null, null],
                                                            [null, null, null],
                                                            [],
                                                            []);
                                                      },
                                                      child:
                                                          DetailScreenContent(
                                                        talentTrees:
                                                            talentTreesObject,
                                                        className: 'druid',
                                                        classColor: classColors[
                                                            'druid']!,
                                                        arrowTrees:
                                                            getArrowClassByName(
                                                                'druid',
                                                                entry.value),
                                                      ))));
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        );
                      }
                      return Container(
                          width: SizeConfig.cellSize / 0.9,
                          height: SizeConfig.cellSize / 0.9,
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
                                    List snapshot = await loadTalentString(
                                        'druid', entry.value);
                                    TalentTrees talentTreesObject =
                                        TalentTrees.fromJson(snapshot);
                                    Navigator.push(
                                        context,
                                        buildPageRoute(ChangeNotifierProvider<
                                                TalentProvider>(
                                            create: (_) {
                                              return TalentProvider(
                                                  talentTreesObject,
                                                  'druid',
                                                  entry.value,
                                                  [],
                                                  null,
                                                  [null, null, null],
                                                  [null, null, null],
                                                  [],
                                                  []);
                                            },
                                            child: DetailScreenContent(
                                              talentTrees: talentTreesObject,
                                              className: 'druid',
                                              classColor: classColors['druid']!,
                                              arrowTrees: getArrowClassByName(
                                                  'druid', entry.value),
                                            ))));
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ));
                    })
                  ])),
        ])));
  }
}
