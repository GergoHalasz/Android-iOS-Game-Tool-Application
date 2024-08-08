import 'package:wowtalentcalculator/ArrowWidgets/right_arrow_widget.dart';
import 'package:wowtalentcalculator/ArrowWidgets/right_corner_arrow_widget.dart';
import 'package:wowtalentcalculator/model/position.dart';

import 'arrow_widget.dart';

getWarriorArrowList(String expansion) {
  var arrowListVanilla = [
    [
      ArrowWidget(
        startPosition: Position(row: 0, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Deep Wounds',
      ),
      ArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 2, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Anger Management',
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Impale',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Mortal Strike',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Flurry',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Bloodthirst',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 0, column: 1),
        endPosition: Position(row: 2, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Improved Shield Block',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Shield Slam',
      )
    ]
  ];
  var arrowListTbc = [
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Impale',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Mortal Strike',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Improved Mortal Strike',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Flurry',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Bloodthirst',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Rampage',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 2, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Improved Shield Block',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Shield Slam',
      )
    ]
  ];

  var arrowListWotlk = [
    [
      RightArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 2, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Deep Wounds',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Mortal Strike',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Improved Mortal Strike',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Bloodthirst',
      ),
      RightCornerArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Bloodsurge',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Rampage',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Vigilance',
      ),
      ArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 9, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Sword and Board',
      )
    ]
  ];

  var arrowListCata = [
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Impale',
      ),
      RightCornerArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Throwdown',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Bladestorm',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Raging Blow',
      ),
      RightArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Rampage',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Bloodsurge',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 4, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Vigilance',
      ),
      RightArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 3, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Impending Victory',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Sword and Board',
      ),
    ]
  ];

  arrowWidgetsClass() {
    if (expansion == "tbc")
      return arrowListTbc;
    else if (expansion == "vanilla")
      return arrowListVanilla;
    else if (expansion == "cata") return arrowListCata;
    return arrowListWotlk;
  }

  return arrowWidgetsClass();
}
