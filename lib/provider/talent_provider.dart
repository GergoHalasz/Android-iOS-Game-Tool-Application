import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wowtalentcalculator/model/talent.dart';

class TalentProvider extends ChangeNotifier {
  int _firstTalentTreePoints;
  int _secondTalentTreePoints;
  int _thirdTalentTreePoints;
  TalentTrees talentTrees;
  String className;
  String expansion;
  String? buildName = null;

  

  TalentProvider(this.talentTrees, this.className, this.expansion)
      : _firstTalentTreePoints = talentTrees.specTreeList[0].points,
        _secondTalentTreePoints = talentTrees.specTreeList[1].points,
        _thirdTalentTreePoints = talentTrees.specTreeList[2].points;

  /// return total points of talent selected
  getTotalTalentPoints() =>
      9 + // first level to get talent is 10
      _firstTalentTreePoints +
      _secondTalentTreePoints +
      _thirdTalentTreePoints;

  changeExpansion(expansion) {
    this.expansion = expansion;
    notifyListeners();
  }

  changeBuildName(name) {
    this.buildName = name;
    notifyListeners();
  }

  changeClass(talentTreesObj, newClassName) {
    talentTrees = talentTreesObj;
    _firstTalentTreePoints = talentTreesObj.specTreeList[0].points;
    _secondTalentTreePoints = talentTreesObj.specTreeList[1].points;
    _thirdTalentTreePoints = talentTreesObj.specTreeList[2].points;
    className = newClassName;

    notifyListeners();
  }

  getTotalTalentPointsWithoutLevel() =>
      _firstTalentTreePoints + _secondTalentTreePoints + _thirdTalentTreePoints;

  /// return the total points of selected tree
  getTalentTreePoints(String talentTreeName) {
    if (talentTreeName == talentTrees.specTreeList[0].name) {
      return _firstTalentTreePoints;
    } else if (talentTreeName == talentTrees.specTreeList[1].name) {
      return _secondTalentTreePoints;
    }
    if (talentTreeName == talentTrees.specTreeList[2].name) {
      return _thirdTalentTreePoints;
    }
  }

  /// increase the total talent points of selected tree
  void increaseTreePoints(String talentTreeName) {
    if (talentTreeName == talentTrees.specTreeList[0].name) {
      _firstTalentTreePoints++;
    } else if (talentTreeName == talentTrees.specTreeList[1].name) {
      _secondTalentTreePoints++;
    } else if (talentTreeName == talentTrees.specTreeList[2].name) {
      _thirdTalentTreePoints++;
    }

    notifyListeners();
  }

  void increaseTreePointsWithSomePoints(String talentTreeName, int points) {
    if (talentTreeName == talentTrees.specTreeList[0].name) {
      _firstTalentTreePoints = _firstTalentTreePoints + points;
    } else if (talentTreeName == talentTrees.specTreeList[1].name) {
      _secondTalentTreePoints = _secondTalentTreePoints + points;
    } else if (talentTreeName == talentTrees.specTreeList[2].name) {
      _thirdTalentTreePoints = _thirdTalentTreePoints + points;
    }

    notifyListeners();
  }

  /// decrease the total talent points of selected tree
  void decreaseTreePoints(String talentTree) {
    if (talentTree == talentTrees.specTreeList[0].name) {
      _firstTalentTreePoints--;
    } else if (talentTree == talentTrees.specTreeList[1].name) {
      _secondTalentTreePoints--;
    } else if (talentTree == talentTrees.specTreeList[2].name) {
      _thirdTalentTreePoints--;
    }
    notifyListeners();
  }

  /// increase the talent points of selected spell
  /// increase spell rank if it's not max and not over 60
  /// loop 5 times to max out
  void increaseTalentPoints(
      Talent talent, int currentRank, int maxRank, String talentTreeName) {
    if (expansion == 'wotlk') {
      if (talent.points < maxRank && getTotalTalentPointsWithoutLevel() < 71) {
        talent.points = talent.points + 1;
        increaseTreePoints(talentTreeName);
        updateTalentTree();
        notifyListeners();
      }
    } else {
      if (talent.points < maxRank &&
          getTotalTalentPointsWithoutLevel() < (expansion == 'tbc' ? 61 : 51)) {
        talent.points = talent.points + 1;
        increaseTreePoints(talentTreeName);
        updateTalentTree();
        notifyListeners();
      }
    }
  }

  void increaseMaxTalentPoints(
      Talent talent, int currentRank, int maxRank, String talentTreeName) {
    if (expansion == 'wotlk') {
      if (talent.points < maxRank &&
          getTotalTalentPointsWithoutLevel() + (maxRank - currentRank) <= 71) {
        talent.points = maxRank;
        increaseTreePointsWithSomePoints(
            talentTreeName, (maxRank - currentRank));
        updateTalentTree();
        notifyListeners();
      }
    } else {
      if (talent.points < maxRank &&
          getTotalTalentPointsWithoutLevel() + (maxRank - currentRank) <=
              (expansion == 'tbc' ? 61 : 51)) {
        talent.points = maxRank;
        increaseTreePointsWithSomePoints(
            talentTreeName, (maxRank - currentRank));
        updateTalentTree();
        notifyListeners();
      }
    }
  }

