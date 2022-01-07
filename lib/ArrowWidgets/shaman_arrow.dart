import 'package:wowtalentcalculator/ArrowWidgets/left_arrow_widget.dart';
import 'package:wowtalentcalculator/ArrowWidgets/right_arrow_widget.dart';
import 'package:wowtalentcalculator/model/position.dart';

import 'arrow_widget.dart';

getShamanArrowList(String expansion) {
  var arrowListVanilla = [
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'long',
        dependencyTalent: 'Lightning Mastery',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Elemental Mastery',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Flurry',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Stormstrike',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'long',
        dependencyTalent: 'Mana Tide Totem',
      )
    ]
  ];
  var arrowListTbc = [
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'long',
        dependencyTalent: 'Lightning Mastery',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Elemental Mastery',
      ),
      ArrowWidget(
        startPosition: Position(row: 7, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Totem of Wrath',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Flurry',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Dual Wield',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 2),
        endPosition: Position(row: 6, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Stormstrike',
      ),
      LeftArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 6, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Dual Wield Specialization',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'long',
        dependencyTalent: 'Mana Tide Totem',
      ),
      ArrowWidget(
        startPosition: Position(row: 7, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Earth Shield',
      )
    ]
  ];
  var arrowListWotlk = [ [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'long',
        dependencyTalent: 'Lightning Mastery',
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 4, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Call of Thunder',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Elemental Mastery',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Elemental Oath',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Flurry',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Dual Wield',
      ),
      LeftArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 6, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Dual Wield Specialization',
      ),
       ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Lava Lash',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 2),
        endPosition: Position(row: 7, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Improved Stormstrike',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'long',
        dependencyTalent: 'Mana Tide Totem',
      ),
      ArrowWidget(
        startPosition: Position(row: 5, column: 2),
        endPosition: Position(row: 6, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Cleanse Spirit',
      ),
      
      RightArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 8, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Improved Earth Shield',
      )
    ]];

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
