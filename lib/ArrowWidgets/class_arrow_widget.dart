import 'package:wowtalentcalculator/ArrowWidgets/druid_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/paladin_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/priest_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/rogue_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/shaman_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/warlock_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/warrior_arrow.dart';

import 'hunter_arrow.dart';
import 'mage_arrow.dart';

getArrowClassByName(String className) {
  switch (className) {
    case 'warlock':
      return getWarlockArrowList();
      break;
    case 'druid':
      return getDruidArrowList();
      break;
    case 'hunter':
      return getHunterArrowList();
      break;
    case 'mage':
      return getMageArrowList();
      break;
    case 'paladin':
      return getPaladinArrowList();
      break;
    case 'priest':
      return getPriestArrowList();
      break;
    case 'rogue':
      return getRogueArrowList();
      break;
    case 'shaman':
      return getShamanArrowList();
      break;
    case 'warrior':
      return getWarriorArrowList();
      break;

    default:
      {
        //statements;
        return [[], [], []];
      }
      break;
  }
}
