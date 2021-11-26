import 'package:wowtalentcalculator/ArrowWidgets/left_arrow_widget.dart';
import 'package:wowtalentcalculator/ArrowWidgets/right_arrow_widget.dart';
import 'package:wowtalentcalculator/model/position.dart';

import 'arrow_widget.dart';

getPaladinArrowList(String expansion) {
  var arrowListVanilla = [
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 4, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Divine Favor',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Holy Shock',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 0, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Shield Specialization',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Holy Shield',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'long',
        dependencyTalent: 'Repentance',
      )
    ]
  ];
  var arrowListTbc = [
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 4, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Divine Favor',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Holy Shock',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 0, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Shield Specialization',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Holy Shield',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: "Avenger's Shield",
      ),
      LeftArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'short',
        dependencyTalent: "Improved Holy Shield",
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'long',
        dependencyTalent: 'Vengeance',
      ),
      RightArrowWidget(
        startPosition: Position(row: 4, column: 2),
        endPosition: Position(row: 4, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Improved Sanctity Aura',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Fanaticism',
      ),
    ]
  ];
  return expansion == "tbc" ? arrowListTbc : arrowListVanilla;
}
