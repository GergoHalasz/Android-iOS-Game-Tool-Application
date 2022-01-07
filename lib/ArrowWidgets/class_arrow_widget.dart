import 'package:wowtalentcalculator/ArrowWidgets/deathknight_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/druid_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/paladin_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/priest_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/rogue_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/shaman_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/warlock_arrow.dart';
import 'package:wowtalentcalculator/ArrowWidgets/warrior_arrow.dart';

import 'hunter_arrow.dart';
import 'mage_arrow.dart';

getArrowClassByName(String className, String expansion) {
  switch (className) {
    case 'warlock':
      return getWarlockArrowList(expansion);
      break;
    case 'druid':
      return getDruidArrowList(expansion);
      break;
    case 'hunter':
      return getHunterArrowList(expansion);
      break;
    case 'mage':
      return getMageArrowList(expansion);
      break;
    case 'paladin':
      return getPaladinArrowList(expansion);
      break;
    case 'priest':
      return getPriestArrowList(expansion);
      break;
    case 'rogue':
      return getRogueArrowList(expansion);
      break;
    case 'shaman':
      return getShamanArrowList(expansion);
      break;
    case 'warrior':
      return getWarriorArrowList(expansion);
      break;
    case 'deathknight':
      return getDeathKnightArrowList(expansion);
      break;
    default:
      {
        //statements;
        return [[], [], []];
      }
      break;
  }
}
