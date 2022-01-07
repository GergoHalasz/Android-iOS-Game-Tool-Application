import 'package:wowtalentcalculator/ArrowWidgets/left_corner_arrow_widget.dart';
import 'package:wowtalentcalculator/ArrowWidgets/right_arrow_widget.dart';
import 'package:wowtalentcalculator/ArrowWidgets/right_corner_arrow_widget.dart';
import 'package:wowtalentcalculator/model/position.dart';

import 'arrow_widget.dart';

getDruidArrowList(String expansion) {
  var arrowListVanilla = [
    [
      RightArrowWidget(
        startPosition: Position(row: 0, column: 1),
        endPosition: Position(row: 0, column: 2),
        lengthType: 'short',
        dependencyTalent: "Improved Nature's Grasp",
      ),
      ArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Vengeance',
      ),
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Omen of Clarity',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Moonfury',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Blood Frenzy',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Heart of the Wild',
      ),
      RightCornerArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Primal Fury',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 0),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'long',
        dependencyTalent: "Nature's Swiftness",
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Gift of Nature',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'long',
        dependencyTalent: 'Swiftmend',
      ),
    ]
  ];
  var arrowListTbc = [
    [
      RightArrowWidget(
        startPosition: Position(row: 0, column: 1),
        endPosition: Position(row: 0, column: 2),
        lengthType: 'short',
        dependencyTalent: "Improved Nature's Grasp",
      ),
      ArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 3, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Vengeance',
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Moonfury',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Heart of the Wild',
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Primal Fury',
      ),
      RightArrowWidget(
          startPosition: Position(row: 6, column: 1),
          endPosition: Position(row: 6, column: 2),
          lengthType: 'short',
          dependencyTalent: 'Improved Leader of the Pack'),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Mangle',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 0),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'medium',
        dependencyTalent: "Nature's Swiftness",
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Swiftmend',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'medium',
        dependencyTalent: 'Improved Regrowth',
      ),
      ArrowWidget(
        startPosition: Position(row: 7, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Tree of Life',
      ),
    ]
  ];

  var arrowListWotlk = [
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 2, column: 1),
        lengthType: 'short',
        dependencyTalent: "Nature's Grace",
      ),
      RightCornerArrowWidget(
        startPosition: Position(row: 1, column: 1),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'short',
        dependencyTalent: "Nature's Splendor",
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: "Typhoon",
      ),
      LeftCornerArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 0),
        lengthType: 'short',
        dependencyTalent: "Owlkin Frenzy",
      ),
      RightArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 6, column: 2),
        lengthType: 'short',
        dependencyTalent: "Improved Moonkin Form",
      ),
      RightArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 4, column: 2),
        lengthType: 'short',
        dependencyTalent: "Improved Insect Swarm",
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Primal Fury',
      ),
      RightCornerArrowWidget(
        startPosition: Position(row: 2, column: 2),
        endPosition: Position(row: 3, column: 3),
        lengthType: 'short',
        dependencyTalent: 'Primal Precision',
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 1),
        endPosition: Position(row: 5, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Heart of the Wild',
      ),
      RightArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 6, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Improved Leader of the Pack',
      ),
      LeftCornerArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 7, column: 0),
        lengthType: 'short',
        dependencyTalent: 'Protector of the Pack',
      ),
      ArrowWidget(
        startPosition: Position(row: 6, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Mangle',
      ),
      RightArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 8, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Improved Mangle',
      ),
      RightArrowWidget(
        startPosition: Position(row: 9, column: 1),
        endPosition: Position(row: 9, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Primal Gore',
      ),
    ],
    [
      ArrowWidget(
        startPosition: Position(row: 1, column: 2),
        endPosition: Position(row: 2, column: 2),
        lengthType: 'short',
        dependencyTalent: 'Master Shapeshifter',
      ),
      ArrowWidget(
        startPosition: Position(row: 2, column: 0),
        endPosition: Position(row: 4, column: 0),
        lengthType: 'medium',
        dependencyTalent: "Nature's Swiftness",
      ),
      ArrowWidget(
        startPosition: Position(row: 3, column: 2),
        endPosition: Position(row: 5, column: 2),
        lengthType: 'medium',
        dependencyTalent: "Nature's Bounty",
      ),
      ArrowWidget(
        startPosition: Position(row: 4, column: 1),
        endPosition: Position(row: 6, column: 1),
        lengthType: 'medium',
        dependencyTalent: "Swiftmend",
      ),
      RightArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 8, column: 2),
        lengthType: 'short',
        dependencyTalent: "Improved Tree of Life",
      ),
      ArrowWidget(
        startPosition: Position(row: 7, column: 1),
        endPosition: Position(row: 8, column: 1),
        lengthType: 'short',
        dependencyTalent: 'Tree of Life',
      ),
      ArrowWidget(
        startPosition: Position(row: 8, column: 1),
        endPosition: Position(row: 10, column: 1),
        lengthType: 'medium',
        dependencyTalent: 'Wild Growth',
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
