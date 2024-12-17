import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/ArrowWidgets/class_arrow_widget.dart';
import 'package:wowtalentcalculator/DetailsScreen/detail_screen_content.dart';
import 'package:wowtalentcalculator/DetailsScreen/drawer_screen.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/model/glyph.dart';
import 'package:wowtalentcalculator/model/rune.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
import 'package:wowtalentcalculator/utils/routestyle.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:wowtalentcalculator/utils/string.dart';

class ClassesScreen extends StatefulWidget {
  final String expansion;
  final String backgroundImagePath;

  ClassesScreen({required this.expansion, required this.backgroundImagePath});

  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  List<String> expansions = ['vanilla', 'tbc', 'wotlk', 'cata'];

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
  bool firstTimeAdInit = true;
  BannerAd? banner;

  List builds = [];
  Future<List> _getSavedBuilds() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();
    List<dynamic> keysList = keys.map((key) {
      if (key.contains("build_"))
        return {"build": jsonDecode(prefs.getString(key)!), "key": key};
    }).toList();

    keysList = keysList.where((element) => element != null).toList();
    keysList.sort((a, b) {
      String keyA = a["key"];
      String keyB = b["key"];

      int indexA = int.parse(keyA[keyA.length - 1]);
      int indexB = int.parse(keyB[keyB.length - 1]);

      return indexB.compareTo(indexA);
    });

