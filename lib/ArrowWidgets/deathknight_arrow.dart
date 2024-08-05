import 'package:wowtalentcalculator/ArrowWidgets/left_arrow_widget.dart';
import 'package:wowtalentcalculator/model/position.dart';

import 'arrow_widget.dart';

getDeathKnightArrowList(String expansion) {
  var arrowListWotlk = [
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 0),
        endPosition: Position(row: 3, column: 0),
        lengthType: 'short',
        dependencyTalent: "Improved Rune Tap",
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'long',
        dependencyTalent: "Bloody Vengeance",
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 0, column: 0),
        endPosition: Position(row: 2, column: 0),
        lengthType: 'medium',
        dependencyTalent: "Icy Talons",
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 0),
        endPosition: Position(row: 5, column: 0),
        lengthType: 'long',
        dependencyTalent: "Improved Icy Talons",
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 3),
        endPosition: Position(row: 5, column: 3),
        lengthType: 'medium',
        dependencyTalent: "Master of Ghouls",
      ),
      ArrowWidget(
        startPosition: Position(row: 5, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'short',
        dependencyTalent: "Anti-Magic Zone",
      ),
      ArrowWidget(
        startPosition: Position(row: 5, column: 3),
        endPosition: Position(row: 6, column: 3),
        lengthType: 'short',
        dependencyTalent: "Ghoul Frenzy",
      ),
      ArrowWidget(
        startPosition: Position(row: 7, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'short',
        dependencyTalent: "Ebon Plaguebringer",
      ),
    ]
  ];

  var arrowListCata = [
    [
      LeftArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'short',
        dependencyTalent: "Will of the Necropolis",
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: "Howling Blast",
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 0, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'medium',
        dependencyTalent: "Contagion",
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 4, column: 1),
        lengthType: 'short',
        dependencyTalent: "Anti-Magic Zone",
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 3),
        endPosition: Position(row: 4, column: 3),
        lengthType: 'medium',
        dependencyTalent: "Dark Transformation",
      ),
    ]
  ];

  if (expansion == 'cata') return arrowListCata;
  return arrowListWotlk;
}
