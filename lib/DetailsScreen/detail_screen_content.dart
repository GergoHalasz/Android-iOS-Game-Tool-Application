import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wowtalentcalculator/ArrowWidgets/class_arrow_widget.dart';
import 'package:wowtalentcalculator/DetailsScreen/Save_screen.dart';
import 'package:wowtalentcalculator/DetailsScreen/drawer_screen.dart';
import 'package:wowtalentcalculator/DetailsScreen/glyphs_screen.dart';
import 'package:wowtalentcalculator/DetailsScreen/newBuild_dialog.dart';
import 'package:wowtalentcalculator/DetailsScreen/runes_dialog.dart';
import 'package:wowtalentcalculator/DetailsScreen/talent_dialog.dart';
import 'package:wowtalentcalculator/data/menu_items.dart';
import 'package:wowtalentcalculator/model/glyph.dart';
import 'package:wowtalentcalculator/model/menu_item.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:wowtalentcalculator/utils/string.dart' as str;
import 'package:wowtalentcalculator/DetailsScreen/talent_tree_widget.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/constants.dart';
import 'package:wowtalentcalculator/widgets/custom_page_route.dart';
import '../ad_state.dart';
import '../api/purchase_api.dart';

// detail screen content below the tabs bar
class DetailScreenContent extends StatefulWidget {
  final String className;
  final Color classColor;
  final List arrowTrees;
  final String buildKey;
  final String buildName;

  final TalentTrees talentTrees;

  DetailScreenContent(
      {required this.className,
      required this.talentTrees,
      required this.classColor,
      required this.arrowTrees,
      this.buildKey = "",
      this.buildName = ""});

  @override
  _DetailScreenContentState createState() => _DetailScreenContentState();
}

