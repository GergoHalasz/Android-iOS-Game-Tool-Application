import 'package:wowtalentcalculator/model/position.dart';

import 'arrow_widget.dart';

getHunterArrowList(String expansion) {
  var arrowListVanilla = [
    [
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Bestial Wrath',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Frenzy',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Mortal Shots',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Trueshot Aura',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Counterattack',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Wyvern Sting',
      )
    ]
  ];

  var arrowListTbc = [
    [
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Bestial Wrath',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Frenzy',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'The Beast Within',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Mortal Shots',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Trueshot Aura',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 2),
        endPosition: Position(row: 6, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Improved Barrage',
      ),
      ArrowWidget(
        startPosition: Position(row: 7, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Silencing Shot',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Counterattack',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Wyvern Sting',
      ),
      ArrowWidget(
        startPosition: Position(row: 5, column: 2),
        endPosition: Position(row: 6, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Expose Weakness',
      ),
      ArrowWidget(
        startPosition: Position(row: 7, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Readiness',
      )
    ]
  ];

  var arrowListWotlk = [[
    ArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'medium',
        dependencyTalent: "Frenzy",
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: "Bestial Wrath",
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 0),
        endPosition: Position(row: 7, column: 0),
        lengthType: 'short',
        dependencyTalent: "Invigoration",
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: "The Beast Within",
      ),
      ArrowWidget(
        startPosition: Position(row: 7, column: 2),
        endPosition: Position(row: 8, column: 2),
        lengthType: 'short',
        dependencyTalent: "Cobra Strikes",
      ),
  ], [
    ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'short',
        dependencyTalent: "Aimed Shot",
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: "Trueshot Aura",
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 2),
        endPosition: Position(row: 6, column: 2),
        lengthType: 'medium',
        dependencyTalent: "Improved Barrage",
      ),
      ArrowWidget(
        startPosition: Position(row: 7, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'short',
        dependencyTalent: "Silencing Shot",
      ),
  ], [
    ArrowWidget(
        startPosition: Position(row: 2, column: 0),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'medium',
        dependencyTalent: "Hunter vs. Wild",
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: "Counterattack",
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: "Wyvern Sting",
      ),
      ArrowWidget(
        startPosition: Position(row: 5, column: 0),
        endPosition: Position(row: 6, column: 0),
        lengthType: 'short',
        dependencyTalent: "Expose Weakness",
      ),
       ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 1),
        lengthType: 'short',
        dependencyTalent: "Noxious Stings",
      ),
       ArrowWidget(
        startPosition: Position(row: 6, column: 2),
        endPosition: Position(row: 9, column: 2),
        lengthType: 'long',
        dependencyTalent: "Hunting Party",
      ),
       ArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 10, column: 1),
        lengthType: 'medium',
        dependencyTalent: "Explosive Shot",
      ),
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
