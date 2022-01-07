import 'package:wowtalentcalculator/ArrowWidgets/left_corner_arrow_widget.dart';
import 'package:wowtalentcalculator/ArrowWidgets/right_arrow_widget.dart';
import 'package:wowtalentcalculator/model/position.dart';

import 'arrow_widget.dart';

getWarlockArrowList(String expansion) {
  var arrowListVanilla = [
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Curse of Exhaustion',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Shadow Mastery',
      ),
      RightArrowWidget(
        startPosition: Position(row: 4, column: 2),
        endPosition: Position(row: 4, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Improved Curse of Exhaustion',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Master Summoner',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Master Demonologist',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Soul Link',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 0),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Pyroclasm',
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Ruin',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Conflagrate',
      ),
    ]
  ];

  var arrowListTbc = [
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Curse of Exhaustion',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Shadow Mastery',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Unstable Affliction',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Master Summoner',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Master Demonologist',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Soul Link',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 0),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Pyroclasm',
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Ruin',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Conflagrate',
      ),
      ArrowWidget(
        startPosition: Position(row: 7, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Shadowfury',
      ),
    ]
  ];

  var arrowListWotlk = [
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Curse of Exhaustion',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Shadow Mastery',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Unstable Affliction',
      ),
      RightArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 8, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Pandemic',
      ),
    ],[
      ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Unholy Power',
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Master Summoner',
      ),
      LeftCornerArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Mana Feed',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Master Demonologist',
      ),
      ArrowWidget(
        startPosition: Position(row: 5, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Demonic Empowerment',
      ),
      LeftCornerArrowWidget(
        startPosition: Position(row: 7, column: 1),
        endPosition: Position(row: 8, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Improved Demonic Tactics',
      ),
    ],[
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Devastation',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 0),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Backlash',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Conflagrate',
      ),
      LeftCornerArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 0),
        lengthType: 'medium',
        dependencyTalent: 'Backdraft',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 2),
        endPosition: Position(row: 7, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Improved Soul Leech',
      ),
    ]
  ];

  arrowWidgetsClass() {
    if (expansion == "tbc")
      return arrowListTbc;
    else if (expansion == "vanilla")
      return arrowListVanilla;
    else
      return arrowListWotlk;
  }

  return arrowWidgetsClass();
}