class _DetailScreenContentState extends State<DetailScreenContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TalentProvider talentProvider;
  int _selectedIndex = 0;
  String buildName = "";
  String buildKey = "";
  bool firstTimeAdInit = true;
  late TalentTrees talentTrees;
  late String className;
  late Color classColor;
  late List arrowTrees;
  Key talentTree1Key = UniqueKey();
  Key talentTree2Key = UniqueKey();
  Key talentTree3Key = UniqueKey();
  BannerAd? banner;
  String _termsUrl =
      'https://github.com/HalaszGergo123/wow-talent-calculator/blob/main/terms_and_conditions.md';
  String _privacyUrl =
      'https://github.com/HalaszGergo123/wow-talent-calculator/blob/main/privacy_policy.md';
  int interstitialAdCounter = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        _tabController.addListener(() {
          setState(() {
            _selectedIndex = _tabController.index;
          });
        });
      });
      // if (!adState.isAdFreeVersion) checkInternetConnection();
    }
  }

  @override
  initState() {
    super.initState();
    if (widget.buildKey != "") {
      buildKey = widget.buildKey;
      buildName = widget.buildName;
    }

    talentTrees = widget.talentTrees;
    className = widget.className;
    classColor = widget.classColor;
    arrowTrees = widget.arrowTrees;
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

  TabBar _tabBar() => TabBar(
        controller: _tabController,
        dividerColor: Colors.grey,
        indicatorColor: classColor,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            icon: Image.asset(
              "assets/Icons/${talentTrees.specTreeList[0].icon}.png",
              width: kTabIconSize,
            ),
          ),
          Tab(
              icon: Image.asset(
            "assets/Icons/${talentTrees.specTreeList[1].icon}.png",
            width: kTabIconSize,
          )),
          Tab(
              icon: Image.asset(
            "assets/Icons/${talentTrees.specTreeList[2].icon}.png",
            width: kTabIconSize,
          )),
        ],
      );

  changeClass(String name) => {
        loadTalentString(name, talentProvider.expansion).then((value) {
          TalentTrees talentTreesObject = TalentTrees.fromJson(value);
          talentProvider.changeClass(talentTreesObject, name);
          talentProvider.changeBuildName(null);
          talentProvider.setGlyphs([null, null, null], [null, null, null]);
          setState(() {
            buildKey = "";
            buildName = "";
            talentTrees = talentTreesObject;
            classColor = classColors[name]!;
            className = name;
            arrowTrees = getArrowClassByName(name, talentProvider.expansion);
            talentTree1Key = UniqueKey();
            talentTree2Key = UniqueKey();
            talentTree3Key = UniqueKey();
          });
        })
      };

  fetchSavedBuild(data, key) {
    String name = data["buildClass"];
    TalentTrees talentTreesObject = TalentTrees.fromJson(data["build"]);
    talentProvider.changeClass(talentTreesObject, name);
    talentProvider.changeBuildName(data["buildName"]);

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
      talentProvider.setGlyphs(minorGlyphs, majorGlyphs);
    } else {
      talentProvider.setGlyphs([null, null, null], [null, null, null]);
    }
    setState(() {
      this.buildKey = key;
      buildName = data["buildName"];
      talentTrees = talentTreesObject;
      classColor = classColors[name]!;
      className = name;
      arrowTrees = getArrowClassByName(name, talentProvider.expansion);
      talentTree1Key = UniqueKey();
      talentTree2Key = UniqueKey();
      talentTree3Key = UniqueKey();
    });
  }


  showAddBuildDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider<TalentProvider>.value(
              value: talentProvider,
              child: NewBuildDialog(
                fetchSavedBuild: fetchSavedBuild,
                changeClass: changeClass,
              ));
        });
  }

  showSaveBuildDialog(bool isGlyphSet) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider<TalentProvider>.value(
              value: talentProvider,
              child: SaveScreen(
                  changeBuildKeyAndName: (key, buildName) {
                    setState(() {
                      this.buildKey = key;
                      this.buildName = buildName;
                    });
                  },
                  changeBuildName: (buildName) {
                    setState(() {
                      this.buildName = buildName;
                    });
                  },
                  buildName: buildName,
                  buildKey: buildKey,
                  isGlyphSet: isGlyphSet));
        });
  }
  

  @override
  Widget build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    // get the current level to display at the top corner
    // display level 10 for starting
    talentProvider = Provider.of<TalentProvider>(context);
    int level = Provider.of<TalentProvider>(context).getTotalTalentPoints();
    int firstTalentTreePoints = Provider.of<TalentProvider>(context)
        .getTalentTreePoints(talentTrees.specTreeList[0].name);
    int secondTalentTreePoints = Provider.of<TalentProvider>(context)
        .getTalentTreePoints(talentTrees.specTreeList[1].name);
    int thirdTalentTreePoints = Provider.of<TalentProvider>(context)
        .getTalentTreePoints(talentTrees.specTreeList[2].name);

    if (level == 9) {
      level = 10;
    }

    return Scaffold(
      drawer: Drawer(
          child: DrawerScreen(
        fetchSavedBuild: fetchSavedBuild,
        changeClass: changeClass,
      )),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: !adState.isAdFreeVersion ? 45 : 15),
        child: FloatingActionButton(
            onPressed: showAddBuildDialog,
            backgroundColor: Color(0xffB79FAD),
            child: Icon(
              Icons.add,
              size: 35,
            )),
      ),
      bottomNavigationBar: !adState.isAdFreeVersion
          ? Container(
              height: 52,
              color: Colors.black,
              child: AdWidget(ad: banner!),
            )
          : null,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
              talentProvider.buildName == null
                  ? '${talentTrees.specTreeList[_selectedIndex].name}'
                  : talentProvider.buildName!,
              style: TextStyle(color: kColorSelectiveYellow)),
          actions: <Widget>[
            Container(
              child: InkResponse(
                child: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onTap: () {
                  bool isGlyphSet = true;
                  if (talentProvider.expansion == 'wotlk' &&
                      (listEquals(
                              talentProvider.minorGlyphs, [null, null, null]) &&
                          listEquals(
                              talentProvider.majorGlyphs, [null, null, null])))
                    isGlyphSet = false;

                  showSaveBuildDialog(isGlyphSet);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Container(
                child: InkResponse(
                  child: Icon(
                    Icons.refresh_outlined,
                    color: Colors.white,
                  ),
                  onTap: () {
                    if (adState.interstitialAd == null) {
                      adState.loadInterstitialAd();
                    }
                    interstitialAdCounter++;
                    if (interstitialAdCounter == 6) {
                      adState.showInterstitialAd();
                      interstitialAdCounter = 0;
                    }
                    talentProvider.resetTalentTree(_selectedIndex);
                  },
                ),
              ),
            ),
            DividerTheme(
              data: DividerThemeData(
                  color: const Color.fromARGB(255, 49, 49, 49)),
              child: PopupMenuButton<MenuItemPopUp>(
                icon: Icon(Icons.more_horiz, color: Colors.white),
                offset: Offset(0, 56),
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                  ...MenuItems.itemsFirst.map(buildItem).toList(),
                  if (talentProvider.expansion == 'wotlk')
                    ...MenuItems.itemsThird.map(buildItem).toList(),
                  ...MenuItems.itemsForth.map(buildItem).toList(),
                ],
                color: Color.fromARGB(255, 57, 57, 57),
              ),
            )
          ],
          backgroundColor: Color.fromARGB(255, 57, 57, 57),
          bottom: PreferredSize(
              preferredSize: _tabBar().preferredSize,
              child: ColoredBox(
                  color: Color.fromARGB(255, 83, 83, 83), child: _tabBar()))),
      body: DefaultTextStyle(
        style: TextStyle(
            color: Colors.white, fontFamily: 'Morpheus', fontSize: 18),
        child: Column(
          children: [
            Container(
                height: SizeConfig.blockSizeVertical * 4.5,
                color: Color.fromARGB(255, 83, 83, 83),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Text('$firstTalentTreePoints ',
                                  style: TextStyle(
                                      color: _selectedIndex == 0
                                          ? kColorSelectiveYellow
                                          : Colors.white)),
                              Text('/'),
                              Text(' $secondTalentTreePoints ',
                                  style: TextStyle(
                                      color: _selectedIndex == 1
                                          ? kColorSelectiveYellow
                                          : Colors.white)),
                              Text('/'),
                              Text(' $thirdTalentTreePoints ',
                                  style: TextStyle(
                                      color: _selectedIndex == 2
                                          ? kColorSelectiveYellow
                                          : Colors.white)),
                              Text('('),
                              Text(
                                  '${firstTalentTreePoints + secondTalentTreePoints + thirdTalentTreePoints}',
                                  style:
                                      TextStyle(color: kColorSelectiveYellow)),
                              Text(')'),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              Text('Remaining points: '),
                              Text(
                                  '${talentProvider.getRemainingTalentPoints()}',
                                  style: TextStyle(
                                    color: kColorSelectiveYellow,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      if (talentProvider.expansion != 'cata')
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                Text('Level: '),
                                Text('$level',
                                    style:
                                        TextStyle(color: kColorSelectiveYellow))
                              ],
                            ),
                          ),
                        )
                    ])),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/background/${talentTrees.specTreeList[0].background}.png"),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.black),
                    child: TalentTreeWidget(
                        key: talentTree1Key,
                        talentTreeName: talentTrees.specTreeList[0].name,
                        arrowList: arrowTrees[0]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/background/${talentTrees.specTreeList[1].background}.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: TalentTreeWidget(
                        key: talentTree2Key,
                        talentTreeName: talentTrees.specTreeList[1].name,
                        arrowList: arrowTrees[1]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/background/${talentTrees.specTreeList[2].background}.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: TalentTreeWidget(
                        key: talentTree3Key,
                        talentTreeName: talentTrees.specTreeList[2].name,
                        arrowList: arrowTrees[2]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<MenuItemPopUp> buildItem(MenuItemPopUp item) =>
      PopupMenuItem<MenuItemPopUp>(
          value: item,
          child: Row(children: [
            Icon(
              item.icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              item.text,
              style: TextStyle(color: Colors.white),
            ),
          ]));

  void shareBuild() {
    String talentPointsInLink = '';
    String expansionInLink = '';
    String link = '';

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

    if (talentProvider.expansion == 'tbc') {
      expansionInLink =
          'tbc.wowhead.com/talent-calc/${talentProvider.className}/';
    } else if (talentProvider.expansion == 'wotlk') {
      expansionInLink =
          'wowhead.com/wotlk/talent-calc/${talentProvider.className == 'deathknight' ? 'death-knight' : talentProvider.className}/';
    } else if (talentProvider.expansion == 'vanilla') {
      expansionInLink =
          'classic.wowhead.com/talent-calc/${talentProvider.className}/';
    }

    link = 'https://' + expansionInLink + talentPointsInLink;
    Clipboard.setData(ClipboardData(text: link)).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Build link copied to clipboard. Paste it into your browser to see your build. (It opens up wowhead where you can see the exact same build) ")));
    });
  }

  Future<void> onSelected(BuildContext context, MenuItemPopUp item) async {
    final adState = Provider.of<AdState>(context, listen: false);

    switch (item) {
      case MenuItems.itemResetTree:
        talentProvider.resetTalentTree(_selectedIndex);
        if (adState.interstitialAd == null) {
          adState.loadInterstitialAd();
        }
        interstitialAdCounter++;
        if (interstitialAdCounter == 6) {
          adState.showInterstitialAd();
          interstitialAdCounter = 0;
        }
        break;

      case MenuItems.itemSetGlyphs:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            ClassGlyphs classGlyphs =
                talentProvider.classGlyphs.firstWhere((classGlyphs) {
              String className = talentProvider.className;
              if (className == 'deathknight') className = 'death knight';
              return classGlyphs.name!.toLowerCase() == className;
            });
            return ChangeNotifierProvider<TalentProvider>.value(
                value: talentProvider,
                child: GlyphsScreen(
                  classGlyphs: classGlyphs,
                ));
          }),
        );
        break;

      case MenuItems.itemShareBuild:
        shareBuild();
        if (adState.interstitialAd == null) {
          adState.loadInterstitialAd();
        }
        interstitialAdCounter++;
        if (interstitialAdCounter == 6) {
          adState.showInterstitialAd();
          interstitialAdCounter = 0;
        }
        break;
    }
  }
}
