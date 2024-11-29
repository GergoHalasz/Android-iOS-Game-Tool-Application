import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector_nullsafety/swipedetector_nullsafety.dart';
import 'package:wowtalentcalculator/DetailsScreen/talent_dialog.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

// import 'package:transparent_image/transparent_image.dart';

//add ripple effect
//https://medium.com/@RayLiVerified/create-a-rounded-image-icon-with-ripple-effect-in-flutter-eb0f4a720b90

// Main widget for spell icons
class SpellWidget extends StatefulWidget {
  final Talent talent;
  final String talentTreeName;

  SpellWidget({required this.talent, required this.talentTreeName});

  @override
  _SpellWidgetState createState() => _SpellWidgetState();
}

class _SpellWidgetState extends State<SpellWidget> {
  final key = GlobalKey();
  var talentProvider;
  int maxRank = 0;
  int currentRank = 0;
  String spellName = '';
  String imgLocation = '';
  final tooltipController = JustTheController();
  bool isTooltipOpen = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  // show spell tooltip description on long press
  void _showDescription() {
    tooltipController.showTooltip();
  }

  String _getDescription() {
    int displayRank = currentRank - 1;
    if (displayRank < 0) {
      displayRank = 0;
      return '${widget.talent.name} : ${widget.talent.ranks.rankList[displayRank].description}';
    }
    return '${widget.talent.name}(Rank ${widget.talent.ranks.rankList[displayRank].number}) : ' +
        widget.talent.ranks.rankList[displayRank].description;
  }

  // onTap, increase spell rank if it's not max and not over 60

  void _increaseRank() {
    talentProvider.increaseTalentPoints(
        widget.talent, currentRank, maxRank, widget.talentTreeName);
  }

  void _increaseMaxRank() {
    talentProvider.increaseMaxTalentPoints(
        widget.talent, currentRank, maxRank, widget.talentTreeName);
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

  void _decreaseRank() {
    if (_checkSpellCanDecrease()) {
      talentProvider.decreaseTalentPoints(
          widget.talent, currentRank, widget.talentTreeName);
    }
    // else show toast to let user know cannot decrease
  }

  // check if spell talent is enable or not
  // disable Tap action if grey out
  _buildSpellWidget() {
    if (widget.talent.enable &&
        (!talentProvider.checkIfBuildIsMaxed() || widget.talent.points > 0)) {
      return Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
              border: Border.all(
                color: widget.talent.points == maxRank
                    ? Colors.yellow
                    : Colors.greenAccent.shade400,
                width: 2,
              ),
              image: DecorationImage(
                  image: AssetImage(imgLocation), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade700,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                _showDescription();
              },
              onLongPress: () => _increaseMaxRank(),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    } else {
      return Material(
        color: Colors.transparent,
        child: Container(
          foregroundDecoration: BoxDecoration(
            color: Colors.grey,
            backgroundBlendMode: BlendMode.saturation,
            borderRadius:
                BorderRadius.circular(14), // icon curve border magic number
          ),
          child: Ink(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgLocation), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade700,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () {
                  _showDescription();
                },
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      );
    }
  }

  _buildTalentWidget() {
    if (widget.talent.enable) {
      return SwipeDetector(
        onSwipeDown: () {
          if (widget.talent.enable) {
            _decreaseRank();
          }
        },
        onSwipeUp: () {
          if (widget.talent.enable) {
            _increaseRank();
          }
        },
        swipeConfiguration: SwipeConfiguration(
            verticalSwipeMinVelocity: 100.0,
            verticalSwipeMinDisplacement: 0.0,
            verticalSwipeMaxWidthThreshold: 100.0,
            horizontalSwipeMaxHeightThreshold: 50.0,
            horizontalSwipeMinDisplacement: 50.0,
            horizontalSwipeMinVelocity: 200.0),
        child: Container(
          padding: EdgeInsets.all(9),
          decoration: BoxDecoration(color: Colors.transparent),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: _buildSpellWidget(), //spell icon
              ),
              if (talentProvider.getRemainingTalentPoints() != 0 ||
                  widget.talent.points != 0)
                Align(
                  // spell rank
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$currentRank',
                      style: TextStyle(
                          fontSize: 16,
                          color: widget.talent.points == maxRank
                              ? Colors.yellow
                              : Colors.greenAccent.shade400),
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(color: Colors.transparent),
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: _buildSpellWidget(), //spell icon
          ),
          if (talentProvider.getRemainingTalentPoints() != 0 ||
              widget.talent.points != 0)
            Align(
              // spell rank
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '$currentRank',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    talentProvider = Provider.of<TalentProvider>(context);
    maxRank = widget.talent.ranks.rankList.length;
    currentRank = widget.talent.points;
    spellName = widget.talent.icon.toLowerCase();
    imgLocation = 'assets/Icons/$spellName.png';

    return JustTheTooltip(
      controller: tooltipController,
      fadeInDuration: Duration(milliseconds: 0),
      fadeOutDuration: Duration(milliseconds: 0),
      tailLength: 0,
      key: key,
      backgroundColor: Color.fromARGB(255, 83, 83, 83),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTextStyle(
          style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Rank $currentRank/$maxRank',
                      style: TextStyle(color: Colors.white, fontSize: 14))),
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
              if (currentRank != 0 && currentRank < maxRank)
                SizedBox(
                  height: 8,
                ),
              if (currentRank != 0 && currentRank < maxRank)
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('Next rank:',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            letterSpacing: -0.5))),
              if (currentRank != 0 && currentRank < maxRank)
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
              if (widget.talent.enable)
                SizedBox(
                  height: 4,
                ),
              if (widget.talent.enable)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      Text(
                        'Swipe up to learn',
                        style: TextStyle(
                            color:
                                currentRank < maxRank ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            letterSpacing: -0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          'Long tap to max rank',
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              letterSpacing: -0.5),
                        ),
                      )
                    ],
                  ),
                ),
              if (widget.talent.enable)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Swipe down to unlearn',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: -0.5),
                  ),
                )
            ],
          ),
        ),
      ),
      child: Container(
          width: SizeConfig.cellSize,
          height: SizeConfig.cellSize,
          child: _buildTalentWidget()),
    );
  }
}
