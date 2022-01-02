import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:wowtalentcalculator/utils/string.dart';

class NewBuildDialog extends StatefulWidget {
  Function changeClass;
  Function fetchSavedBuild;

  NewBuildDialog({required this.changeClass, required this.fetchSavedBuild});

  @override
  _NewBuildDialogState createState() => _NewBuildDialogState();
}

class _NewBuildDialogState extends State<NewBuildDialog> {
  List<String> expansions = ['vanilla', 'tbc', 'wotlk'];
  List<String> wotlkClasses = [
    'druid',
    'hunter',
    'mage',
    'paladin',
    'priest',
    'rogue',
    'shaman',
    'warlock',
    'warrior',
    'deathknight'
  ];
  List<String> tbcVanillaClasses = [
    'druid',
    'hunter',
    'mage',
    'paladin',
    'priest',
    'rogue',
    'shaman',
    'warlock',
    'warrior',
  ];
  String currentExpansionSelected = 'tbc';
  List builds = [];
  Future<List> _getSavedBuilds() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();
    return keys.map((key) {
      if (key.contains("build_"))
        return {"build": jsonDecode(prefs.getString(key)!), "key": key};
    }).toList();
  }

  late TalentProvider talentProvider;

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
  void didChangeDependencies() {
    talentProvider = Provider.of<TalentProvider>(context);
    currentExpansionSelected = talentProvider.expansion;
    super.didChangeDependencies();
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

  onDeleteBuild(buildContext, key) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.remove(key);
    _getSavedBuilds().then((res) => {
          setState(() {
            builds = res;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
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

    return AlertDialog(
      backgroundColor: Color(0xff556F7A),
      title: new Text(
        'Choose expansion and create or see saved builds',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      content: DefaultTextStyle(
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    selectedItemBuilder: (_) {
                      return expansions
                          .map((e) => Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  capitalize(e),
                                ),
                              ))
                          .toList();
                    },
                    style: TextStyle(color: Colors.white),
                    iconSize: 30,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    value: currentExpansionSelected,
                    items: expansions.map((item) {
                      return DropdownMenuItem(
                          value: item,
                          child: Text(
                            capitalize(item),
                            style: TextStyle(color: Colors.black),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      if (value == 'wotlk') {
                        showWotlkDialog(context);
                      } else {
                        setState(() {
                          currentExpansionSelected = value as String;
                        });
                      }
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: SizedBox(
                  child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 30,
                runSpacing: 10,
                children: [
                  if (currentExpansionSelected == 'wotlk')
                    ...wotlkClasses.map((element) {
                      return Container(
                        width: SizeConfig.cellSize / 1.7,
                        height: SizeConfig.cellSize / 1.7,
                        child: Material(
                          color: Colors.transparent,
                          child: Ink.image(
                            image: AssetImage("assets/Class/$element.png"),
                            fit: BoxFit.cover,
                            child: InkWell(
                              onTap: () {
                                loadInterstitialAd();
                                widget.changeClass(element);
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    })
                  else
                    ...tbcVanillaClasses.map((element) {
                      return Container(
                        width: SizeConfig.cellSize / 1.7,
                        height: SizeConfig.cellSize / 1.7,
                        child: Material(
                          color: Colors.transparent,
                          child: Ink.image(
                            image: AssetImage("assets/Class/$element.png"),
                            fit: BoxFit.cover,
                            child: InkWell(
                              onTap: () {
                                loadInterstitialAd();
                                talentProvider
                                    .changeExpansion(currentExpansionSelected);
                                widget.changeClass(element);
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    })
                ],
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(3),
                    width: double.infinity,
                    color: Color(0xff2E6171),
                    child: Text('Saved builds'),
                  ),
                  Container(
                      width: double.maxFinite,
                      height: SizeConfig.screenHeight / 5,
                      child: ListView.builder(
                          itemCount: builds.length,
                          itemBuilder: (context, index) {
                            if ((builds[index] != null &&
                                    currentExpansionSelected == "tbc" &&
                                    builds[index]["key"][0] == "t") ||
                                (builds[index] != null &&
                                    currentExpansionSelected == "vanilla" &&
                                    builds[index]["key"][0] == "v")) {
                              return Column(children: [
                                Slidable(
                                    key: Key(builds[index]["key"]),
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
                                            onDeleteBuild(
                                                context, builds[index]["key"]);
                                          },
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                        )
                                      ],
                                    ),
                                    child: Card(
                                      color: Colors.grey.shade700,
                                      margin: EdgeInsets.fromLTRB(3, 0, 3, 3),
                                      child: ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        dense: true,
                                        subtitle: Transform.translate(
                                          offset: Offset(-16, -5),
                                          child: Text(
                                              '${builds[index]["build"]["build"][0]["Points"]}/${builds[index]["build"]["build"][1]["Points"]}/${builds[index]["build"]["build"][2]["Points"]}',
                                              style: TextStyle(
                                                  color: classColors[
                                                      builds[index]["build"]
                                                          ["buildClass"]])),
                                        ),
                                        leading: Image.asset(
                                          "assets/Class/${builds[index]["build"]["buildClass"]}.png",
                                          width: 45,
                                          height: 45,
                                        ),
                                        title: Transform.translate(
                                          offset: Offset(-16, -5),
                                          child: Text(
                                            builds[index]["build"]["buildName"],
                                            style: TextStyle(
                                                color: classColors[builds[index]
                                                    ["build"]["buildClass"]]),
                                          ),
                                        ),
                                        onTap: () {
                                          widget.fetchSavedBuild(
                                              builds[index]["build"],
                                              builds[index]["key"]);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ))
                              ]);
                            } else
                              return Container();
                          }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
