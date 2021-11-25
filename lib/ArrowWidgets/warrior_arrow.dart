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
        dependencyTalent: 'Anger Managementy',
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
  return expansion == "tbc" ? arrowListTbc : arrowListVanilla;
}
