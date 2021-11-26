import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/string.dart';

class DrawerScreen extends StatefulWidget {
  Function changeClass;
  Function fetchSavedBuild;

  DrawerScreen({required this.changeClass, required this.fetchSavedBuild});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isOpen = false;
  List<String> classes = [
    'druid',
    'hunter',
    'mage',
    'paladin',
    'priest',
    'rogue',
    'shaman',
    'warlock',
    'warrior'
  ];
  List<String> expansions = ['vanilla', 'tbc'];
  List builds = [];
  late TalentProvider talentProvider;
  Future<List> _getSavedBuilds() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();

    return keys.map((key) {
      return {"build": jsonDecode(prefs.getString(key)!), "key": key};
    }).toList();
  }

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _getSavedBuilds().then((res) => {
          setState(() {
            builds = res;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    talentProvider = Provider.of<TalentProvider>(context);

    return Material(
      color: Colors.grey.shade800,
      child: DefaultTextStyle(
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15),
              child: Text('Builds'),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(color: Colors.white12, height: 0),
            Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.white12),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  collapsedIconColor: Colors.white,
                  title: Text('Expansions',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500)),
                  children: [
                    ...expansions.map((element) {
                      return Column(
                        children: [
                          ListTile(
                            selected: element == talentProvider.expansion,
                            selectedTileColor: Colors.amber[700],
                            onTap: () {
                              talentProvider.changeExpansion(element);
                              widget.changeClass(talentProvider.className);
                            },
                            dense: true,
                            title: Text(
                              capitalize(element),
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/Icons/WoW_$element.ico"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Divider(color: Colors.white12, height: 0)
                        ],
                      );
                    }),
                  ],
                )),
            Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.white12),
                child: ExpansionTile(
                  collapsedIconColor: Colors.white,
                  title: Text('New Builds',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500)),
                  children: [
                    ...classes.map((element) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              if (adState.interstitialAdCounter == 2) {
                                adState.interstitialAdCounter = 0;
                                adState.interstitialAd?.show();
                                InterstitialAd.load(
                                    adUnitId: adState.interstitialAdUnitId,
                                    request: AdRequest(),
                                    adLoadCallback: InterstitialAdLoadCallback(
                                      onAdLoaded: (InterstitialAd ad) {
                                        adState.interstitialAd = ad;
                                      },
                                      onAdFailedToLoad: (LoadAdError error) {
                                        print(
                                            'InterstitialAd failed to load: $error');
                                      },
                                    ));
                              } else {
                                adState.interstitialAdCounter++;
                              }
                              widget.changeClass(element);
                            },
                            dense: true,
                            title: Text(
                              capitalize(element),
                              style: TextStyle(color: classColors[element]),
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/Class/icon_$element.png"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Divider(color: Colors.white12, height: 0)
                        ],
                      );
                    }),
                  ],
                )),
            Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.white12),
                child: ExpansionTile(
                  collapsedIconColor: Colors.white,
                  title: Text('Saved Builds',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500)),
                  children: [
                    ...builds.map((obj) {
                      if ((talentProvider.expansion == "tbc" &&
                              obj["key"][0] == "t") ||
                          (talentProvider.expansion == "vanilla" &&
                              obj["key"][0] == "v")) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                if (adState.interstitialAdCounter == 2) {
                                  adState.interstitialAdCounter = 0;
                                  adState.interstitialAd?.show();
                                  InterstitialAd.load(
                                      adUnitId: adState.interstitialAdUnitId,
                                      request: AdRequest(),
                                      adLoadCallback:
                                          InterstitialAdLoadCallback(
                                        onAdLoaded: (InterstitialAd ad) {
                                          adState.interstitialAd = ad;
                                        },
                                        onAdFailedToLoad: (LoadAdError error) {
                                          print(
                                              'InterstitialAd failed to load: $error');
                                        },
                                      ));
                                } else {
                                  adState.interstitialAdCounter++;
                                }
                                widget.fetchSavedBuild(
                                    obj["build"], obj["key"]);
                              },
                              dense: true,
                              title: Text(obj["build"]["buildName"],
                                  style: TextStyle(
                                      color: classColors[obj["build"]
                                          ["buildClass"]])),
                              subtitle: Text(
                                  '${obj["build"]["build"][0]["Points"]}/${obj["build"]["build"][1]["Points"]}/${obj["build"]["build"][2]["Points"]}',
                                  style: TextStyle(
                                      color: classColors[obj["build"]
                                          ["buildClass"]])),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/Class/icon_${obj["build"]["buildClass"]}.png"),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Divider(color: Colors.white12, height: 0)
                          ],
                        );
                      } else
                        return Container();
                    })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
