import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:wowtalentcalculator/utils/string.dart' as str;
import 'package:wowtalentcalculator/DetailsScreen/talent_tree_widget.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/constants.dart';

import '../ad_state.dart';

// detail screen content below the tabs bar
class DetailScreenContent extends StatefulWidget {
  final String className;
  final Color classColor;
  
  final TalentTrees talentTrees;
  DetailScreenContent(
      {required this.className,
      required this.talentTrees,
      required this.classColor});

  @override
  _DetailScreenContentState createState() => _DetailScreenContentState();
}

class _DetailScreenContentState extends State<DetailScreenContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  BannerAd? banner;
  bool firstTimeAdInit = true;

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
      print('didchangedep');
    }
  }

  @override
  initState() {
    print('initstate');
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void saveTalent() {
    print("save talent");

    String json = jsonEncode(widget.talentTrees);
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
        indicatorColor: widget.classColor,
        tabs: [
          Tab(
              icon: Image.asset(
            "assets/Icons/${widget.talentTrees.specTreeList[0].icon}.png",
            width: kTabIconSize,
          )),
          Tab(
              icon: Image.asset(
            "assets/Icons/${widget.talentTrees.specTreeList[1].icon}.png",
            width: kTabIconSize,
          )),
          Tab(
              icon: Image.asset(
            "assets/Icons/${widget.talentTrees.specTreeList[2].icon}.png",
            width: kTabIconSize,
          )),
        ],
      );

  @override
  Widget build(BuildContext context) {
    // get the current level to display at the top corner
    // display level 10 for starting
    int level = Provider.of<TalentProvider>(context).getTotalTalentPoints();
    if (level == 9) {
      level = 10;
    }
    return Scaffold(
      appBar: AppBar(
          title: Text(
            str.capitalize(widget.className),
            style: TextStyle(color: kColorSelectiveYellow),
          ),
          actions: <Widget>[
            // level label
            Center(
              child: Container(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  'Level $level',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: kColorSelectiveYellow),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: 15),
                child: InkResponse(
                  child: Icon(
                    Icons.save,
                  ),
                  onTap: () {},
                ))
          ],
          backgroundColor: Colors.black87,
          bottom: PreferredSize(
              preferredSize: _tabBar().preferredSize,
              child:
                  ColoredBox(color: Colors.grey.shade800, child: _tabBar()))),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/background/${widget.talentTrees.specTreeList[0].background}.png"),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black),
                  child: TalentTreeWidget(
                    talentTreeName: widget.talentTrees.specTreeList[0].name,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/background/${widget.talentTrees.specTreeList[1].background}.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TalentTreeWidget(
                    talentTreeName: widget.talentTrees.specTreeList[1].name,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/background/${widget.talentTrees.specTreeList[2].background}.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TalentTreeWidget(
                    talentTreeName: widget.talentTrees.specTreeList[2].name,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 4.5,
            color: Colors.grey.shade800,
          ),
          if (banner == null)
            Container(
              height: 50,
            )
          else
            Container(
              height: 50,
              child: AdWidget(ad: banner!),
              color: Colors.black,
            )
        ],
      ),
    );
  }
}
