import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wow_talent_calculator/utils/string.dart' as str;
import 'package:wow_talent_calculator/DetailsScreen/talent_tree_widget.dart';
import 'package:wow_talent_calculator/model/talent.dart';
import 'package:wow_talent_calculator/provider/talent_provider.dart';
import 'package:wow_talent_calculator/utils/colors.dart';
import 'package:wow_talent_calculator/utils/constants.dart';

// detail screen content below the tabs bar
class DetailScreenContent extends StatefulWidget {
  final String className;
  final Color classColor;
  TalentTrees talentTrees;
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

  @override
  initState() {
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
        iconTheme: IconThemeData(color: kColorSelectiveYellow),
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
          // overflow menu
          PopupMenuButton<String>(
            // color: kColorSelectiveYellow,
            onSelected: (value) {
              handlePopupMenuSelect(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Help",
                child: Text("Help"),
              ),
            ],
          ),
        ],
        backgroundColor: kColorLightLicorice,
        bottom: TabBar(
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
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/background/${widget.talentTrees.specTreeList[0].background}.png"),
                fit: BoxFit.cover,
              ),
            ),
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
    );
  }
}
