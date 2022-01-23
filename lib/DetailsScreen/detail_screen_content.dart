import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/ArrowWidgets/class_arrow_widget.dart';
import 'package:wowtalentcalculator/DetailsScreen/Save_screen.dart';
import 'package:wowtalentcalculator/DetailsScreen/drawer_screen.dart';
import 'package:wowtalentcalculator/DetailsScreen/newBuild_dialog.dart';
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

// detail screen content below the tabs bar
class DetailScreenContent extends StatefulWidget {
  final String className;
  final Color classColor;
  final List arrowTrees;

  final TalentTrees talentTrees;
  DetailScreenContent(
      {required this.className,
      required this.talentTrees,
      required this.classColor,
      required this.arrowTrees});

  @override
  _DetailScreenContentState createState() => _DetailScreenContentState();
}

class _DetailScreenContentState extends State<DetailScreenContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TalentProvider talentProvider;
  int _selectedIndex = 0;
  BannerAd? banner;
  String buildName = "";
  String key = "";
  bool firstTimeAdInit = true;
  late TalentTrees talentTrees;
  late String className;
  late Color classColor;
  late List arrowTrees;
  Key talentTree1Key = UniqueKey();
  Key talentTree2Key = UniqueKey();
  Key talentTree3Key = UniqueKey();

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
    }
  }

  @override
  initState() {
    super.initState();
    talentTrees = widget.talentTrees;
    className = widget.className;
    classColor = widget.classColor;
    arrowTrees = widget.arrowTrees;

    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void saveTalent() {
    print("save talent");

    String json = jsonEncode(talentTrees);
    print(json);
  }

  void loadTalent() {
    print("load talent");
  }

  void showHelp() {
    print("show help");
    _showDialog();
  }

  void _showDialog() {
    // flutter defined function
  }

  void handlePopupMenuSelect(String value) {
    if (value == 'Load') {
      loadTalent();
    } else if (value == 'Save') {
      saveTalent();
    } else if (value == 'Help') {
      showHelp();
    }
  }

  TabBar _tabBar() => TabBar(
        controller: _tabController,
        indicatorColor: classColor,
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

          setState(() {
            key = "";
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

    setState(() {
      this.key = key;
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
    int classNumbers = -1;
    int classRow = 0;
    String? expansion;

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
      drawer: Drawer(
          child: DrawerScreen(
        fetchSavedBuild: fetchSavedBuild,
        changeClass: changeClass,
      )),
      appBar: AppBar(
          centerTitle: true,
          title: Text(
              talentProvider.buildName == null
                  ? '${talentTrees.specTreeList[_selectedIndex].name} ${str.capitalize(className)}'
                  : talentProvider.buildName!,
              style: TextStyle(color: kColorSelectiveYellow)),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 15),
                child: InkResponse(
                  child: Icon(Icons.refresh),
                  onTap: () {
                    talentProvider.resetTalentTree(_selectedIndex);
                  },
                )),
            Container(
              padding: EdgeInsets.only(right: 15),
              child: InkResponse(
                child: Icon(
                  Icons.save,
                ),
                onTap: () {
                  Navigator.of(context).push(CustomPageRoute(
                      child: ChangeNotifierProvider<TalentProvider>.value(
                          value: talentProvider,
                          child: SaveScreen(
                            changeBuildKeyAndName: (key, buildName) {
                              setState(() {
                                this.key = key;
                                this.buildName = buildName;
                              });
                            },
                            changeBuildName: (buildName) {
                              setState(() {
                                this.buildName = buildName;
                              });
                            },
                            buildName: buildName,
                            buildKey: key,
                          ))));
                },
              ),
            ),
          ],
          backgroundColor: Color(0xff2E6171),
          bottom: PreferredSize(
              preferredSize: _tabBar().preferredSize,
              child: ColoredBox(color: Color(0xff556F7A), child: _tabBar()))),
      body: DefaultTextStyle(
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w900),
        child: Container(
          decoration: BoxDecoration(color: Color(0xff2E6171)),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Container(
                    height: SizeConfig.blockSizeVertical * 4.5,
                    color: Color(0xff556F7A),
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
                                      style: TextStyle(
                                          color: kColorSelectiveYellow)),
                                  Text(')'),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.only(right: 15),
                              child: Row(
                                children: [
                                  Text('Level: '),
                                  Text('$level',
                                      style: TextStyle(
                                          color: kColorSelectiveYellow))
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
                if (!adState.isAdFreeVersion)
                  if (banner == null)
                    Container(
                      height: 50,
                      color: Colors.black,
                    )
                  else
                    Container(
                      height: 50,
                      child: AdWidget(ad: banner!),
                      color: Colors.black,
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
