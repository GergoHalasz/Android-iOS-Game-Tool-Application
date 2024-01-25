import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wowtalentcalculator/ArrowWidgets/class_arrow_widget.dart';
import 'package:wowtalentcalculator/DetailsScreen/detail_screen_content.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
import 'package:wowtalentcalculator/utils/routestyle.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:wowtalentcalculator/utils/string.dart';

class ClassesScreen extends StatefulWidget {
  final String expansion;

  ClassesScreen({required this.expansion});

  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
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
  late String currentExpansionSelected;

  List builds = [];
  Future<List> _getSavedBuilds() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();
    return keys.map((key) {
      if (key.contains("build_"))
        return {"build": jsonDecode(prefs.getString(key)!), "key": key};
    }).toList();
  }

  @override
  void initState() {
    currentExpansionSelected = widget.expansion;
    _getSavedBuilds().then((res) => {
          setState(() {
            builds = res;
          })
        });
    super.initState();
  }

  @override
  void didChangeDependencies() {
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

    return Scaffold(
      backgroundColor: Color(0xff556F7A),
      body: DefaultTextStyle(
        style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500),
        child: Stack(children: [
          Positioned.fill(
            child: Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/background/mage_fire.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '${capitalize(widget.expansion)} Classes',
                    style: TextStyle(fontSize: 24),
                  ),
                  Container(
                    child: SizedBox(
                        child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 70,
                      runSpacing: 20,
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
                                      child: InkWell(
                                        onTap: () async {
                                          loadInterstitialAd();
                                          List snapshot =
                                              await loadTalentString(
                                                  element, widget.expansion);
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
                                                            element,
                                                            widget.expansion,
                                                            []);
                                                      },
                                                      child:
                                                          DetailScreenContent(
                                                        talentTrees:
                                                            talentTreesObject,
                                                        className: element,
                                                        classColor: classColors[
                                                            element]!,
                                                        arrowTrees:
                                                            getArrowClassByName(
                                                                element,
                                                                widget
                                                                    .expansion),
                                                      ))));
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
                                  ),
                                  child: Container(
                                    child: InkWell(
                                      onTap: () async {
                                        loadInterstitialAd();
                                        List snapshot = await loadTalentString(
                                            element, widget.expansion);
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
                                                          element,
                                                          widget.expansion, []);
                                                    },
                                                    child: DetailScreenContent(
                                                      talentTrees:
                                                          talentTreesObject,
                                                      className: element,
                                                      classColor:
                                                          classColors[element]!,
                                                      arrowTrees:
                                                          getArrowClassByName(
                                                              element,
                                                              widget.expansion),
                                                    ))));

                                        // widget.changeClass(element);
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
                  Container(
                    width: SizeConfig.cellSize / 1.65 * 6,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(3),
                          color: Color(0xff2E6171),
                          child: Text('Saved builds'),
                        ),
                        Container(
                            height: 200,
                            child: ListView.builder(
                                itemCount: builds.length,
                                itemBuilder: (context, index) {
                                  if ((builds[index] != null &&
                                          currentExpansionSelected == "tbc" &&
                                          builds[index]["key"][0] == "t") ||
                                      (builds[index] != null &&
                                          currentExpansionSelected ==
                                              "vanilla" &&
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
                                                  onDeleteBuild(context,
                                                      builds[index]["key"]);
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
                                              margin: EdgeInsets.fromLTRB(
                                                  3, 0, 3, 3),
                                              child: ListTile(
                                                visualDensity:
                                                    VisualDensity(vertical: -4),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                dense: true,
                                                subtitle: Text(
                                                    '${builds[index]["build"]["build"][0]["Points"]}/${builds[index]["build"]["build"][1]["Points"]}/${builds[index]["build"]["build"][2]["Points"]}',
                                                    style: TextStyle(
                                                        color: classColors[
                                                            builds[index]
                                                                    ["build"][
                                                                "buildClass"]])),
                                                leading: Image.asset(
                                                  "assets/Class/${builds[index]["build"]["buildClass"]}.png",
                                                ),
                                                title: Text(
                                                  builds[index]["build"]
                                                      ["buildName"],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: classColors[
                                                          builds[index]["build"]
                                                              ["buildClass"]]),
                                                ),
                                                onTap: () {
                                                  String className =
                                                      builds[index]["build"]
                                                          ["buildClass"];
                                                  TalentTrees
                                                      talentTreesObject =
                                                      TalentTrees.fromJson(
                                                          builds[index]["build"]["build"]);
                                                  Navigator.push(
                                                      context,
                                                      buildPageRoute(
                                                          ChangeNotifierProvider<
                                                                  TalentProvider>(
                                                              create: (_) {
                                                                return TalentProvider(
                                                                    talentTreesObject,
                                                                    className,
                                                                    widget
                                                                        .expansion,
                                                                    []);
                                                              },
                                                              child:
                                                                  DetailScreenContent(
                                                                talentTrees:
                                                                    talentTreesObject,
                                                                className:
                                                                    className,
                                                                classColor:
                                                                    classColors[
                                                                        className]!,
                                                                arrowTrees:
                                                                    getArrowClassByName(
                                                                        className,
                                                                        widget
                                                                            .expansion),
                                                              ))));
                                                  loadInterstitialAd();
                                                  // widget.fetchSavedBuild(
                                                  //     builds[index]["build"],
                                                  //     builds[index]["key"]);
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
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
