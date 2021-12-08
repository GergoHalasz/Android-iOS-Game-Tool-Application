import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/string.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  List<String> expansions = ['vanilla', 'tbc', 'wotlk'];
  List builds = [];
  late TalentProvider talentProvider;
  Future<List> _getSavedBuilds() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();
    return keys.map((key) {
      if (key.contains("build_"))
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

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  onDeleteBuild(buildContext, key) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.remove(key);
  }

  @override
  Widget build(BuildContext context) {
    talentProvider = Provider.of<TalentProvider>(context);
    final adState = Provider.of<AdState>(context);

    loadInterstitialAd() {
      if (adState.interstitialAdCounter == 1) {
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
                print('InterstitialAd failed to load: $error');
              },
            ));
      } else {
        adState.interstitialAdCounter++;
      }
    }

    showWotlkDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Wotlk soon"),
              content: new Text(
                  "The Wotlk expansion is currently under development. It's coming soon!"),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

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
                              if (element != "wotlk") {
                                talentProvider.changeExpansion(element);
                                widget.changeClass(talentProvider.className);
                              } else {
                                Future.delayed(Duration.zero,
                                    () => showWotlkDialog(context));
                              }
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
                              widget.changeClass(element);
                              loadInterstitialAd();
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
                      if ((obj != null &&
                              talentProvider.expansion == "tbc" &&
                              obj["key"][0] == "t") ||
                          (obj != null &&
                              talentProvider.expansion == "vanilla" &&
                              obj["key"][0] == "v")) {
                        return Column(
                          children: [
                            Slidable(
                              key: Key(obj["key"]),
                              endActionPane: ActionPane(
                                extentRatio: 1 / 5,
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),

                                // A pane can dismiss the Slidable.

                                // All actions are defined in the children parameter.
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    onPressed: (context) {
                                      onDeleteBuild(context, obj["key"]);
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                  )
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
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
