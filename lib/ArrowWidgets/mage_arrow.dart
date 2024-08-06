import 'package:wowtalentcalculator/ArrowWidgets/left_arrow_widget.dart';
import 'package:wowtalentcalculator/ArrowWidgets/left_corner_arrow_widget.dart';
import 'package:wowtalentcalculator/ArrowWidgets/right_arrow_widget.dart';
import 'package:wowtalentcalculator/ArrowWidgets/right_corner_arrow_widget.dart';
import 'package:wowtalentcalculator/model/position.dart';

import 'arrow_widget.dart';

getMageArrowList(String expansion) {
  var arrowListVanilla = [
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Arcane Mind',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Arcane Instability',
      ),
      ArrowWidget(
        startPosition: Position(row: 5, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Arcane Power',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Blast Wave',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Combustion',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Shatter',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Ice Barrier',
      )
    ]
  ];
  var arrowListTbc = [
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'extralong',
        dependencyTalent: 'Arcane Potency',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Arcane Instability',
      ),
      ArrowWidget(
        startPosition: Position(row: 5, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Arcane Power',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Blast Wave',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Combustion',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: "Dragon's Breath",
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Shatter',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Ice Barrier',
      )
    ]
  ];

  var arrowListWotlk = [
    [
      RightCornerArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Arcane Potency',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Arcane Instability',
      ),
      ArrowWidget(
        startPosition: Position(row: 5, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Arcane Flows',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Arcane Flows',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Blast Wave',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Combustion',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: "Dragon's Breath",
      ),
      LeftArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 8, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Firestarter',
      )
    ],
    [
      LeftCornerArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Cold as Ice',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Ice Barrier',
      ),
      LeftArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 6, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Shattered Barrier',
      ),
      RightArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 8, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Enduring Winter',
      )
    ]
  ];

  var arrowListCata = [
    [
      LeftArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 2, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Arcane Flows',
      ),
       ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Missile Barrage',
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Arcane Tactics',
      ),
      RightArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Nether Vortex',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Arcane Power',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Improved Hot Streak',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Living Bomb',
      ),
    ],
    [
      RightArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 2, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Improved Freeze',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Deep Freeze',
      ),
      LeftArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Shattered Barrier',
      ),
      RightArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Reactive Barrier',
      ),
    ]
  ];

  arrowWidgetsClass() {
    if (expansion == "tbc")
      return arrowListTbc;
    else if (expansion == "vanilla")
      return arrowListVanilla;
    else if (expansion == 'cata')
      return arrowListCata;
    else
      return arrowListWotlk;
  }

  return arrowWidgetsClass();
}
