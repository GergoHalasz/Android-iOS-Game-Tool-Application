import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:wowtalentcalculator/utils/string.dart';

class TalentDialog extends StatefulWidget {
  final Talent talent;
  final String talentTreeName;

  TalentDialog({required this.talent, required this.talentTreeName});

  @override
  _TalentDialogState createState() => _TalentDialogState();
}

class _TalentDialogState extends State<TalentDialog> {
  var talentProvider;
  final key = GlobalKey();
  int maxRank = 0;
  int currentRank = 0;
  String spellName = '';
  String imgLocation = '';
  bool isTooltipOpen = false;

  @override
  void didChangeDependencies() {
    talentProvider = Provider.of<TalentProvider>(context);

    super.didChangeDependencies();
  }

  void _increaseRank() {
    talentProvider.increaseTalentPoints(
        widget.talent, currentRank, maxRank, widget.talentTreeName);
  }

  void _decreaseRank() {
    if (_checkSpellCanDecrease()) {
      talentProvider.decreaseTalentPoints(
          widget.talent, currentRank, widget.talentTreeName);
    }
    // else show toast to let user know cannot decrease
  }

  bool _checkSpellCanDecrease() {
    // rules if can decrease:
    // 1. currentRank > 0
    // 2. has no talent dependency
    // 3. retain enough points for higher tier spell

    // 1. if currentRank is 0, then cannot decrease
    if (currentRank <= 0) {
      return false;
    }
    // 2. if this talent has support spell, check if that support one is selected
    // if yes, cannot decrease
    for (final supportSpell in widget.talent.support) {
      Talent dependencyTalent = talentProvider.findTalentByName(supportSpell);
      if (dependencyTalent.points > 0) {
        return false;
      }
    }

    // for decrease middle tree spell, we need to:
    // check widget talent spell tier,
    // then check total points in that tier
    // if have enough points, let decrease
    int currentTier = widget.talent.tier;
    Talent highestTalent =
        talentProvider.findHighestTierSpell(widget.talentTreeName);
    int highestTier = highestTalent.tier;

    // if the decrease spell is not the highest tier
    if (currentTier < highestTier) {
      // then check for current tier, if enough points in the current tier to decrease
      int requiredCurrentTierPoints = currentTier * 5;
      int currentTierPoints =
          talentProvider.findTierSum(currentTier, widget.talentTreeName);
      if (requiredCurrentTierPoints >= currentTierPoints) {
        return false;
      }
      // check for highest required points
      int requiredNextTopTierPoints = (highestTier - 1) * 5;
      int nextTopTierPoints =
          talentProvider.findTierSum(highestTier - 1, widget.talentTreeName);
      if (requiredNextTopTierPoints >= nextTopTierPoints) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    talentProvider = Provider.of<TalentProvider>(context);
    maxRank = widget.talent.ranks.rankList.length;
    currentRank = widget.talent.points;
    spellName = widget.talent.icon.toLowerCase();
    imgLocation = 'assets/Icons/$spellName.png';

    return AlertDialog(
      
      backgroundColor: Color(0xff556F7A),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '${widget.talent.name}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: -0.5),
                  )),
              Text('Rank $currentRank/$maxRank',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  )),
              SizedBox(
                height: 4,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '${widget.talent.ranks.rankList[currentRank == 0 ? 0 : currentRank - 1].description}',
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: -0.5),
                  )),
              if (widget.talent.enable && maxRank != 1)
                Opacity(
                  opacity: currentRank != 0 && currentRank < maxRank ? 1 : 0,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Next rank:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  letterSpacing: -0.5))),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '${widget.talent.ranks.rankList[currentRank < maxRank ? currentRank : currentRank - 1].description}',
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: -0.5),
                          )),
                    ],
                  ),
                ),
              if (widget.talent.enable)
              SizedBox(
                height: 20,
              ),
            ],
          ),
          if (widget.talent.enable)
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _decreaseRank(),
                    child: Container(
                        height: 45,
                        width: 45,
                        child: Image.asset('assets/Icons/remove.png')),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: GestureDetector(
                      onTap: () => _increaseRank(),
                      child: Container(
                          height: 45,
                          width: 45,
                          child: Image.asset('assets/Icons/add.png')),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