  /// decrease the talent points of selected spell
  void decreaseTalentPoints(
      Talent talent, int currentRank, String talentTreeName) {
    talent.points = currentRank - 1;
    decreaseTreePoints(talentTreeName);
    updateTalentTree();
    notifyListeners();
  }

  void resetTalentTree(int idx) {
    List<TalentTree> specTrees = talentTrees.specTreeList;
    specTrees[idx].points = 0;
    if (idx == 0) {
      _firstTalentTreePoints = 0;
    } else if (idx == 1) {
      _secondTalentTreePoints = 0;
    } else if (idx == 2) {
      _thirdTalentTreePoints = 0;
    }
    List<Talent> talents = specTrees[idx].talents.talentList;
    for (int j = 0; j < talents.length; j++) {
      talents[j].points = 0;
    }
    updateTalentTree();
    notifyListeners();
  }

  /// run update for the entire talent trees for enable or disable spell
  void updateTalentTree() {
    List<TalentTree> specTrees = talentTrees.specTreeList;
    for (int i = 0; i < specTrees.length; i++) {
      String specTreeName = specTrees[i].name;
      if (i == 0) {
        specTrees[i].points = _firstTalentTreePoints;
      } else if (i == 1) {
        specTrees[i].points = _secondTalentTreePoints;
      } else if (i == 2) {
        specTrees[i].points = _thirdTalentTreePoints;
      }
      List<Talent> talents = specTrees[i].talents.talentList;
      for (int j = 0; j < talents.length; j++) {
        updateTalentEnable(talents[j], specTreeName);
      }
    }
  }

  /// enable or disable spell talent depend on conditions
  /// enable if:
  /// have enough talent points: current talent tree points  >= required tier (e.g tier 3 requires 10 points)
  /// if talent have dependency, check if dependency is selected
  void updateTalentEnable(Talent talent, String specTreeName) {
    final int currentPoints = getTalentTreePoints(specTreeName);
    final int tierPoints = talent.tier * 5 - 5;
    // first, check for enough points for tier
    if (currentPoints >= tierPoints) {
      //second, check for dependency
      if (talent.dependency != '') {
        Talent? dependencyTalent = findTalentByName(talent.dependency);
        //check for enough required points
        if (dependencyTalent?.points ==
            dependencyTalent?.ranks.rankList.length) {
          talent.enable = true;
        } else {
          talent.enable = false;
        }
      } else {
        talent.enable = true;
      }
    } else {
      talent.enable = false;
    }
  }

  /// return the talent tree by tree name
  List<Talent> findTalentTreeByName(String name) {
    List<TalentTree> specTrees = talentTrees.specTreeList;
    List<Talent> talentTree = [];
    for (int i = 0; i < specTrees.length; i++) {
      if (specTrees[i].name == name) {
        talentTree = specTrees[i].talents.talentList;
        return talentTree;
      }
    }
    return talentTree;
  }

  bool isThereTalentTreeByName(String name) {
    bool isThereTalentTree = false;
    talentTrees.specTreeList.forEach((element) {
      if (element.name == name) isThereTalentTree = true;
    });
    return isThereTalentTree;
  }

  /// return the talent spell by name
  Talent? findTalentByName(String name) {
    List<TalentTree> specTrees = talentTrees.specTreeList;
    for (int i = 0; i < specTrees.length; i++) {
      List<Talent> talents = specTrees[i].talents.talentList;
      for (int j = 0; j < talents.length; j++) {
        if (talents[j].name == name) {
          return talents[j];
        }
      }
    }
    return null;
  }

  /// find highest tier spell checked in current tree spec
  Talent? findHighestTierSpell(String specTreeName) {
    Talent? highestTierSpell;
    List<TalentTree> specTrees = talentTrees.specTreeList;
    for (int i = 0; i < specTrees.length; i++) {
      if (specTrees[i].name == specTreeName) {
        List<Talent> talents = specTrees[i].talents.talentList;
        for (int j = 0; j < talents.length; j++) {
          if (talents[j].points > 0) {
            if (highestTierSpell == null) {
              highestTierSpell = talents[j];
            } else if (talents[j].tier > highestTierSpell.tier) {
              highestTierSpell = talents[j];
            }
          }
        }
        break;
      }
    }
    return highestTierSpell;
  }

  /// find all points up to the current tier
  int findTierSum(int currentTier, String specTreeName) {
    int totalPoints = 0;
    List<TalentTree> specTrees = talentTrees.specTreeList;
    for (int i = 0; i < specTrees.length; i++) {
      if (specTrees[i].name == specTreeName) {
        List<Talent> talents = specTrees[i].talents.talentList;
        for (int j = 0; j < talents.length; j++) {
          if (talents[j].tier <= currentTier) {
            totalPoints += talents[j].points;
          }
        }
        break;
      }
    }
    return totalPoints;
  }

  // lock spell or not

}
