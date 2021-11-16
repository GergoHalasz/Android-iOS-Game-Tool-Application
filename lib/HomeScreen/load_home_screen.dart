import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/utils/methods.dart';
import 'home_screen.dart';

class LoadHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      druidTalentTrees: loadTalentString('druid'),
      hunterTalentTrees: loadTalentString('hunter'),
      mageTalentTrees: loadTalentString('mage'),
      paladinTalentTrees: loadTalentString('paladin'),
      priestTalentTrees: loadTalentString('priest'),
      rogueTalentTrees: loadTalentString('rogue'),
      shamanTalentTrees: loadTalentString('shaman'),
      warlockTalentTrees: loadTalentString('warlock'),
      warriorTalentTrees: loadTalentString('warrior'),
    );
  }
}
