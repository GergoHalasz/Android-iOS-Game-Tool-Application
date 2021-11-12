import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/DetailsScreen/spell_widget.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/constants.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:provider/provider.dart';

// display talent tree for each specialization
class TalentTreeWidget extends StatelessWidget {
  final String talentTreeName;
  final List<Widget> arrowList;

  TalentTreeWidget({required this.talentTreeName, required this.arrowList});
  _buildTalentTree(talentProvider) {
    /// contain talent list for this tree/page
    List<Talent> talentList =
        talentProvider.findTalentTreeByName(talentTreeName);
    List<Widget> talentTree = [];
    for (int i = 0; i < talentList.length; i++) {
      Widget spell = Positioned(
          top: talentList[i].position[0].toDouble() * SizeConfig.cellSize,
          left: talentList[i].position[1].toDouble() * SizeConfig.cellSize,
          child: SpellWidget(
            talent: talentList[i],
            talentTreeName: talentTreeName,
          ));
      talentTree.add(spell);
    }
    return talentTree;
  }

  @override
  Widget build(BuildContext context) {
    final talentProvider = Provider.of<TalentProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600 ? true : false;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                // minHeight: viewportConstraints.maxHeight,
                maxHeight: SizeConfig.cellSize * 7 +
                    kTalentScreenTwoPadding, // cell size * number of row + padding
              ),
              child: !isMobile
                  ? Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 560,
                          child: Stack(children: <Widget>[
                            ..._buildTalentTree(talentProvider),
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
