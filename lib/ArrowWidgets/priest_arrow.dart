import 'package:wowtalentcalculator/ArrowWidgets/left_corner_arrow_widget.dart';
import 'package:wowtalentcalculator/ArrowWidgets/right_arrow_widget.dart';
import 'package:wowtalentcalculator/model/position.dart';

import 'arrow_widget.dart';

getPriestArrowList(String expansion) {
  var arrowListVanilla = [
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Divine Spirit',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Power Infusion',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Searing Light',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Lightwell',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 0),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'medium',
        dependencyTalent: 'Silence',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Shadowform',
      ),
      RightArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Improved Vampiric Embrace',
      ),
    ]
  ];
  var arrowListTbc = [
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Divine Spirit',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Power Infusion',
      ),
      RightArrowWidget(
        startPosition: Position(row: 4, column: 2),
        endPosition: Position(row: 4, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Improved Divine Spirit',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Searing Light',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Lightwell',
      )
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 0),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'medium',
        dependencyTalent: 'Silence',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Shadowform',
      ),
      RightArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Improved Vampiric Embrace',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Vampiric Touch',
      ),
    ]
  ];

  var arrowListWotlk = [[
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Soul Warding',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Power Infusion',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Searing Light',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Lightwell',
      )
    ],[
      RightArrowWidget(
        startPosition: Position(row: 0, column: 0),
        endPosition: Position(row: 0, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Improved Spirit Tap',
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 0),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'medium',
        dependencyTalent: 'Silence',
      ),
      RightArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Improved Vampiric Embrace',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Shadowform',
      ),
      LeftCornerArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Improved Shadowform',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Vampiric Touch',
      ),
      ArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 10, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Dispersion',
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
