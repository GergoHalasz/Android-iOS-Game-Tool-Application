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
        dependencyTalent: 'Ice Barrierg',
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
  return expansion == "tbc" ? arrowListTbc : arrowListVanilla;
}
