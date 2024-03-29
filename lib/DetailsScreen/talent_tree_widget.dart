import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/DetailsScreen/spell_widget.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/constants.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:provider/provider.dart';

// display talent tree for each specialization
class TalentTreeWidget extends StatefulWidget {
  final String talentTreeName;
  final List<Widget> arrowList;
  TalentTreeWidget(
      {Key? key, required this.talentTreeName, required this.arrowList})
      : super(key: key);
  @override
  State<TalentTreeWidget> createState() => _TalentTreeWidgetState();
}

class _TalentTreeWidgetState extends State<TalentTreeWidget> {
  late TalentProvider talentProvider;
  late List<Widget> arrowList;
  late int asd;

  @override
  initState() {
    super.initState();
    arrowList = widget.arrowList;
  }

  _buildTalentTree(talentProvider) {
    /// contain talent list for this tree/page
    List<Talent> talentList =
        talentProvider.findTalentTreeByName(widget.talentTreeName);
    List<Widget> talentTree = [];
    for (int i = 0; i < talentList.length; i++) {
      Widget spell = Positioned(
          top: talentList[i].position[0].toDouble() * SizeConfig.cellSize,
          left: talentList[i].position[1].toDouble() * SizeConfig.cellSize,
          child: SpellWidget(
            talent: talentList[i],
            talentTreeName: widget.talentTreeName,
          ));
      talentTree.add(spell);
    }
    return talentTree;
  }

  @override
  Widget build(BuildContext context) {
    talentProvider = Provider.of<TalentProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600 ? true : false;

    expansionCellSize() {
      if (talentProvider.expansion == 'tbc') {
        return 9;
      } else if (talentProvider.expansion == 'vanilla' ||
          talentProvider.expansion == 'cata') {
        return 7;
      } else {
        return 11;
      }
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                // minHeight: viewportConstraints.maxHeight,
                maxHeight: SizeConfig.cellSize * expansionCellSize() +
                    kTalentScreenTwoPadding, // cell size * number of row + padding
              ),
              child: !isMobile
                  ? Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 560,
                          child: Stack(children: <Widget>[
                            ..._buildTalentTree(talentProvider),
                            ...arrowList
                          ])))
                  : Container(
                      padding: EdgeInsets.symmetric(
                          vertical: kTalentScreenPadding,
                          horizontal: kTalentScreenPadding),
                      child: Stack(children: <Widget>[
                        ..._buildTalentTree(talentProvider),
                        ...arrowList
                      ]))));
    });
  }
}
