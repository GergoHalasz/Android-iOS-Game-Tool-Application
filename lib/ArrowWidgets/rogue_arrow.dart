import 'package:wowtalentcalculator/ArrowWidgets/right_corner_arrow_widget.dart';
import 'package:wowtalentcalculator/model/position.dart';

import 'arrow_widget.dart';

getRogueArrowList(String expansion) {
  var arrowListVanilla = [
    [
      ArrowWidget(
        startPosition: Position(row: 0, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Lethality',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Seal Fate',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Dual Wield Specialization',
      ),
      ArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 2, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Riposte',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Weapon Expertise',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Premeditation',
      ),
      RightCornerArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 4, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Dirty Deeds',
      )
    ]
  ];
  var arrowListTbc = [
    [
      ArrowWidget(
        startPosition: Position(row: 0, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Lethality',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Seal Fate',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Mutilate',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Dual Wield Specialization',
      ),
      ArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 2, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Riposte',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Weapon Expertise',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Surprise Attacks',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Premeditation',
      ),
      RightCornerArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 4, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Dirty Deeds',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Sinister Calling',
      ),
    ]
  ];

  var arrowListWotlk = [
      [
        ArrowWidget(
          startPosition: Position(row: 0, column: 2),
          endPosition: Position(row: 2, column: 2),
          lengthType: 'medium',
          dependencyTalent: 'Lethality',
        ),
        ArrowWidget(
          startPosition: Position(row: 4, column: 1),
          endPosition: Position(row: 5, column: 1),
          lengthType: 'short',
          dependencyTalent: 'Seal Fate',
        ),
        ArrowWidget(
          startPosition: Position(row: 6, column: 1),
          endPosition: Position(row: 8, column: 1),
          lengthType: 'medium',
          dependencyTalent: 'Mutilate',
        )
      ],
      [
        ArrowWidget(
          startPosition: Position(row: 0, column: 2),
          endPosition: Position(row: 2, column: 2),
          lengthType: 'medium',
          dependencyTalent: 'Close Quarters Combat',
        ),
        ArrowWidget(
          startPosition: Position(row: 1, column: 1),
          endPosition: Position(row: 2, column: 1),
          lengthType: 'short',
          dependencyTalent: 'Riposte',
        ),
        ArrowWidget(
          startPosition: Position(row: 4, column: 1),
          endPosition: Position(row: 5, column: 1),
          lengthType: 'short',
          dependencyTalent: 'Weapon Expertise',
        ),
        ArrowWidget(
          startPosition: Position(row: 6, column: 1),
          endPosition: Position(row: 8, column: 1),
          lengthType: 'medium',
          dependencyTalent: 'Surprise Attacks',
        ),
      ],
      [
        ArrowWidget(
          startPosition: Position(row: 4, column: 1),
          endPosition: Position(row: 6, column: 1),
          lengthType: 'medium',
          dependencyTalent: 'Premeditation',
        ),
        RightCornerArrowWidget(
          startPosition: Position(row: 2, column: 2),
          endPosition: Position(row: 4, column: 3),
          lengthType: 'medium',
          dependencyTalent: 'Hemorrhage',
        ),
        ArrowWidget(
          startPosition: Position(row: 6, column: 1),
          endPosition: Position(row: 7, column: 1),
          lengthType: 'short',
          dependencyTalent: 'Sinister Calling',
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
