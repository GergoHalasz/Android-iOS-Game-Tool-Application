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
    'deathknight',
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
  ScrollController _scrollController = ScrollController();
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
    SharedPreferences.getInstance().then((value) {
      currentExpansionSelected = value.getString('expansion')!;
    });

    talentProvider = Provider.of<TalentProvider>(context);
    final adState = Provider.of<AdState>(context);
    if (adState.interstitialAd == null && !adState.isAdFreeVersion) {
      adState.createInterstitialAd();
    }

    super.didChangeDependencies();
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
      if (!adState.isAdFreeVersion) {
        if (adState.interstitialAdCounter >= 1) {
          adState.interstitialAdCounter = 0;
          adState.interstitialAd?.show();
          adState.interstitialAd?.dispose();
          adState.createInterstitialAd();
        } else {
          adState.interstitialAdCounter++;
        }
      }
    }

    return AlertDialog(
      backgroundColor: Color(0xff556F7A),
      title: new Text(
        'Choose expansion and create or see saved builds',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      content: DefaultTextStyle(
        style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 45,
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
                      setState(() {
                        currentExpansionSelected = value as String;
                      });
                    }),
              ),
            ),
            Container(
              height: SizeConfig.cellSize / 1.7 * 3 + 40,
              child: RawScrollbar(
                thumbColor: Colors.white,
                isAlwaysShown: true,
                thickness: 3.5,
                radius: Radius.circular(20),
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, right: 3.5),
                    child: SizedBox(
                        child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 27,
                      runSpacing: 10,
                      children: [
                        if (currentExpansionSelected == 'wotlk')
                          ...wotlkClasses.map((element) {
                            return Container(
                                width: SizeConfig.cellSize / 1.65,
                                height: SizeConfig.cellSize / 1.65,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/Class/$element.png"),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade700,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: InkWell(
                                        onTap: () async {
                                          final prefs = await SharedPreferences.getInstance();
                                          Navigator.pop(context);
                                          loadInterstitialAd();
                                          prefs.setString('expansion', currentExpansionSelected);
                                          talentProvider.changeExpansion(
                                              currentExpansionSelected);
                                          widget.changeClass(element);
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ));
                          })
                        else
                          ...tbcVanillaClasses.map((element) {
                            return Container(
                              width: SizeConfig.cellSize / 1.65,
                              height: SizeConfig.cellSize / 1.65,
                              child: Material(
                                color: Colors.transparent,
                                child: Ink(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/Class/$element.png"),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade700,
                                          width: 3,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: InkWell(
                                      onTap: () async {
                                        final prefs = await SharedPreferences.getInstance();
                                        Navigator.pop(context);
                                        loadInterstitialAd();
                                        prefs.setString('expansion', currentExpansionSelected);
                                        talentProvider.changeExpansion(
                                            currentExpansionSelected);
                                        widget.changeClass(element);
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                      ],
                    )),
                  ),
                ),
              ),
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
                                    builds[index]["key"][0] == "v") ||
                                (builds[index] != null &&
                                    currentExpansionSelected == "wotlk" &&
                                    builds[index]["key"][0] == "w")) {
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
                                    child: Container(
                                      child: Card(
                                        color: Colors.grey.shade700,
                                        margin: EdgeInsets.fromLTRB(3, 0, 3, 3),
                                        child: ListTile(
                                          visualDensity:
                                              VisualDensity(vertical: -4),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          dense: true,
                                          subtitle: Text(
                                              '${builds[index]["build"]["build"][0]["Points"]}/${builds[index]["build"]["build"][1]["Points"]}/${builds[index]["build"]["build"][2]["Points"]}',
                                              style: TextStyle(
                                                  color: classColors[
                                                      builds[index]["build"]
                                                          ["buildClass"]])),
                                          leading: Image.asset(
                                            "assets/Class/${builds[index]["build"]["buildClass"]}.png",
                                          ),
                                          title: Text(
                                            builds[index]["build"]["buildName"],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: classColors[builds[index]
                                                    ["build"]["buildClass"]]),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                            loadInterstitialAd();
                                            talentProvider.changeExpansion(
                                            currentExpansionSelected);
                                            widget.fetchSavedBuild(
                                                builds[index]["build"],
                                                builds[index]["key"]);
                                          },
                                        ),
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