    return keysList;
  }

  @override
  void initState() {
    currentExpansionSelected = widget.expansion;
    _getSavedBuilds().then((res) {
      setState(() {
        builds = res;
      });
    });
    super.initState();
  }

  // void checkInternetConnection() async {
  //   bool result = await InternetConnectionChecker().hasConnection;
  //   if (result == true) {
  //   } else {
  //     showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               checkInternetConnection();
  //             },
  //             child: const Text('Connected'),
  //           )
  //         ],
  //         content: Text(
  //             'Please connect to the internet to proceed further. Click on the \"Connected\" button if you did connect to the internet.'),
  //         title: Text("No internet connection"),
  //       ),
  //     );
  //   }
  // }

  setSavedBuilds() {
    _getSavedBuilds().then((res) {
      setState(() {
        builds = res;
      });
    });
  }

  @override
  void didChangeDependencies() {
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
      // if (!adState.isAdFreeVersion) checkInternetConnection();
    }
  }

  onDeleteBuild(buildContext, key) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.remove(key);
    _getSavedBuilds().then((res) {
      setState(() {
        builds = res;
      });
    });
  }

  glyphSet(data) {
    if (data["minorGlyphs"] != null) {
      List<dynamic> minorGlyphs = data["minorGlyphs"].map((glyph) {
        if (glyph != null) {
          return Glyph.fromJson(glyph);
        }
        return null;
      }).toList();
      List<dynamic> majorGlyphs = data["majorGlyphs"].map((glyph) {
        if (glyph != null) {
          return Glyph.fromJson(glyph);
        }
        return null;
      }).toList();
    }
  }

  void shareBuild(data) {
    String talentPointsInLink = '';
    String expansionInLink = '';
    String link = '';
    TalentTrees talentTrees = TalentTrees.fromJson(data["build"]);
    String className = data["buildClass"];
    List<TalentTree> specTrees = talentTrees.specTreeList;
    for (var i = 0; i < specTrees.length; i++) {
      if (i != 0) {
        talentPointsInLink = talentPointsInLink + '-';
      }
      List<Talent> talents = specTrees[i].talents.talentList;
      for (int j = 0; j < talents.length; j++) {
        talentPointsInLink = talentPointsInLink + talents[j].points.toString();
      }
    }

    if (currentExpansionSelected == 'tbc') {
      expansionInLink = 'tbc.wowhead.com/talent-calc/${className}/';
    } else if (currentExpansionSelected == 'wotlk') {
      expansionInLink =
          'wowhead.com/wotlk/talent-calc/${className == 'deathknight' ? 'death-knight' : className}/';
    } else if (currentExpansionSelected == 'vanilla') {
      expansionInLink = 'classic.wowhead.com/talent-calc/${className}/';
    }

    link = 'https://' + expansionInLink + talentPointsInLink;
    Clipboard.setData(ClipboardData(text: link)).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Build url link copied to clipboard.")));
    });
  }

  getExpansionTitle() {
    if (widget.expansion == "vanilla")
      return "Vanilla Classes";
    else if (widget.expansion == "tbc")
      return "TBC Classes";
    else if (widget.expansion == 'wotlk')
      return "WotLK Classes";
    else if (widget.expansion == 'cata') return "Cataclysm Classes";
  }

  @override
  Widget build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 22, left: 12),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 83, 83, 83),
          child: Container(
            padding: EdgeInsets.all(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => {Navigator.pop(context)},
              child: Ink(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      bottomNavigationBar: !adState.isAdFreeVersion
          ? Container(
              height: 52,
              color: Colors.black,
              child: AdWidget(ad: banner!),
            )
          : null,
      body: Stack(children: [
        Positioned.fill(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(widget.backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '${getExpansionTitle()}',
                    style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24),
                  ),
                  Container(
                    child: SizedBox(
                        child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 70,
                      runSpacing: 20,
                      children: [
                        if (currentExpansionSelected == 'wotlk' ||
                            currentExpansionSelected == 'cata')
                          ...wotlkClasses.map((element) {
                            return Container(
                                width: SizeConfig.cellSize / 1.45,
                                height: SizeConfig.cellSize / 1.45,
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
                                          
                                          adState.interstitialAdCounter++;
                                          adState
                                              .showInterstitialAdClassScreen();
                                          List snapshot =
                                              await loadTalentString(
                                                  element,
                                                  widget.expansion);
                                          TalentTrees talentTreesObject =
                                              TalentTrees.fromJson(
                                                  snapshot);
                                          Navigator.push(
                                              context,
                                              buildPageRoute(
                                                  ChangeNotifierProvider<
                                                          TalentProvider>(
                                                      create: (_) {
                                                        return TalentProvider(
                                                            talentTreesObject,
                                                            element,
                                                            widget
                                                                .expansion,
                                                            [],
                                                            null,
                                                            [
                                                              null,
                                                              null,
                                                              null
                                                            ],
                                                            [
                                                              null,
                                                              null,
                                                              null
                                                            ],
                                                            [],
                                                            []);
                                                      },
                                                      child:
                                                          DetailScreenContent(
                                                        talentTrees:
                                                            talentTreesObject,
                                                        className: element,
                                                        classColor:
                                                            classColors[
                                                                element]!,
                                                        arrowTrees:
                                                            getArrowClassByName(
                                                                element,
                                                                widget
                                                                    .expansion),
                                                      )))).then(
                                              (value) => setSavedBuilds());
                                        },
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ));
                          })
                        else
                          ...tbcVanillaClasses.map((element) {
                            return Container(
                              width: SizeConfig.cellSize / 1.45,
                              height: SizeConfig.cellSize / 1.45,
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
                                        if (adState.interstitialAd ==
                                            null) {
                                          adState.loadInterstitialAd();
                                        }
                                        adState.interstitialAdCounter++;
                                        adState
                                            .showInterstitialAdClassScreen();
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
                                                          [],
                                                          null,
                                                          [
                                                            null,
                                                            null,
                                                            null
                                                          ],
                                                          [
                                                            null,
                                                            null,
                                                            null
                                                          ],
                                                          [],
                                                          []);
                                                    },
                                                    child:
                                                        DetailScreenContent(
                                                      talentTrees:
                                                          talentTreesObject,
                                                      className: element,
                                                      classColor:
                                                          classColors[
                                                              element]!,
                                                      arrowTrees:
                                                          getArrowClassByName(
                                                              element,
                                                              widget
                                                                  .expansion),
                                                    )))).then(
                                            (value) => setSavedBuilds());
      
                                        // widget.changeClass(element);
                                      },
                                      borderRadius:
                                          BorderRadius.circular(10),
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
                    width: SizeConfig.cellSize / 1.35 * 5.5,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(3),
                          color: Color.fromARGB(255, 83, 83, 83),
                          child:
                              Text('Saved builds - Swipe to Delete', style: TextStyle(color: Colors.white),),
                        ),
                        Container(
                            height: 200,
                            child: RawScrollbar(
                              thumbColor: Colors.grey,
                              thumbVisibility: true,
                              thickness: 3.5,
                              radius: Radius.circular(20),
                              controller: _scrollController,
                              child: ListView.builder(
                                  controller: _scrollController,
                                  padding: EdgeInsets.all(4),
                                  itemCount: builds.length,
                                  itemBuilder: (context, index) {
                                    if ((builds[index] != null &&
                                            currentExpansionSelected ==
                                                "tbc" &&
                                            builds[index]["key"][0] ==
                                                "t") ||
                                        (builds[index] != null &&
                                            currentExpansionSelected ==
                                                "vanilla" &&
                                            builds[index]["key"][0] ==
                                                "v") ||
                                        (builds[index] != null &&
                                            currentExpansionSelected ==
                                                "wotlk" &&
                                            builds[index]["key"][0] ==
                                                "w") ||
                                        (builds[index] != null &&
                                            currentExpansionSelected ==
                                                "cata" &&
                                            builds[index]["key"][0] ==
                                                "c")) {
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
                                                        context,
                                                        builds[index]
                                                            ["key"]);
                                                  },
                                                  backgroundColor:
                                                      Colors.red,
                                                  foregroundColor:
                                                      Colors.white,
                                                  icon: Icons.delete,
                                                ),
                                              ],
                                            ),
                                            startActionPane: ActionPane(
                                              extentRatio: 1 / 5,
                                              // A motion is a widget used to control how the pane animates.
                                              motion: const ScrollMotion(),
      
                                              // A pane can dismiss the Slidable.
      
                                              // All actions are defined in the children parameter.
                                              children: [
                                                // A SlidableAction can have an icon and/or a label.
                                                SlidableAction(
                                                  onPressed: (context) {
                                                    shareBuild(builds[index]
                                                        ["build"]);
                                                  },
                                                  backgroundColor:
                                                      Colors.blue,
                                                  foregroundColor:
                                                      Colors.white,
                                                  icon: Icons.share,
                                                ),
                                              ],
                                            ),
                                            child: Container(
                                              child: Card(
                                                color: Colors.grey.shade700,
                                                margin: EdgeInsets.fromLTRB(
                                                    3, 0, 3, 3),
                                                child: ListTile(
                                                  visualDensity:
                                                      VisualDensity(
                                                          vertical: -4),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 12),
                                                  dense: true,
                                                  subtitle: Text(
                                                      '${builds[index]["build"]["build"][0]["Points"]}/${builds[index]["build"]["build"][1]["Points"]}/${builds[index]["build"]["build"][2]["Points"]}',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                          color: classColors[
                                                              builds[index][
                                                                      "build"]
                                                                  [
                                                                  "buildClass"]])),
                                                  leading: Image.asset(
                                                    "assets/Class/${builds[index]["build"]["buildClass"]}.png",
                                                  ),
                                                  title: Text(
                                                    builds[index]["build"]
                                                        ["buildName"],
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',

                                                        fontSize: 15,
                                                        color: classColors[
                                                            builds[index][
                                                                    "build"]
                                                                [
                                                                "buildClass"]]),
                                                  ),
                                                  onTap: () {
                                                    if (adState
                                                            .interstitialAd ==
                                                        null) {
                                                      adState
                                                          .loadInterstitialAd();
                                                    }
                                                    adState
                                                        .interstitialAdCounter++;
                                                    adState
                                                        .showInterstitialAdClassScreen();
                                                    String className =
                                                        builds[index]
                                                                ["build"]
                                                            ["buildClass"];
                                                    String buildName =
                                                        builds[index]
                                                                ["build"]
                                                            ["buildName"];
                                                    TalentTrees
                                                        talentTreesObject =
                                                        TalentTrees.fromJson(
                                                            builds[index][
                                                                    "build"]
                                                                ["build"]);
                                                    String key =
                                                        builds[index]
                                                            ["key"];
                                                    List<dynamic>
                                                        minorGlyphs = [];
                                                    List<dynamic>
                                                        majorGlyphs = [];
                                                    List<dynamic>
                                                        selectedRunes = [];
                                                    dynamic data =
                                                        builds[index]
                                                            ["build"];
                                                    if (builds[index]
                                                                ["build"][
                                                            "selectedRunes"] !=
                                                        null) {
                                                      selectedRunes = builds[
                                                                  index]
                                                              ["build"]
                                                          ["selectedRunes"];
                                                      selectedRunes.forEach(
                                                          (selectedRune) {
                                                        switch (
                                                            selectedRune[
                                                                "type"]) {
                                                          case "Chest":
                                                            selectedRune[
                                                                    "rune"] =
                                                                new Chest
                                                                    .fromJson(
                                                                    selectedRune[
                                                                        "rune"]);
                                                            break;
                                                          case "Waist":
                                                            selectedRune[
                                                                    "rune"] =
                                                                new Waist
                                                                    .fromJson(
                                                                    selectedRune[
                                                                        "rune"]);
                                                            break;
                                                          case "Legs":
                                                            selectedRune[
                                                                    "rune"] =
                                                                new Legs
                                                                    .fromJson(
                                                                    selectedRune[
                                                                        "rune"]);
                                                            break;
                                                          case "Feet":
                                                            selectedRune[
                                                                    "rune"] =
                                                                new Feet
                                                                    .fromJson(
                                                                    selectedRune[
                                                                        "rune"]);
                                                            break;
                                                          case "Hands":
                                                            selectedRune[
                                                                    "rune"] =
                                                                new Hands
                                                                    .fromJson(
                                                                    selectedRune[
                                                                        "rune"]);
                                                            break;
                                                          case "Head":
                                                            selectedRune[
                                                                    "rune"] =
                                                                new Head
                                                                    .fromJson(
                                                                    selectedRune[
                                                                        "rune"]);
                                                            break;
                                                          case "Wrists":
                                                            selectedRune[
                                                                    "rune"] =
                                                                new Head
                                                                    .fromJson(
                                                                    selectedRune[
                                                                        "rune"]);
                                                            break;
                                                        }
                                                      });
                                                    }
                                                    if (data[
                                                            "minorGlyphs"] !=
                                                        null) {
                                                      minorGlyphs = data[
                                                              "minorGlyphs"]
                                                          .map((glyph) {
                                                        if (glyph != null) {
                                                          return Glyph
                                                              .fromJson(
                                                                  glyph);
                                                        }
                                                        return null;
                                                      }).toList();
      
                                                      majorGlyphs = data[
                                                              "majorGlyphs"]
                                                          .map((glyph) {
                                                        if (glyph != null) {
                                                          return Glyph
                                                              .fromJson(
                                                                  glyph);
                                                        }
                                                        return null;
                                                      }).toList();
                                                    }
      
                                                    Navigator.push(
                                                        context,
                                                        buildPageRoute(
                                                            ChangeNotifierProvider<
                                                                    TalentProvider>(
                                                                create:
                                                                    (_) {
                                                                  return TalentProvider(
                                                                      talentTreesObject,
                                                                      className,
                                                                      widget
                                                                          .expansion,
                                                                      [],
                                                                      buildName,
                                                                      minorGlyphs,
                                                                      majorGlyphs,
                                                                      [],
                                                                      selectedRunes);
                                                                },
                                                                child:
                                                                    DetailScreenContent(
                                                                  buildName:
                                                                      buildName,
                                                                  buildKey:
                                                                      key,
                                                                  talentTrees:
                                                                      talentTreesObject,
                                                                  className:
                                                                      className,
                                                                  classColor:
                                                                      classColors[
                                                                          className]!,
                                                                  arrowTrees: getArrowClassByName(
                                                                      className,
                                                                      widget
                                                                          .expansion),
                                                                )))).then(
                                                        (value) =>
                                                            setSavedBuilds());
                                                  },
                                                ),
                                              ),
                                            ))
                                      ]);
                                    } else
                                      return Container();
                                  }),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
