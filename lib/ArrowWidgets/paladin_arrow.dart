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

  var arrowListWotlk = [[
     ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 4, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Divine Favor',
      ),
       ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Holy Shock',
      ),
       ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 9, column: 1),
        lengthType: 'long',
        dependencyTalent: 'Infusion of Light',
      ),
  ], [
     ArrowWidget(
        startPosition: Position(row: 2, column: 0),
        endPosition: Position(row: 3, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Divine Guardian',
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
        dependencyTalent: 'Fanaticism',
      ),
       ArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 9, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Shield of the Templar',
      ),
  ], [
     ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'long',
        dependencyTalent: 'Vengeance',
      ),
       ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Fanaticism',
      ),
  ]];

  var arrowListCata = [[
     
       ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Speed of Light',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Tower of Radiance',
      ),
  ], [
       ArrowWidget(
        startPosition: Position(row: 2, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Shield of the Righteous',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 4, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Holy Shield', 
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Grand Crusader',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Sacred Duty',
      ),
  ], [
       ArrowWidget(
        startPosition: Position(row: 0, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Long Arm of the Law',
      ),
  ]];

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
